/*
 * rzscontrol - Control ramzswap devices
 *
 * Copyright (C) 2008, 2009  Nitin Gupta
 *
 * This code is released using a dual license strategy: BSD/GPL
 * You can choose the licence that better fits your requirements.
 *
 * Released under the terms of 3-clause BSD License
 * Released under the terms of GNU General Public License Version 2.0
 *
 * Project home: http://compcache.googlecode.com
 */

#include <errno.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <getopt.h>
#include <string.h>
#include <stdlib.h>
#include <inttypes.h>

#include "types.h"
#include "ramzswap_ioctl.h"

/* Flag set by '--verbose' */
static int verbose_flag;

/* /dev/ramzswapX */
#define MAX_DEVICE_NAME_LEN	32

/*
 * 10 decimal digits can represent 2^32.
 * All input sizes are in KB, so 10 digits are sufficient.
 */
#define MAX_SIZE_LEN	10

#define VERBOSE(args...) do {	\
	if (verbose_flag)	\
		printf(args);	\
} while (0)

struct rzs_args {
	char backing_swap[MAX_SWAP_NAME_LEN];
	u64 memlimit_kb;
	u64 disksize_kb;
	int init;
	int reset;
	int stats;
};

void usage(void)
{
	printf("Usage: rzscontrol {<ramzswap device>} [<options>]\n"
		"Example: rzscontrol /dev/ramzswap0 --init\n"
		"See rzscontrol manpage for details.\n");
}

void show_stats(struct ramzswap_ioctl_stats *s)
{
	int backing_swap_present = (s->backing_swap_name[0] != '\0');

	if (backing_swap_present)
		printf("BackingSwap:	%s\n", s->backing_swap_name);

#define K(x)	((x) >> 10)
	/* Basic stats */
	printf(
		"DiskSize:	%8" PRIu64 " kB\n",
		K(s->disksize)
	);

	/* memlimit is valid only if backing swap is present */
	if (backing_swap_present)
		printf("MemLimit:	%8" PRIu64 " kB\n", K(s->memlimit));

	/* Extended stats */
	printf(
		"NumReads:	%8" PRIu64 "\n"
		"NumWrites:	%8" PRIu64 "\n"
		"FailedReads:	%8" PRIu64 "\n"
		"FailedWrites:	%8" PRIu64 "\n"
		"InvalidIO:	%8" PRIu64 "\n"
		"NotifyFree:	%8" PRIu64 "\n"
		"ZeroPages:	%8u\n"
		"GoodCompress:	%8u %%\n"
		"NoCompress:	%8u %%\n"
		"PagesStored:	%8u\n"
		"PagesUsed:	%8u\n"
		"OrigDataSize:	%8" PRIu64 " kB\n"
		"ComprDataSize:	%8" PRIu64 " kB\n"
		"MemUsedTotal:	%8" PRIu64 " kB\n",
		s->num_reads,
		s->num_writes,
		s->failed_reads,
		s->failed_writes,
		s->invalid_io,
		s->notify_free,
		s->pages_zero,
		s->good_compress_pct,
		s->pages_expand_pct,
		s->pages_stored,
		s->pages_used,
		K(s->orig_data_size),
		K(s->compr_data_size),
		K(s->mem_used_total)
	);

	if (backing_swap_present) {
		printf(
			"BDevNumReads:	%8" PRIu64 "\n"
			"BDevNumWrites:	%8" PRIu64 "\n",
			s->bdev_num_reads,
			s->bdev_num_writes
		);
	}
}

int do_ioctl(int fd, int argc, struct rzs_args *args)
{
	int ret = 0;

/* Print an error message if ioctl fails */
#define ON_ERR(str) do {				\
	int err;					\
	if (ret == -1) {				\
		err = errno;				\
		printf("%s: %s\n", str, strerror(err));	\
		goto out;				\
	}						\
} while (0)

	while (argc--) {

	if (args->backing_swap[0] != '\0') {
		VERBOSE("backing_swap: %s\n", args->backing_swap);
		ret = ioctl(fd, RZSIO_SET_BACKING_SWAP, args->backing_swap);
		args->backing_swap[0] = '\0';
		ON_ERR("backing_swap");
	}

	if (args->memlimit_kb) {
		VERBOSE("memlimit_kb: %" PRIu64 "\n", args->memlimit_kb);
		ret = ioctl(fd, RZSIO_SET_MEMLIMIT_KB, &args->memlimit_kb);
		args->memlimit_kb = 0;
		ON_ERR("memlimit_kb");
	}

	if (args->disksize_kb) {
		VERBOSE("disksize_kb: %" PRIu64 "\n", args->disksize_kb);
		ret = ioctl(fd, RZSIO_SET_DISKSIZE_KB, &args->disksize_kb);
		args->disksize_kb = 0;
		ON_ERR("disksize_kb");
	}

	if (args->init) {
		ret = ioctl(fd, RZSIO_INIT);
		args->init = 0;
		ON_ERR("init");
	}

	if (args->reset) {
		ret = ioctl(fd, RZSIO_RESET);
		args->reset = 0;
		ON_ERR("reset");
	}

	if (args->stats) {
		struct ramzswap_ioctl_stats s;
		memset(&s, 0, sizeof(s));
		ret = ioctl(fd, RZSIO_GET_STATS, &s);
		args->stats = 0;
		ON_ERR("stats");
		show_stats(&s);
	}
	
	} /* while (argc--) */

out:
	return ret;
}

int main(int argc, char *argv[])
{
	int fd, ret, opt, idx;
	struct rzs_args args;
	char dev_name[MAX_DEVICE_NAME_LEN];
	
	if (argc < 3) {
		usage();
		exit(0);
	}

	memset(&args, 0, sizeof(args));

	strncpy(dev_name, argv[1], MAX_DEVICE_NAME_LEN - 1);
	dev_name[MAX_DEVICE_NAME_LEN - 1] = '\0';

	fd = open(dev_name, O_NONBLOCK);
	if (fd == -1) {
		ret = errno;
		printf("Failed to open %s: %s\n", dev_name, strerror(ret));
		return ret;
	}

	VERBOSE("device: %s\n", dev_name);

	ret = 0;
	while (1) {
		char *endptr = NULL;

		static struct option long_options[] = {
			{ "backing_swap", required_argument, 0, 'b' },
			{ "memlimit_kb", required_argument, 0, 'm' },
			{ "disksize_kb", required_argument, 0, 'd' },
			{ "init", no_argument, 0, 'i' },
			{ "reset", no_argument, 0, 'r' },
			{ "stats", no_argument, 0, 's' },
			{ "verbose", no_argument, NULL, 'v' },
			{ "help", no_argument, NULL, 'h' },
			{ NULL, no_argument, NULL, 0 }
		};

		opt = getopt_long(argc, argv, "m:d:b:irsvh", long_options, &idx);

		if (opt == -1)
			break;
		
		switch (opt) {
		case 'b':
			strncpy(args.backing_swap, optarg, MAX_SWAP_NAME_LEN - 1);
			args.backing_swap[MAX_SWAP_NAME_LEN - 1] = '\0';
			break;

		case 'm':
			if (strnlen(optarg, MAX_SIZE_LEN + 1) > MAX_SIZE_LEN) {
				printf("memlimit_kb: %s\n", strerror(EOVERFLOW));
				ret = -EOVERFLOW;
				goto out;
			}

			args.memlimit_kb = strtoul(optarg, &endptr, 10);
			break;

		case 'd':
			if (strnlen(optarg, MAX_SIZE_LEN + 1) > MAX_SIZE_LEN) {
				printf("disksize_kb: %s\n", strerror(EOVERFLOW));
				ret = -EOVERFLOW;
				goto out;
			}

			args.disksize_kb = strtoul(optarg, &endptr, 10);
			break;

		case 's':
			args.stats = 1;
			break;

		case 'i':
			args.init = 1;
			break;

		case 'r':
			args.reset = 1;
			break;

		case 'v':
			verbose_flag = 1;
			break;

		case 'h':
			usage();
			break;

		case '?':
			usage();
			ret = -EINVAL;
			goto out;

		default:
			/* We never reach here */
			break;
		}
	}

	ret = do_ioctl(fd, argc - 2, &args);

out:
	close(fd);
	return ret;
}

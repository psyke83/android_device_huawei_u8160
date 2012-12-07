#                                               -*- Autoconf -*-

# configure.ac -- Autoconf script for omxcore
#

# Process this file with autoconf to produce a configure script.

AC_PREREQ(2.61)
AC_INIT([omxcore],
	1.0.0)
AM_INIT_AUTOMAKE([-Wall -Werror gnu foreign])
AM_MAINTAINER_MODE
AC_CONFIG_SRCDIR([omxcore/src/common/qc_omx_core.c])
AC_CONFIG_HEADER([config.h])
AC_CONFIG_MACRO_DIR([m4])
OMXCORE_LIBRARY_NAME=OmxCore

#release versioning
OMXCORE_MAJOR_VERSION=1
OMXCORE_MINOR_VERSION=0
OMXCORE_MICRO_VERSION=0

OMXCORE_LIBRARY_VERSION=$OMXCORE_MAJOR_VERSION:$OMXCORE_MINOR_VERSION:$OMXCORE_MICRO_VERSION
AC_SUBST(OMXCORE_LIBRARY_VERSION)

# Checks for programs.
AC_PROG_CC
AC_PROG_CXX
AM_PROG_CC_C_O
AC_PROG_LIBTOOL
AC_PROG_AWK
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET

COMPILE_OMXCORE=yes
TARGET=

AC_ARG_ENABLE([target],
				AC_HELP_STRING([--enable-target=TARGET],[Specify the target(Supported targets:msm8660,msm7625,msm7627,msm7630,qsd8250,qsd8x50A,default).]),
				[],
				enable_target=none)

if test "x$enable_target" = "xmsm7625"; then
	TARGET=7625
elif test "x$enable_target" = "xmsm7627"; then
	TARGET=7627
elif test "x$enable_target" = "xmsm7630"; then
	TARGET=7630
elif test "x$enable_target" = "xqsd8250"; then
	TARGET=8250
elif test "x$enable_target" = "xmsm8660"; then
	TARGET=8660
elif test "x$enable_target" = "xqsd8x50A"; then
	TARGET=8x50A
elif test "x$enable_target" = "xdefault"; then
	TARGET=default
else
	AC_MSG_NOTICE(A valid target was not specified. Please check the '--enable-target' option.)
	COMPILE_OMXCORE=no
fi

AM_CONDITIONAL([COMPILE_OMXCORE], [test "x$COMPILE_OMXCORE" = "xyes"])
AC_SUBST([TARGET])
AC_CONFIG_FILES([     \
	Makefile \
	omxcore/Makefile \
	])
AC_OUTPUT


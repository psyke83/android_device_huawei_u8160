# ---------------------------------------------------------------------------------
#				MM-CORE-OSS-OMXCORE
# ---------------------------------------------------------------------------------

# Source Path
OMXCORE_SRC := $(SRCDIR)/omxcore

# cross-compiler flags
CFLAGS := -Wall 
CFLAGS += -Wundef 
CFLAGS += -Wstrict-prototypes 
CFLAGS += -Wno-trigraphs 

# cross-compile flags specific to shared objects
CFLAGS_SO := $(QCT_CFLAGS_SO)

# Preproc flags
CPPFLAGS := $(QCT_CPPFLAGS)
CPPFLAGS += -I$(OMXCORE_SRC)/inc
CPPFLAGS += -I$(OMXCORE_SRC)/src/common

# linker flags for shared objects
LDFLAGS_SO += -shared

# hard coding target for 7630
TARGET := 7630

# ---------------------------------------------------------------------------------
#					BUILD
# ---------------------------------------------------------------------------------

all: deploy_headers libOmxCore.so

# ---------------------------------------------------------------------------------
#				Deploy Headers
# ---------------------------------------------------------------------------------

deploy_headers:
	@mkdir -p $(SYSROOTINC_DIR)/mm-core
	@cp -f $(OMXCORE_SRC)/inc/*.h $(SYSROOTINC_DIR)/mm-core
# ---------------------------------------------------------------------------------
#				COMPILE LIBRARY
# ---------------------------------------------------------------------------------

SRCS := $(OMXCORE_SRC)/src/common/qc_omx_core.c
SRCS += $(OMXCORE_SRC)/src/$(TARGET)/qc_registry_table.c
SRCS += $(OMXCORE_SRC)/src/common/omx_core_cmp.cpp

LDLIBS := -lrt
LDLIBS += -lpthread

libOmxCore.so:$(SRCS)
	$(CC) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_SO) $(LDFLAGS_SO) -Wl,-soname,libOmxCore.so -o $@ $^ $(LDLIBS)

# ---------------------------------------------------------------------------------
#					END
# ---------------------------------------------------------------------------------

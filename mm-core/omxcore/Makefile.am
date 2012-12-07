# sources and intermediate files are separated

AM_CFLAGS = -Wall
AM_CFLAGS += -Wundef
AM_CFLAGS += -Wstrict-prototypes
AM_CFLAGS += -Wno-trigraphs
AM_CFLAGS += -g -O3
AM_CFLAGS += -O0 -fno-inline -fno-short-enums
AM_CFLAGS += -fPIC


AM_CPPFLAGS = -D__packed__=
AM_CPPFLAGS += -DIMAGE_APPS_PROC
AM_CPPFLAGS += -DFEATURE_Q_SINGLE_LINK
AM_CPPFLAGS += -DFEATURE_Q_NO_SELF_QPTR
AM_CPPFLAGS += -DFEATURE_LINUX
AM_CPPFLAGS += -DFEATURE_NATIVELINUX
AM_CPPFLAGS += -DFEATURE_DSM_DUP_ITEMS
AM_CPPFLAGS += -D_ENABLE_QC_MSG_LOG_
AM_CPPFLAGS += -DVERBOSE
AM_CPPFLAGS += -Iinc
AM_CPPFLAGS += -Isrc/common

h_sources  =inc/OMX_Audio.h
h_sources +=inc/OMX_Component.h
h_sources +=inc/OMX_ContentPipe.h
h_sources +=inc/OMX_Core.h
h_sources +=inc/OMX_Image.h
h_sources +=inc/OMX_Index.h
h_sources +=inc/OMX_IVCommon.h
h_sources +=inc/OMX_Other.h
h_sources +=inc/OMX_QCOMExtns.h
h_sources +=inc/OMX_Types.h
h_sources +=inc/OMX_Video.h
h_sources +=inc/qc_omx_common.h
h_sources +=inc/qc_omx_component.h
h_sources +=inc/qc_omx_msg.h
h_sources +=inc/QOMX_AudioExtensions.h
h_sources +=inc/QOMX_AudioIndexExtensions.h

c_sources  =src/common/omx_core_cmp.cpp
c_sources +=src/common/qc_omx_core.c
c_sources +=src/$(TARGET)/qc_registry_table.c

include_HEADERS = $(h_sources)
lib_LTLIBRARIES = libOmxCore.la
libOmxCore_la_SOURCES = $(c_sources)
libOmxCore_la_LDFLAGS = -lrt -lpthread -shared -version-info $(OMXCORE_LIBRARY_VERSION)

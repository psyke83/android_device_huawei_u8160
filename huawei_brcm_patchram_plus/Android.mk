ifeq ($(BOARD_HAVE_BLUETOOTH_BCM),true)

LOCAL_PATH:= $(call my-dir)

#
# brcm_patchram_plus.c
#

include $(CLEAR_VARS)

ifeq ($(TARGET_NEEDS_BLUETOOTH_INIT_DELAY),true)
LOCAL_CFLAGS += -DBCM_INIT_DELAY
endif

ifeq ($(BOARD_HAVE_SAMSUNG_BLUETOOTH),true)
    LOCAL_CFLAGS += -DSAMSUNG_BLUETOOTH
endif

ifeq ($(BOARD_HAVE_HUAWEI_BLUETOOTH),true)
    LOCAL_CFLAGS += -DHUAWEI_BLUETOOTH
endif

LOCAL_SRC_FILES := brcm_patchram_plus.c

LOCAL_MODULE := huawei_brcm_patchram_plus
LOCAL_MODULE_TAGS := optional

LOCAL_SHARED_LIBRARIES := libcutils liblog

LOCAL_C_FLAGS := \
	-DANDROID

include $(BUILD_EXECUTABLE)

endif

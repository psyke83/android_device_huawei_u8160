OMX_CORE_PATH := $(call my-dir)
include $(CLEAR_VARS)

ifneq ($(BOARD_USES_QCOM_HARDWARE),true)
include $(OMX_CORE_PATH)/omxcore/Android.mk
endif

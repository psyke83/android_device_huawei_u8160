LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := rzscontrol.c
#LOCAL_C_INCLUDES := external/compcache/sub-projects/include external/compcache

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := rzscontrol
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)

include $(BUILD_EXECUTABLE)

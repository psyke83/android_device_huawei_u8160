# Copyright (C) 2011 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PACKAGE_OVERLAYS += device/huawei/u8160/overlay

PRODUCT_PACKAGES += \
    copybit.msm7k \
    Gallery \
    gps.u8160 \
    gralloc.msm7k \
    libOmxCore \
    libOmxVidEnc \
    lights.msm7k \
    rzscontrol \
    screencap

# Recovery tools
PRODUCT_PACKAGES += \
    flash_image \
    dump_image \
    erase_image \
    make_ext4fs \
    e2fsck

# Hardware permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Keys
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/qwerty.kl:system/usr/keylayout/qwerty.kl

# Init files
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/init.u8160.rc:root/init.u8160.rc \
    device/huawei/u8160/prebuilt/ueventd.huawei.rc:root/ueventd.huawei.rc \
    device/huawei/u8160/prebuilt/etc/init.d/02getmacaddrs:system/etc/init.d/02getmacaddrs

# Wi-Fi related
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/wifi/firmware_apsta.bin:system/wifi/firmware_apsta.bin \
    device/huawei/u8160/prebuilt/wifi/firmware.bin:system/wifi/firmware.bin \
    device/huawei/u8160/prebuilt/wifi/nvram.txt:system/wifi/nvram.txt \
    device/huawei/u8160/prebuilt/wifi/dhd.ko:root/wifi/dhd.ko \
    device/huawei/u8160/prebuilt/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    device/huawei/u8160/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# Audio
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/etc/AudioFilter.csv:system/etc/AudioFilter.csv \
    device/huawei/u8160/prebuilt/etc/AutoVolumeControl.txt:system/etc/AutoVolumeControl.txt

# Compcache
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/modules/ramzswap.ko:system/lib/modules/ramzswap.ko

# Bluetooth
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/etc/bluetooth/audio.conf:system/etc/bluetooth/audio.conf \
    device/huawei/u8160/prebuilt/bin/brcm_patchram_plus:system/bin/brcm_patchram_plus

# Other
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/lib/egl/egl.cfg:system/lib/egl/egl.cfg \
    device/huawei/u8160/prebuilt/etc/sysctl.conf:system/etc/sysctl.conf \
    device/huawei/u8160/prebuilt/etc/vold.fstab:system/etc/vold.fstab

# Enable Google-specific location features,
# like NetworkLocationProvider and LocationCollector
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.locationfeatures=1 \
    ro.com.google.networklocation=1

# Extended JNI checks
# The extended JNI checks will cause the system to run more slowly, but they can spot a variety of nasty bugs 
# before they have a chance to cause problems.
# Default=true for development builds, set by android buildsystem.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.kernel.android.checkjni=0 \
    dalvik.vm.checkjni=false

# RIL properties
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libargs=-d/dev/smd0 \
    rild.libpath=/system/lib/libril-qc-1.so \
    ro.telephony.default_network=0 \
    ro.telephony.call_ring.delay=0 \
    ro.telephony.call_ring.multiple=false

# Networking properties
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=60

# Performance & graphics properties
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapsize=24m \
    persist.sys.purgeable_assets=1 \
    persist.sys.use_16bpp_alpha=1 \
    persist.sys.use_dithering=1 \
    ro.media.dec.jpeg.memcap=20000000 \
    ro.opengles.version=65537 \
    ro.sf.lcd_density=120 \
    ro.vold.umsdirtyratio=20

# Touchscreen properties
PRODUCT_PROPERTY_OVERRIDES += \
    view.fading_edge_length=8 \
    view.minimum_fling_velocity=25 \
    view.scroll_friction=0.008 \
    view.touch_slop=15

# Compcache properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.compcache.default=10

ifeq ($(TARGET_PREBUILT_KERNEL),)
    LOCAL_KERNEL := device/huawei/u8160/prebuilt/kernel
else
    LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product-if-exists, vendor/huawei/u8160/u8160-vendor.mk)

$(call inherit-product, build/target/product/full_base.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# LDPI assets
PRODUCT_LOCALES += ldpi mdpi

PRODUCT_NAME := huawei_u8160
PRODUCT_DEVICE := u8160
PRODUCT_MODEL := U8160
PRODUCT_BRAND := huawei
PRODUCT_MANUFACTURER := huawei

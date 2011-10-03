#
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

ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/huawei/u8160/prebuilt/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES += \
    libOmxCore \
    libOmxVidEnc \
    Gallery \
    gps.u8160 \
    copybit.u8160 \
    lights.msm7k \
    screencap

# Recovery tools
PRODUCT_PACKAGES += \
    flash_image \
    dump_image \
    erase_image \
    make_ext4fs \
    e2fsck

# Live Wallpapers
PRODUCT_PACKAGES += \
    librs_jni \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers

# Live Wallpapers support
PRODUCT_COPY_FILES += \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml

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

# Init files
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/init.u8160.rc:root/init.u8160.rc \
    device/huawei/u8160/prebuilt/ueventd.u8160.rc:root/ueventd.u8160.rc

# Wi-Fi related
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/wifi/firmware_apsta.bin:system/wifi/firmware_apsta.bin \
    device/huawei/u8160/prebuilt/wifi/firmware.bin:system/wifi/firmware.bin \
    device/huawei/u8160/prebuilt/wifi/nvram.txt:system/wifi/nvram.txt \
    device/huawei/u8160/prebuilt/wifi/dhd.ko:root/wifi/dhd.ko \
    device/huawei/u8160/prebuilt/etc/dhcpcd/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
    device/huawei/u8160/prebuilt/etc/wifi/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf

# RIL specific
PRODUCT_COPY_FILES += \
    vendor/huawei/u8160/proprietary/bin/qmuxd:system/bin/qmuxd \
    vendor/huawei/u8160/proprietary/bin/rild:system/bin/rild \
    vendor/huawei/u8160/proprietary/lib/libcm.so:system/lib/libcm.so \
    vendor/huawei/u8160/proprietary/lib/libdiag.so:system/lib/libdiag.so \
    vendor/huawei/u8160/proprietary/lib/libdll.so:system/lib/libdll.so \
    vendor/huawei/u8160/proprietary/lib/libdsm.so:system/lib/libdsm.so \
    vendor/huawei/u8160/proprietary/lib/libdss.so:system/lib/libdss.so \
    vendor/huawei/u8160/proprietary/lib/libgsdi_exp.so:system/lib/libgsdi_exp.so \
    vendor/huawei/u8160/proprietary/lib/libgstk_exp.so:system/lib/libgstk_exp.so \
    vendor/huawei/u8160/proprietary/lib/libmmgsdilib.so:system/lib/libmmgsdilib.so \
    vendor/huawei/u8160/proprietary/lib/libnv.so:system/lib/libnv.so \
    vendor/huawei/u8160/proprietary/lib/liboncrpc.so:system/lib/liboncrpc.so \
    vendor/huawei/u8160/proprietary/lib/libpbmlib.so:system/lib/libpbmlib.so \
    vendor/huawei/u8160/proprietary/lib/libqmi.so:system/lib/libqmi.so \
    vendor/huawei/u8160/proprietary/lib/libqueue.so:system/lib/libqueue.so \
    vendor/huawei/u8160/proprietary/lib/libril.so:system/lib/libril.so \
    vendor/huawei/u8160/proprietary/lib/libril.so:obj/lib/libril.so \
    vendor/huawei/u8160/proprietary/lib/libril-qc-1.so:system/lib/libril-qc-1.so \
    vendor/huawei/u8160/proprietary/lib/libril-qcril-hook-oem.so:system/lib/libril-qcril-hook-oem.so \
    vendor/huawei/u8160/proprietary/lib/libwms.so:system/lib/libwms.so \
    vendor/huawei/u8160/proprietary/lib/libwmsts.so:system/lib/libwmsts.so

# OEM RPC
PRODUCT_COPY_FILES += \
    vendor/huawei/u8160/proprietary/bin/modempre:system/bin/modempre \
    vendor/huawei/u8160/proprietary/bin/oem_rpc_svc:system/bin/oem_rpc_svc \
    vendor/huawei/u8160/proprietary/lib/libhwrpc.so:system/lib/libhwrpc.so \
    vendor/huawei/u8160/proprietary/lib/liboem_rapi.so:system/lib/liboem_rapi.so
    
# OMX
PRODUCT_COPY_FILES += \
    vendor/huawei/u8160/proprietary/lib/libmm-omxcore.so:system/lib/libmm-omxcore.so \
    vendor/huawei/u8160/proprietary/lib/libmm-adspsvc.so:system/lib/libmm-adspsvc.so \
    vendor/huawei/u8160/proprietary/lib/libOmxCore.so:system/lib/libOmxCore.so \
    vendor/huawei/u8160/proprietary/lib/libOmxH264Dec.so:system/lib/libOmxH264Dec.so \
    vendor/huawei/u8160/proprietary/lib/libOmxMpeg4Dec.so:system/lib/libOmxMpeg4Dec.so \
    vendor/huawei/u8160/proprietary/lib/libOmxVidEnc.so:system/lib/libOmxVidEnc.so \
    vendor/huawei/u8160/proprietary/lib/libOmxWmvDec.so:system/lib/libOmxWmvDec.so

# Hardware drivers
PRODUCT_COPY_FILES += \
    vendor/huawei/u8160/proprietary/lib/hw/gralloc.msm7k.so:system/lib/hw/gralloc.msm7k.so 

# Sensors
PRODUCT_COPY_FILES += \
    vendor/huawei/u8160/proprietary/bin/akmd8975:system/bin/akmd8975 \
    vendor/huawei/u8160/proprietary/lib/hw/sensors.default.so:system/lib/hw/sensors.default.so 

# Bluetooth
PRODUCT_COPY_FILES += \
    vendor/huawei/u8160/proprietary/etc/bluetooth/BCM4329.hcd:system/etc/bluetooth/BCM4329.hcd \
    vendor/huawei/u8160/proprietary/bin/brcm_patchram_plus:system/bin/brcm_patchram_plus

# Audio
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/etc/AudioFilter.csv:system/etc/AudioFilter.csv \
    device/huawei/u8160/prebuilt/etc/AudioFilterU8160.csv:system/etc/AudioFilterU8160.csv \
    device/huawei/u8160/prebuilt/etc/01_qc.cfg:system/etc/01_qc.cfg \
    vendor/huawei/u8160/proprietary/lib/libaudioeq.so:system/lib/libaudioeq.so

# Camera
PRODUCT_COPY_FILES += \
    vendor/huawei/u8160/proprietary/lib/libcamera.so:obj/lib/libcamera.so \
    vendor/huawei/u8160/proprietary/lib/libcamera.so:system/lib/libcamera.so \
    vendor/huawei/u8160/proprietary/lib/libqcamera.so:system/lib/libqcamera.so \
    vendor/huawei/u8160/proprietary/lib/libmmjpeg.so:system/lib/libmmjpeg.so \
    vendor/huawei/u8160/proprietary/lib/libmmipl.so:system/lib/libmmipl.so \
    vendor/huawei/u8160/proprietary/lib/libmmprocess.so:system/lib/libmmprocess.so

# Other
PRODUCT_COPY_FILES += \
    device/huawei/u8160/prebuilt/bin/mad2sd:system/bin/mad2sd \
    device/huawei/u8160/prebuilt/lib/egl/egl.cfg:system/lib/egl/egl.cfg \
    device/huawei/u8160/prebuilt/etc/sysctl.conf:system/etc/sysctl.conf \
    device/huawei/u8160/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    device/huawei/u8160/prebuilt/etc/init.d/02madteam:system/etc/init.d/02madteam \
    device/huawei/u8160/prebuilt/etc/init.d/05mountsd:system/etc/init.d/05mountsd

# Additions to build.prop
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.android.dataroaming=false \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.heapsize=24m \
    persist.sys.use_dithering=0 \
    persist.sys.purgeable_assets=1 \
    ring.delay=0 \
    ro.telephony.call_ring.delay=0 \
    ro.telephony.call_ring.multiple=false

$(call inherit-product, build/target/product/full_base.mk)

# Inherit some common cyanogenmod stuff.
$(call inherit-product, vendor/cyanogen/products/common_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

# Include GSM stuff
$(call inherit-product, vendor/cyanogen/products/gsm.mk)

# Broadcom FM radio
$(call inherit-product, vendor/cyanogen/products/bcm_fm_radio.mk)

$(call inherit-product-if-exists, vendor/huawei-u8160/u8160-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/huawei/u8160/overlay

# LDPI assets
PRODUCT_LOCALES += ldpi mdpi
PRODUCT_PACKAGE_OVERLAYS += vendor/cyanogen/overlay/ldpi
PRODUCT_COPY_FILES += \
    vendor/cyanogen/prebuilt/ldpi/media/bootanimation.zip:system/media/bootanimation.zip

PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=CyanogenMod-7.1.0-RC1-MADTEAM

PRODUCT_NAME := full_u8160
PRODUCT_BRAND := huawei
PRODUCT_DEVICE := u8160
PRODUCT_MODEL := u8160
PRODUCT_MANUFACTURER := huawei

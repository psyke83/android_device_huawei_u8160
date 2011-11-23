#!/bin/sh

# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSu8150E-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Extract prebuilt libraries (from a CM7 running device) needed for the U8150

DEVICE=u8160

mkdir -p ../../../vendor/huawei/$DEVICE/proprietary

DIRS="
bin
lib/hw
"

for DIR in $DIRS; do
	mkdir -p ../../../vendor/huawei/$DEVICE/proprietary/$DIR
done

FILES="
bin/akmd2
bin/akmd8962
bin/akmd8975
bin/brcm_patchram_plus
bin/qmuxd
bin/rild

lib/hw/gralloc.msm7k.so
lib/hw/sensors.default.so

lib/libaudioeq.so
lib/libcamera.so
lib/libcm.so
lib/libdiag.so
lib/libdll.so
lib/libdsm.so
lib/libdss.so
lib/libgsdi_exp.so
lib/libgstk_exp.so
lib/libmm-adspsvc.so
lib/libmmgsdilib.so
lib/libmmipl.so
lib/libmmjpeg.so
lib/libmm-omxcore.so
lib/libmmprocess.so
lib/libnv.so
lib/libOmxCore.so
lib/libOmxH264Dec.so
lib/libOmxMpeg4Dec.so
lib/libOmxVidEnc.so
lib/libOmxWmvDec.so
lib/liboncrpc.so
lib/libpbmlib.so
lib/libqcamera.so
lib/libqmi.so
lib/libqueue.so
lib/libril.so
lib/libril-qc-1.so
lib/libril-qcril-hook-oem.so
lib/libwms.so
lib/libwmsts.so
"

for FILE in $FILES; do
    adb pull system/$FILE ../../../vendor/huawei/$DEVICE/proprietary/$FILE
done

chmod 755 ../../../vendor/huawei/$DEVICE/proprietary/bin/* 

## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

# Inherit device configuration
$(call inherit-product, device/huawei/u8160/device_u8160.mk)

PRODUCT_NAME := cm_u8160
PRODUCT_RELEASE_NAME := U8160

-include vendor/cm/config/common_versions.mk

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := u8160

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=maguro BUILD_ID=ITL41D BUILD_FINGERPRINT=google/yakju/maguro:4.0.1/ITL41D/223971:user/release-keys

# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/Unihertz/Atom_LXL

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Define Dynamic Partition support
PRODUCT_TARGET_VNDK_VERSION := 30
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_EXTRA_VNDK_VERSIONS := 30
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_BUILD_PRODUCT_IMAGE := true

# Properties
PRODUCT_COMPATIBLE_PROPERTY_OVERRIDE := true

# A/B
AB_OTA_UPDATER := false

# Camera
PRODUCT_PACKAGES += \
    Aperture

# FMRadio
PRODUCT_PACKAGES += \
    ueventd.mt6771.rc \
    FMRadio \
    libfmcust

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# fstab
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/etc/fstab.mt6771:$(TARGET_COPY_OUT_RAMDISK)/fstab.mt6771

# NFC stack (AOSP)
PRODUCT_PACKAGES += \
    NfcNci

# ImsInit hack
PRODUCT_PACKAGES += \
    ImsInit

# Init
PRODUCT_PACKAGES += \
    init.mt6771.rc \
    fstab.mt6771

# Magisk
#PRODUCT_PACKAGES += \
#    99-magisk

# HardwareKeyMapper
PRODUCT_PACKAGES += \
    HardwareKeyMapper    

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/a2dp_in_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/a2dp_in_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/usb_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_configuration_bluetooth_legacy_hal.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_configuration_bluetooth_legacy_hal.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_configuration_stub.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_configuration_stub.xml \
    frameworks/av/services/audiopolicy/config/bluetooth_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/hearing_aid_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/hearing_aid_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_engine_configuration.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_default_stream_volumes.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_engine_default_stream_volumes.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_product_strategies.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_engine_product_strategies.xml \
    frameworks/av/services/audiopolicy/enginedefault/config/example/phone/audio_policy_engine_stream_volumes.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_policy_engine_stream_volumes.xml

PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/permissions/platform_unihertz.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/platform_unihertz.xml \
    $(DEVICE_PATH)/permissions/privapp-permissions-platform_unihertz.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-platform_unihertz.xml

PRODUCT_PACKAGES += \
    libbrotli \
    libhwbinder \
    libhidltransport \
    libaudioprocessing \
    libaudioflinger \
    libaudio-resampler \
    libaudiopolicyengineconfigurable \
    libaudiopolicyenginedefault \
    libsuspend \
    libsparse \
    libdrm \
    libpcap \
    libext2_blkid \
    libext2_com_err \
    libext2_e2p \
    libext2_uuid \
    libext2fs \
    libremote-processor \
    libparameter \
    libtextclassifier_hash \
    com.android.nfc_extras \
    android.hardware.audio.common-util \
    android.hardware.audio.common@2.0-util \
    android.hardware.audio.common@4.0 \
    android.hardware.audio.common@4.0-util \
    android.hardware.audio.common@5.0-util \
    android.hardware.audio.common@6.0 \
    android.hardware.audio.common@6.0-util \
    android.hardware.audio.effect@2.0 \
    android.hardware.audio.effect@4.0 \
    android.hardware.audio.effect@5.0 \
    android.hardware.audio.effect@6.0 \
    android.hardware.audio@2.0 \
    android.hardware.audio@4.0 \
    android.hardware.audio@5.0 \
    android.hardware.audio@6.0 \
    android.hardware.biometrics.fingerprint@2.1 \
    android.hardware.health@1.0 \
    android.hardware.health@2.0 \
    android.hardware.nfc@1.0 \
    android.hardware.nfc@1.1 \
    android.hardware.nfc@1.2 \
    android.hardware.radio.config@1.0 \
    android.hardware.radio.config@1.1 \
    android.hardware.radio.config@1.2 \
    android.hardware.radio@1.0 \
    android.hardware.radio@1.1 \
    android.hardware.radio@1.2 \
    android.hardware.radio@1.3 \
    android.hardware.radio@1.4 \
    android.hardware.radio@1.5 \
    android.hardware.soundtrigger@2.0 \
    android.hardware.soundtrigger@2.1 \
    android.hardware.soundtrigger@2.2

# Additional tools
PRODUCT_HOST_PACKAGES += \
    unpack_bootimg \
    lpmake   

# Keylayouts
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/idc/mtk-kpd.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-kpd.idc \
    $(DEVICE_PATH)/idc/mtk-pad.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/mtk-pad.idc \
    $(DEVICE_PATH)/keylayout/mtk-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-kpd.kl \
    $(DEVICE_PATH)/keylayout/mtk-tpd-kpd.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/mtk-tpd-kpd.kl \
    $(DEVICE_PATH)/keylayout/fingerprint_key.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/fingerprint_key.kl

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(DEVICE_PATH)/overlay \
    $(DEVICE_PATH)/overlay-lineage

# Overlays -- replace official
PRODUCT_PACKAGES += \
    FrameworkResOverlay

# Telephony Jars
PRODUCT_BOOT_JARS += \
    mediatek-common \
    mediatek-framework \
    mediatek-ims-base \
    mediatek-ims-common \
    mediatek-telecom-common \
    mediatek-telephony-base \
    mediatek-telephony-common

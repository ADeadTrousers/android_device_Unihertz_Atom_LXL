#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# GAPPS settings
# For examples see https://github.com/opengapps/aosp_build
# Here I only used the lowest set of apps including all overwrites according to "super" to save space
GAPPS_VARIANT := pico

GAPPS_FORCE_PACKAGE_OVERRIDES := true
GAPPS_FORCE_PIXEL_LAUNCHER := true
GAPPS_FORCE_MMS_OVERRIDES := true
GAPPS_FORCE_DIALER_OVERRIDES := true
GAPPS_FORCE_BROWSER_OVERRIDES := true
GAPPS_FORCE_WEBVIEW_OVERRIDES := true

GAPPS_PRODUCT_PACKAGES += \
    GoogleCamera \
    PrebuiltExchange3Google \
    PrebuiltGmail \
    Maps \
    Photos \
    GooglePrintRecommendationService \
    StorageManagerGoogle \
    TagGoogle \
    CalculatorGoogle \
    CalendarGooglePrebuilt \
    PrebuiltDeskClockGoogle \
    GoogleContacts \
    CarrierServices \
    LatinImeGoogle \
    GoogleTTS \
    Velvet

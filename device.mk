# SPDX-License-Identifier: Apache-2.0
LOCAL_PATH := device/xiaomi/alioth
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_USE_DYNAMIC_PARTITIONS := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
# Recovery prop.default must expose this even without mounting vendor.
PRODUCT_PROPERTY_OVERRIDES += ro.virtual_ab.enabled=true
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_PACKAGES += qcom_decrypt qcom_decrypt_fbe

# fastbootd
PRODUCT_PACKAGES += \
	android.hardware.fastboot@1.0-impl-mock \
	android.hardware.fastboot@1.0-impl-mock.recovery \
	fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health-service.qti \
    android.hardware.health-service.qti_recovery

# Official OFRP recovery-library inclusion/relink convention.
PRODUCT_SOONG_NAMESPACES += vendor/qcom/opensource/commonsys-intf/display
TARGET_RECOVERY_DEVICE_MODULES += android.system.suspend-V1-ndk android.hardware.gatekeeper@1.0 android.hardware.keymaster@4.0 android.hardware.keymaster@4.1 android.system.wifi.keystore@1.0 libion libxml2 libdisplayconfig.qti vendor.display.config@1.0 vendor.display.config@2.0
TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libion.so $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libdisplayconfig.qti.so $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.suspend-V1-ndk.so

# Alioth UFS slot control, following the maintained OrangeFox device tree.
PRODUCT_SOONG_NAMESPACES += device/xiaomi/alioth hardware/qcom/bootctrl hardware/qcom-caf/bootctrl
PRODUCT_PACKAGES += bootctrl.kona.recovery android.hardware.boot@1.1-impl-qti.recovery
PRODUCT_PROPERTY_OVERRIDES += vendor.gatekeeper.disable_spu=true vendor.usb.use_ffs_mtp=1

# Device-specific GUI capabilities; never applies to other OFRP targets.
PRODUCT_PROPERTY_OVERRIDES += ro.fox.alioth_safe_ui=1
PRODUCT_PROPERTY_OVERRIDES += ro.fox.display_refresh_rate=120

BOARD_RECOVERY_IMAGE_PREPARE += mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/system/lib64; ln -sf android.hardware.security.keymint-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.keymint-V1-ndk_platform.so; ln -sf android.hardware.security.secureclock-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.secureclock-V1-ndk_platform.so; ln -sf android.hardware.security.sharedsecret-V1-ndk.so $(TARGET_RECOVERY_ROOT_OUT)/system/lib64/android.hardware.security.sharedsecret-V1-ndk_platform.so;

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

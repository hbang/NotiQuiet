include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NotiQuiet
NotiQuiet_FILES = HBNQRootListController.m HBNQHeaderView.m
NotiQuiet_INSTALL_PATH = /Library/PreferenceBundles
NotiQuiet_FRAMEWORKS = UIKit MessageUI SocialUI CoreGraphics
NotiQuiet_PRIVATE_FRAMEWORKS = Preferences
NotiQuiet_LIBRARIES = MobileGestalt

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NotiQuiet.plist$(ECHO_END)

include theos/makefiles/common.mk

BUNDLE_NAME = NotiQuiet
NotiQuiet_FILES = ADNQListController.m
NotiQuiet_INSTALL_PATH = /Library/PreferenceBundles
NotiQuiet_FRAMEWORKS = UIKit
NotiQuiet_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/NotiQuiet.plist$(ECHO_END)

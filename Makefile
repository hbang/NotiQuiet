include theos/makefiles/common.mk

TWEAK_NAME = NotiQuiet
NotiQuiet_FILES = Tweak.xm
NotiQuiet_FRAMEWORKS = UIKit
SUBPROJECTS = prefs

LIBRARY_NAME = Toggle
Toggle_FILES = Toggle.mm
Toggle_INSTALL_PATH = /var/mobile/Library/SBSettings/Toggles/NotiQuiet

include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/library.mk

internal-stage::
	$(ECHO_NOTHING)echo " Compressing files..."$(ECHO_END)
	$(ECHO_NOTHING)find -L _/ -name "*.plist" -not -xtype l -print0|xargs -0 plutil -convert binary1;exit 0$(ECHO_END)
	$(ECHO_NOTHING)find -L _/ -name "*.png" -not -xtype l -print0|xargs -0 pincrush -i$(ECHO_END)
	$(ECHO_NOTHING)find -L _/ -name "*~" -delete$(ECHO_END)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotiQuiet
NotiQuiet_FILES = Tweak.xm HBNQSettingsManager.m
NotiQuiet_EXTRA_FRAMEWORKS = Cephei

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
ifeq ($(RESPRING),0)
	install.exec "killall Preferences"
else
	install.exec spring
endif

SUBPROJECTS += prefs
include $(THEOS_MAKE_PATH)/aggregate.mk

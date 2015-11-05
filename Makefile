THEOS_PACKAGE_DIR_NAME = debs
export TARGET = :clang
export ARCHS = armv7 armv7s arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotiQuiet
NotiQuiet_FILES = Tweak.xm HBNQSettingsManager.m

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += notiquiet
include $(THEOS_MAKE_PATH)/aggregate.mk

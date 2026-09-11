ARCHS = armv7 arm64

TARGET = iphone:clang:10.3:9.0  # iOS 10.3 SDK, iOS 9.0 build target
INSTALL_TARGET_PROCESSES = Discord

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ForceNineAPI
ForceNineAPI_FILES = \
    Tweak.x \
    Networking/API.x \
    Networking/WebSockets.x
ForceNineAPI_CFLAGS = -fobjc-arc
ForceNineAPI_FRAMEWORKS = Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
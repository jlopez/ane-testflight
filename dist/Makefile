################## SWF Config
APP_ID = $(EXT_ID).test
NAME = TestFlight
COMPANY = testflight
VERSION = 1.0

# To enable TestFlight upload define the following variables
TESTFLIGHT_API_TOKEN = API_TOKEN_GOES_HERE
TESTFLIGHT_TEAM_TOKEN = TEAM_TOKEN_GOES_HERE
TESTFLIGHT_DLS = DISTRIBUTION_LISTS
TESTFLIGHT_NOTIFY = False
WIKI_GIT_URL = git@github.com:jlopez/ane-testflight.wiki.git

SRCDIR = $(ROOT)/src/test
SRC_MAIN = $(SRCDIR)/test.mxml
APP_XML_IN = $(SRCDIR)/app.xml.in
ANES = $(ANE)
OTHER_RESOURCES = $(OBJC_NIBS)

################## ANE Config
EXT_ID = com.testflightapp.sdk
ANE_IOS_LIB_SOURCES = $(call findcfiles,../src/ios) ../src/ios/testflight/libTestFlight.a
ANE_IOS_LIB_CFLAGS = -I../src/ios/ane/src -I../src/ios/testflight
ANE_BUNDLED_LIBS = $(NATIVE_LIBRARY_LIB)

NATIVE_LIBRARY_LIB = libNativeLibrary.a
NATIVE_LIBRARY_LIB_SOURCES = $(call findcfiles,../src/ios/ane/src)

include mk/ane.mk


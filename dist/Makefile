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

HOCKEY_APP_APP_ID = b934b747432005a12d2b8f55f4aed8b5

SRCDIR = $(ROOT)/src/test
SRC_MAIN = $(SRCDIR)/test.mxml
APP_XML_IN = $(SRCDIR)/app.xml.in
ANES = $(ANE) ../lib/ane/dist/nativelibrary.ane
OTHER_RESOURCES = $(OBJC_NIBS)

################## ANE Config
EXT_ID = com.testflightapp.sdk
ANE_IOS_LIB_SOURCES = $(call findcfiles,../src/ios) ../src/ios/testflight/libTestFlight.a
ANE_IOS_LIB_CFLAGS = -I../lib/ane/src/ios -I../src/ios/testflight
ANE_BUNDLED_LIBS = $(NATIVE_LIBRARY_LIB)

NATIVE_LIBRARY_LIB = libNativeLibrary.a
NATIVE_LIBRARY_LIB_SOURCES = $(call findcfiles,../lib/ane/src/ios)

ANDROID_SRC_SEARCH_PATHS = src/main/java src

ANE_ANDROID_JAR_API = 11
ANE_ANDROID_JAR_SOURCES = ../src/android ../lib/hockey-sdk-android
ANE_ANDROID_JAR_CLASSPATH = $(NATIVE_LIBRARY_JAR)

NATIVE_LIBRARY_JAR = nativeLibrary.jar
NATIVE_LIBRARY_JAR_SOURCES = ../lib/ane/src/android

include mk/ane.mk

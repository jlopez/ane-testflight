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

SRCDIR = $(ROOT)/src/test
SRC_MAIN = $(SRCDIR)/test.mxml
APP_XML_IN = $(SRCDIR)/app.xml.in
ANES = $(ANE)
OTHER_RESOURCES =

################## ANE Config
OBJC_SRCDIRS = ../src/ios ../src/ios/ane
OBJC_INCLDIRS = ../src/ios/ane ../src/ios/testflight
OBJC_XIBDIRS =

include mk/ane.mk

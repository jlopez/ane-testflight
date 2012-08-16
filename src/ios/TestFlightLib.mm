//
//  TestFlightLib.mm
//  TestFlightLib
//
//  Created by Jesus Lopez on 04/30/2012
//  Copyright (c) 2012 JLA. All rights reserved.
//
#import "NativeLibrary.h"
#import "TestFlight.h"


@interface TestFlightLib : NativeLibrary {
}

@end


@implementation TestFlightLib

FN_BEGIN(TestFlightLib)
  FN(addCustomEnvironmentInformation, addCustomEnvironmentInformation:forKey:)
  FN(setDeviceIdentifier, setDeviceIdentifier)
  FN(takeOff, takeOff:)
  FN(passCheckpoint, passCheckpoint:)
  FN(openFeedbackView, openFeedbackView)
  FN(submitFeedback, submitFeedback:)
  FN(setOptions, setOptions:)
  FN(log, log:)
FN_END

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  NSBundle *bundle = [NSBundle mainBundle];
  if ([[bundle objectForInfoDictionaryKey:@"TFSetDeviceIdentifier"] boolValue])
    [self setDeviceIdentifier];

  NSString *teamToken = [bundle objectForInfoDictionaryKey:@"TFTeamToken"];
  if (teamToken)
    [self takeOff:teamToken];

  return YES;
}

- (void)addCustomEnvironmentInformation:(NSString *)information forKey:(NSString *)key {
  [TestFlight addCustomEnvironmentInformation:information forKey:key];
}

- (void)setDeviceIdentifier {
  [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
}

- (void)takeOff:(NSString *)teamToken {
  [TestFlight takeOff:teamToken];
}

- (void)passCheckpoint:(NSString *)checkpoint {
  [TestFlight passCheckpoint:checkpoint];
}

- (void)openFeedbackView {
  [TestFlight openFeedbackView];
}

- (void)submitFeedback:(NSString *)feedback {
  [TestFlight submitFeedback:feedback];
}

- (void)setOptions:(NSDictionary *)opts {
  [TestFlight setOptions:opts];
}

- (void)log:(NSString *)msg {
  TFLog(@"%@", msg);
}

@end

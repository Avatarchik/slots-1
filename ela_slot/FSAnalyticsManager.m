//
//  FSAnalyticsManager.m
//  FSAnalytics
//
//  Created by Eddy Fan on 2/16/16.
//  Copyright © 2016 Fantapstic Studio. All rights reserved.
//

#import "FSAnalyticsManager.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import <Google/Analytics.h>

#define TRACKER [[GAI sharedInstance] defaultTracker]
#define ResetTrackerScreenName()  [TRACKER set:kGAIScreenName value:nil]

@implementation FSAnalyticsManager

+ (void)setupWithTrackingID:(NSString*) trackingID dispatchInterval:(NSUInteger) dispatchInterval sampleRate:(float) sampleRate
{
    // Configure tracker from GoogleService-Info.plist.
    NSError *configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    // trackUncaughtExceptions – Tracking uncaught exceptions will flag up any exceptions that you are not dealing with that have caused your application to crash.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // logLevel – Google Analytics iOS SDK has 4 logging levels: kGAILogLevelError, kGAILogLevelWarning, kGAILogLevelInfo, and kGAILogLevelVerbose. Verbose logging enables all of the various types of log output and prints it to the console in Xcode. This is extremely useful when you first start using Google Analytics for iOS as it lets you see what is going on under the hood.
    [[GAI sharedInstance].logger setLogLevel:kGAILogLevelVerbose];
    
    // dispatchInterval – By default, this is set to 120, which states that tracking information should be dispatched (uploaded to Google Analytics) automatically every 120 seconds. In this tutorial you will set this to a shorter time period so that you can see the data in your Google Analytics dashboard without having to wait for a prolonged period of time. In a production environment every 120 seconds should be often enough.
    [GAI sharedInstance].dispatchInterval = dispatchInterval;
    
//    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingID];
//    
//    // Set bundle version.
//    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
//    [tracker set:kGAIAppVersion value:version];
//    
//    // Set Sample Rate.
//    NSString* sampleRateString = [NSString stringWithFormat:@"%f", sampleRate];
//    [tracker set:kGAISampleRate value:sampleRateString];
}

+ (void) trackUserID:(NSString*) userID{
    [[[GAI sharedInstance] defaultTracker] set:kGAIUserId value: userID];
}

+ (void) trackScreenView: (NSString*) screenName{
    
    NSLog(@"Track screen view: %@", screenName);
    if(screenName == nil || [screenName isEqualToString:@""])
    {
        NSLog(@"FSAnalyticsManager - screenName nil");
    }
    // Set tracker screenname.
    [[[GAI sharedInstance] defaultTracker] set:kGAIScreenName value:screenName];
    
    // Send tracker dictionary.
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createScreenView] build]];
    
    ResetTrackerScreenName();
}


+ (void) trackEventWithCategory:(NSString*) category action:(NSString*) action label:(NSString*) label value:(NSNumber*) value screenName:(NSString*) screenName{
    
    NSLog(@"trackCategory: %@::%@::%@::%@::%@", category, action, label, value, screenName);
    if(category == nil || action == nil || screenName == nil)
    {
        NSLog(@"FSAnalyticsManager - trackCategory:(NSString*) category action:(NSString*) action label:(NSString*) label value:(NSNumber*) value screenName:(NSString*) screenName - nil parameter");
    }
    
    // Set tracker screenname.
    [[[GAI sharedInstance] defaultTracker] set:kGAIScreenName value:screenName];
    
    // Send tracker dictionary.
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createEventWithCategory:category
                                                          action:action
                                                           label:label
                                                           value:value] build]];
    
    // Unset tracker screename.
    ResetTrackerScreenName();
}



+(void)trackIAP:(NSString *)transactionID name:(NSString *)name SKU:(NSString *)SKU category:(NSString *)category price:(NSNumber *)price quantity:(NSNumber *)quantity currencyCode:(NSString *)currentCode{
    
    if(transactionID == nil || name == nil || SKU == nil || price == nil || quantity == nil || currentCode == nil )
    {
        NSLog(@"FSAnalyticsManager - trackIAP:(NSString *)transactionID name:(NSString *)name SKU:(NSString *)SKU category:(NSString *)category price:(NSNumber *)price quantity:(NSNumber *)quantity currencyCode:(NSString *)currentCode - nil parameter");
    }
    
    // Unset tracker screename.
    ResetTrackerScreenName();
}

@end

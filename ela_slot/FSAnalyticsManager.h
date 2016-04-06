//
//  FSAnalyticsManager.h
//  FSAnalytics
//
//  Created by Eddy Fan on 2/16/16.
//  Copyright © 2016 Fantapstic Studio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FSAnalyticsManager : NSObject

// Setup analytics.
+ (void) setupWithTrackingID:(NSString*)    trackingID
            dispatchInterval:(NSUInteger)   dispatchInterval
                  sampleRate:(float)        sampleRate;


// You only need to set User ID on a tracker once. By setting it on the tracker, the ID will be
// sent with all subsequent hits.
+ (void) trackUserID:(NSString*) userID;

// Track a screen view.
+ (void) trackScreenView:(NSString*)        screenName;

// Track an event.
+ (void) trackEventWithCategory:(NSString*) category
                         action:(NSString*) action
                          label:(NSString*) label
                          value:(NSNumber*) value
                     screenName:(NSString*) screenName;


// Track an IAP.
+ (void) trackIAP:(NSString*)               transactionID
             name:(NSString*)               name
              SKU:(NSString*)               SKU
         category:(NSString*)               category
            price:(NSNumber*)               price
         quantity:(NSNumber*)               quantity
     currencyCode:(NSString*)               currentCode;

@end

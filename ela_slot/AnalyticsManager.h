//
//  AnalyticsManager.h
//  
//
//  Created by Eddy Fan on 2/20/16.
//
//

#import <Foundation/Foundation.h>
@class AnalyticsManager;
@interface AnalyticsManager : NSObject

+(AnalyticsManager*) sharedManager;


// Setup analytics.
- (void) setupWithDispatchInterval:(NSUInteger)   dispatchInterval
                  sampleRate:(float)        sampleRate
                      userID:(NSString*)    userID;


// UI
-(void) trackScreenView:(NSString*) screenView;
-(void) trackButtonTap:(NSString*) buttonName;
-(void) trackButtonTap:(NSString*) buttonName value:(NSNumber*) value;
-(void) trackScreenTapPoint:(CGPoint) tapPoint;
-(void) trackScreenTapPoint:(CGPoint) tapPoint screen:(NSString*) screenView;
-(void) trackPopoverPresenter;

// Gameplay
-(void) trackWin:(CGFloat)winAmount screenName:(NSString*) screenName;
-(void) trackLevelUp:(NSUInteger) level;
-(void) trackSpin:(NSInteger) bet lines:(NSUInteger) lines boost:(NSUInteger) boost;

-(void) trackBonusMiniGame;
-(void) trackScatterFreeSpins:(NSInteger) freeSpins;

- (void) trackIAP:(NSString*)               transactionID
             name:(NSString*)               name
              SKU:(NSString*)               SKU
         category:(NSString*)               category
            price:(NSNumber*)               price
         quantity:(NSNumber*)               quantity
     currencyCode:(NSString*)               currentCode;

@end

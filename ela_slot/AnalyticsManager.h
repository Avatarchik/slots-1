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

// UI
-(void) trackScreenView:(NSString*) screenView;
-(void) trackButtonTap:(NSString*) buttonName;
-(void) trackButtonTap:(NSString*) buttonName value:(NSNumber*) value;
-(void) trackScreenTapPoint:(CGPoint) tapPoint;
-(void) trackScreenTapPoint:(CGPoint) tapPoint screen:(NSString*) screenView;
-(void) trackPopoverPresenter;

// Gameplay
-(void) trackWin;
-(void) trackLevelUp:(NSUInteger) level;
-(void) trackSpin:(NSInteger) bet lines:(NSUInteger) lines boost:(NSUInteger) boost;

@end

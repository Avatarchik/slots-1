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
-(void) trackPopoverPresenter;
-(void) trackButtonTap:(NSString*) buttonName;
//-(void) trackScreenTapPoint:(CGPoint) tapPoint;

// Gameplay
//-(void) trackSpin:(NSInteger) bet lines:(NSUInteger) lines boost:(NSUInteger) boost;
//-(void) trackWin;
//-(void) trackLevelUp:(NSUInteger) level;




@end

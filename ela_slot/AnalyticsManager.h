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

-(void) trackScreenView:(NSString*) screenView;
-(void) trackPopoverPresenter;

@end

//
//  AnalyticsManager.m
//  
//
//  Created by Eddy Fan on 2/20/16.
//
//

#import "AnalyticsManager.h"
#import "NodeNames.h"
#import <FSAnalytics/FSAnalytics.h>


@interface AnalyticsManager()

@property (nonatomic, strong) NSString* previousPopupPresenter;
@property (nonatomic, strong) NSString* currentScreenView;

@end

@implementation AnalyticsManager

+(AnalyticsManager*) sharedManager{
    static AnalyticsManager* analyticsManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        analyticsManager = [AnalyticsManager new];
    });
    
    return analyticsManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.previousPopupPresenter = @"";
    }
    return self;
}


-(NSArray*) popoverPresenters {
    return @[kNodeLobby, kNodeSlot];
}

-(void) trackPopoverPresenter {
    [self trackScreenView:self.previousPopupPresenter];
}



/******************************************************
 */
#pragma mark - Track Screen
/*
 ********************************************************/
-(void)trackScreenView:(NSString *)screenView{
    if(screenView == nil)
    {
        NSLog(@"AnalyticsManager - trackScreenView - nil");
        return;
    }
    
    if([[self popoverPresenters] containsObject:screenView])
    {
        self.previousPopupPresenter = screenView;
    }
    
    [FSAnalyticsManager trackScreenView:screenView];
    self.currentScreenView = screenView;
}



/******************************************************
 */
#pragma mark - Track User Interaction
/*
 ********************************************************/

// Track a tap on screen.
-(void) trackScreenTapPoint:(CGPoint) tapPoint{
    [self trackScreenTapPoint:tapPoint screen:self.currentScreenView];
}

// Track a tap on screen and screen view
-(void) trackScreenTapPoint:(CGPoint) tapPoint screen:(NSString*) screenView{
    NSString* category = @"UX";
    NSString* action = @"Screen_Tap";
    NSString* label = NSStringFromCGPoint(tapPoint);
    NSNumber* valueNumber = nil;
    [FSAnalyticsManager trackEventWithCategory:category action:action label:label value:valueNumber screenName:screenView];
}

// Track a button tap with name and value.
-(void)trackButtonTap:(NSString *)buttonName value:(NSNumber*) value{
    if(buttonName == nil)
    {
        NSLog(@"AnalyticManager - trackButtonTap:value - nil");
    }
    NSString* category = @"UX";
    NSString* action = @"Button_Tap";
    NSString* label = buttonName;
    NSNumber* valueNumber = value;
    NSString* screenName = self.currentScreenView;
    [FSAnalyticsManager trackEventWithCategory:category action:action label:label value:valueNumber screenName:screenName];
}

// Track a button tap with name.
-(void)trackButtonTap:(NSString *)buttonName{
    [self trackButtonTap:buttonName value:nil];
}




@end

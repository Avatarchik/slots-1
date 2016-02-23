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

-(void)trackButtonTap:(NSString *)buttonName{
    if(buttonName == nil)
    {
        NSLog(@"AnalyticManager - trackButtonTap - nil");
    }
    NSString* category = @"UX";
    NSString* action = @"buttontap";
    NSString* label = buttonName;
    NSNumber* value = nil;
    NSString* screenName = self.currentScreenView;
    [FSAnalyticsManager trackEventWithCategory:category action:action label:label value:value screenName:screenName];
}




@end

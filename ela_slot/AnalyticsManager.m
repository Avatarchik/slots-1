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

@end

@implementation AnalyticsManager

+(AnalyticsManager*) sharedManager{
    static AnalyticsManager* analMan;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        analMan = [AnalyticsManager new];
    });
    
    return analMan;
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
    return @[kNodeLobby, kNodeMenu, kNodeSlot];
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
    
    
    //TODO: see if screenview is a popup presenter and store as self.previousPopPresenter
    [FSAnalyticsManager trackScreenView:screenView];
}

@end

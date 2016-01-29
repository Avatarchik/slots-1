//
//  AppDelegate.h
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SpecialBonus.h"
#import <Chartboost/Chartboost.h>
#import <Pushwoosh/PushNotificationManager.h>
#import "GameViewController.h"


#define APPDELEGATE (AppDelegate*)[[UIApplication sharedApplication] delegate]
#define GAMEVIEWCONTROLLER (GameViewController*)[(AppDelegate*)[[UIApplication sharedApplication] delegate] gameViewController]
@interface AppDelegate : UIResponder <UIApplicationDelegate, ChartboostDelegate, PushNotificationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SpecialBonus *SB;
@property (readonly, nonatomic) GameViewController* gameViewController;

-(void)setSPECIALBONUS:(SpecialBonus*)sb_;
-(BOOL)inMenu;
-(SpecialBonus*)getSpecialBonus;



@end




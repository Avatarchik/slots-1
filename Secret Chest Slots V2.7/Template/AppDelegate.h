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

@interface AppDelegate : UIResponder <UIApplicationDelegate, ChartboostDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SpecialBonus *SB;



-(void)setSPECIALBONUS:(SpecialBonus*)sb_;

-(BOOL)inMenu;

-(SpecialBonus*)getSpecialBonus;

-(void)setLocalPush:(NSDate*)date withText:(NSString*)text_ value:(NSString*)value_ forKey:(NSString*)key_;

@end


//
//
//
//#import <UIKit/UIKit.h>
//#import "cocos2d.h"
//#import "SpecialBonus.h"
//#import <Chartboost/Chartboost.h>
//#import <Pushwoosh/PushNotificationManager.h>
//
//// Added only for iOS 6 support
//@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
//@end
//
//@interface AppController : NSObject <UIApplicationDelegate, ChartboostDelegate,PushNotificationDelegate>
//{
//	UIWindow *window_;
//	MyNavigationController *navController_;
//	
//	CCDirectorIOS	*director_;							// weak ref
//    
//    SpecialBonus *SB;
//    
//}
//
//@property (nonatomic, retain) UIWindow *window;
//@property (readonly) MyNavigationController *navController;
//@property (readonly) CCDirectorIOS *director;
//
//-(void)setSPECIALBONUS:(SpecialBonus*)sb_;
//
//-(BOOL)inMenu;
//
//-(SpecialBonus*)getSpecialBonus;
//
//-(void)setLocalPush:(NSDate*)date withText:(NSString*)text_ value:(NSString*)value_ forKey:(NSString*)key_;
//
//@end

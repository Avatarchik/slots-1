//
//  AppDelegate.mm
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "Lobby.h"
#import "Menu.h"
#import "BBXBeeblex.h"
#import "ALSdk.h"
#import "cfg.h"

#import "b6luxLoadingView.h"
#import <Chartboost/Chartboost.h>
#import <CommonCrypto/CommonDigest.h>
#import <AdSupport/AdSupport.h>
#import "IDSTOREPLACE.h"

@implementation AppDelegate

-(GameViewController *)gameViewController{
    UIViewController* rootVC = self.window.rootViewController;
    if([rootVC isKindOfClass:[GameViewController class]])
    {
        return (GameViewController*) rootVC;
    }
    return  nil;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Create the main window
	
    [Chartboost startWithAppId:chartBoostAppID
                  appSignature:chartBoostAppSignature
                      delegate:self];
    [ALSdk initializeSdk];
    [Chartboost cacheInterstitial:CBLocationHomeScreen];
    [Chartboost cacheInterstitial:CBLocationGameOver];
    [Chartboost cacheRewardedVideo:CBLocationMainMenu];
    [Chartboost cacheMoreApps:CBLocationHomeScreen];
	
    //lots of your initialization code
    
    if ([shoudlStartPushWoosh  isEqual: @YES]) {
        NSLog(@"STARTING PUSHWOOSH!");
        //-----------PUSHWOOSH PART-----------
        // set custom delegate for push handling, in our case - view controller
        PushNotificationManager * pushManager = [PushNotificationManager pushManager];
        pushManager.delegate = self;
        
        // handling push on app start
        [[PushNotificationManager pushManager] handlePushReceived:launchOptions];
        
        // make sure we count app open in Pushwoosh stats
        [[PushNotificationManager pushManager] sendAppOpen];
        
        // register for push notifications!
        [[PushNotificationManager pushManager] registerForPushNotifications];
        

    }
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    application.applicationIconBadgeNumber = 0;
    
    // Handle launching from a notification
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    if (localNotif) {
        /*
         NSLog(@"[ didFinishLaunchingWithOptions ] : Recieved Notification %@",localNotif);
         NSDictionary *info = localNotif.userInfo;
         NSLog(@"DICT IN PUSH %@",info);
         NSString *key = [[info allKeys] objectAtIndex:0];
         NSLog(@"KEY %@",key);
         */
    }

    return YES;
    
}
// system push notification registration success callback, delegate to pushManager
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[PushNotificationManager pushManager] handlePushRegistration:deviceToken];
}

// system push notification registration error callback, delegate to pushManager
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [[PushNotificationManager pushManager] handlePushRegistrationFailure:error];
}

// system push notifications callback, delegate to pushManager
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[PushNotificationManager pushManager] handlePushReceived:userInfo];
}

- (void)didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward {
    [self.SB reedemCoinReward];
}

-(void)didCacheRewardedVideo:(CBLocation)location{
    NSLog(@"****************CHARTBOOST VIDEO CACHED**********************");
}
-(void)didCacheInterstitial:(CBLocation)location{
       NSLog(@"***************CHARTBOOST INTERSTITIAL CACHED**********************");
}
-(void)didFailToLoadRewardedVideo:(CBLocation)location withError:(CBLoadError)error{
    if (error==CBLoadErrorNoAdFound) {
        NSLog(@"****************CHARTBOOST VIDEO FAILED TO CACHE, ERROR: NO AD FOUND**********************");
    }else{
        NSLog(@"****************CHARTBOOST VIDEO FAILED TO CACHE, unknow error**********************");

    }
    
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
#warning EF maybe pause scene.
//	if( [navController_ visibleViewController] == director_ )
//		[director_ pause];
    
    
}

-(BOOL)inMenu{
    
#warning EF write - bool is Lobby is currently on screen.
    return YES;
//    CCScene *scene = [director_ runningScene];
//    
//    for (CCNode *n in scene.children)
//    {
//        if (n.tag == 999 && [n isKindOfClass:[Lobby class]]){
//            return YES;
//        }
//    }
//    return NO;
}

-(SpecialBonus*)getSpecialBonus{
    
    return self.SB;
    
}

-(void)setSPECIALBONUS:(SpecialBonus*)sb_{
    
    self.SB = sb_;
    
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
#warning EF resume sk scene if paused
//	if( [navController_ visibleViewController] == director_ )
//		[director_ resume];
    
    
    if([self.gameViewController.scene isKindOfClass:[Lobby class]])
    {
//        Lobby* lobby = (Lobby*) self.gameViewController.scene;
//        [lobby UPDATE_SPECIAL_BONUS];
        [self.SB UPDATE_ME];
            //[SB updateBonusLabel];
    }

    
    [GC_ authenticateLocalPlayer];
    application.applicationIconBadgeNumber = 0;
}

-(void)startPlayMusic{
    
//    if ([self inMenu]) {
//        [SOUND_ playMusic:@"menu.mp3" looping:YES fadeIn:YES];
//        SOUND_.musicVolume = 0.5f;
//    }

   
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
    #warning EF - maybe add spritekit pause here?
//	if( [navController_ visibleViewController] == director_ )
//		[director_ stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
#warning EF - maybe add spritekit pause here?
//	if( [navController_ visibleViewController] == director_ )
//		[director_ startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
//	CC_DIRECTOR_END();
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
//	[[CCDirector sharedDirector] purgeCachedData];
}


// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
    #warning EF - whats this used for?
}

//- (void) dealloc
//{
////	[window_ release];
////	[navController_ release];
//	
//	[super dealloc];
//}
@end


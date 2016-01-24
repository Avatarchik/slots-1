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
//    
//    CCDirectorIOS* director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
//	CCGLView *glView = [CCGLView viewWithFrame:[[UIScreen mainScreen] bounds]
//								   pixelFormat:kEAGLColorFormatRGB565
//								   depthFormat:0
//							preserveBackbuffer:NO
//									sharegroup:nil
//								 multiSampling:NO
//							   numberOfSamples:0];
//
//	// Enable multiple touches
//	[glView setMultipleTouchEnabled:NO];
//
//	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
//
//	director_.wantsFullScreenLayout = YES;
//
//	// Display FSP and SPF
//	[director_ setDisplayStats:NO];
//
//	// set FPS at 60
//	[director_ setAnimationInterval:1.0/60];
//	
//	// attach the openglView to the director
//	[director_ setView:glView];
    return YES;
    
    
//    
//    
//    
//    
//	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
//								   pixelFormat:kEAGLColorFormatRGB565
//								   depthFormat:0
//							preserveBackbuffer:NO
//									sharegroup:nil
//								 multiSampling:NO
//							   numberOfSamples:0];
//
//	// Enable multiple touches
//	[glView setMultipleTouchEnabled:NO];
//
//	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
//	
//	director_.wantsFullScreenLayout = YES;
//	
//	// Display FSP and SPF
//	[director_ setDisplayStats:NO];
//	
//	// set FPS at 60
//	[director_ setAnimationInterval:1.0/60];
//	
//	// attach the openglView to the director
//	[director_ setView:glView];
//	
//	// 2D projection
//	[director_ setProjection:kCCDirectorProjection2D];
//	//	[director setProjection:kCCDirectorProjection3D];
//	
//	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
//	if( ! [director_ enableRetinaDisplay:YES] )
//		CCLOG(@"Retina Display Not supported");
//	
//	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
//	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
//	// You can change anytime.
//	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
//	
//	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
//	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
//	// On iPad     : "-ipad", "-hd"
//	// On iPhone HD: "-hd"
//	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
//	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
//	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
//	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
//	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
//	
//	// Assume that PVR images have premultiplied alpha
//	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
//	
//	// Create a Navigation Controller with the Director
//	navController_ = [[MyNavigationController alloc] initWithRootViewController:director_];
//	navController_.navigationBarHidden = YES;
//	
//	// for rotation and other messages
//	[director_ setDelegate:navController_];
//	
//	// set the Navigation Controller as the root view controller
//	[window_ setRootViewController:navController_];
//	
//	// make main window visible
//	[window_ makeKeyAndVisible];
//    
//    //local pushes
//    
//    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
//    
//    application.applicationIconBadgeNumber = 0;
//	
//	// Handle launching from a notification
//	UILocalNotification *localNotif =
//	[launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
//    
//    if (localNotif) {
//        /*
//		NSLog(@"[ didFinishLaunchingWithOptions ] : Recieved Notification %@",localNotif);
//        NSDictionary *info = localNotif.userInfo;
//        NSLog(@"DICT IN PUSH %@",info);
//        NSString *key = [[info allKeys] objectAtIndex:0];
//        NSLog(@"KEY %@",key);
//         */
//  
//	}
//
//
////    [BBXBeeblex initializeWithAPIKey:@"NWQyMmI0YTdlZmM2MDMwNTg2MjUwNmM4NzJkYjJmZWIyMWIxNzU4NDUxMGE1ZjQ4NTIyNWRiNWJiYmIzZTYxZWExNGZmZDE1MTI5MzU4ODNiNjllNjI4NzkzZjlmZTE2ZGU0ODZlNjllZDVjZjQ5NzQwMTBlOTBlNzVkNTYzNTcsLS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUEyTzdjbFhwQUZuL1NOTmpydHUxdwpOdWJWWGdpT1gxck5jRkMwampCVGhuVkVmY1RpV1FFa3ArWldFOVdveHdtc2FMNW5MNnZGYnIrUlpxbG9hdm16ClBueGRvVVlLamYvYnY0cStxQ0ZZd1NMQ25aQ0Flb2ppditKOUdaL0N2YlB6aUFIQ3ArN1AyTGhEUWw4Vk1qZVQKQndVZkt6NTRHWGZQTG5VZ05mNkFtS3AvNlNHT0hnTFlDb2IrSEJBRklJQnQvY2NweXRDenlPKzVtb1d0N2FrWQo3WG1JRmR6b2NkTnh3YkdJK3Y3cnpGLzJtbUk3TDFqbmVXWGw2MUJKcmIyT1dmSFVPcTBmUDBHWmRTdXZ5YUxICjZuNjdKaE9meURoZW5RaUd4cHBLcU5wRkQvZ3BtWVNadGpYN3drZE5RM3hOd0x5Rjd1YjBMV3JORnFUWXA5ZlEKYlFJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t"];
//	
//	return YES;
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
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
#warning EF resume sk scene if paused
//	if( [navController_ visibleViewController] == director_ )
//		[director_ resume];
    
    
  //  NSLog(@"running scene is %@. children %@",[director_ runningScene],[[director_ runningScene]children]);

    
#warning EF - rewrite, if the scene's Lobby is a child, then UPdate SB
//    
//    CCScene *scene = [director_ runningScene];
//    
//    for (CCNode *n in scene.children)
//    {
//        if (n.tag == 999 && [n isKindOfClass:[Lobby class]]){
//            //[(Lobby*)n UPDATE_SPECIAL_BONUS];
//            [self.SB UPDATE_ME];
//            //[SB updateBonusLabel];
//        }
//    }
//    
    [GC_ authenticateLocalPlayer];
    
    application.applicationIconBadgeNumber = 0;
    
    //check animation
    
    [self animationLoadingCheck];
    
    //[self performSelector:@selector(startPlayMusic) withObject:nil afterDelay:1.f];
    
}

-(void)animationLoadingCheck{
    
#warning EF -rewrite this.  it checks to see if the loading screen is up.  if it is, the loading screen is removed from view and another view is shown. Moved to GameViewControler?
    
//
//    BOOL wasRunning = NO;
//    
//    for (UIView *a in [[[CCDirector sharedDirector] openGLView]subviews]) {
//        if ([a viewWithTag:kLOADINGTAG]) {
//            [[a viewWithTag:kLOADINGTAG]removeFromSuperview];
//            wasRunning = YES;
//        }
//    }
//    
//    if (wasRunning) {
//        UIView *view__ = [[[b6luxLoadingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) loading:kLOADING_PURCHASE]autorelease];
//        view__.tag = kLOADINGTAG;
//        [[[CCDirector sharedDirector] openGLView]addSubview:view__];
//    }
    
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


#import "SpecialBonus.h"
#import "cfg.h"
#import "TopMenu.h"
#import "Menu.h"
#import "Combinations.h"
#import <Chartboost/Chartboost.h>
#import "IDSTOREPLACE.h"
#import "SKNode+SKNode_Extensions.h"

#define kFullWaiTime            10800
#define kNotiftime              86400
#define kPushText               @"Special Bonus is ready. Come and get it!"
#define kPushTextNotif          @"Hey, don't forget to take your special bonus"
//#define kButtonBlinkActionTag    10
#define kButtonBlinkActionKey    @"kButtonBlinkActionKey"


@interface SpecialBonus()

@property (nonatomic, strong) SKSpriteNode* specBackground;
@property (nonatomic, strong) SKSpriteNode* grille;
@property (nonatomic, strong) SKSpriteNode* progress_line;
@property (nonatomic, strong) SKSpriteNode* button;
@property (nonatomic, strong) SKSpriteNode* Coin;
@property (nonatomic, assign) int Coins;

@property (nonatomic, strong) SKTexture* Btn_Active;
@property (nonatomic, strong) SKTexture* Btn_notActive;

@property (nonatomic, strong) SKLabelNode* TIME_LEFT_LABEL;
@property (nonatomic, strong) SKLabelNode* NO_CONNECTION_LABEL;
@property (nonatomic, strong) SKLabelNode* SBonusLabel;

@end



@implementation SpecialBonus{
    
    BOOL canTouch;
    int timeLeft;
    
//    CCLabelBMFont *self.TIME_LEFT_LABEL;
//    CCLabelBMFont *self.NO_CONNECTION_LABEL;
//    CCLabelBMFont       *self.SBonusLabel;
    
    
    
    
}

-(id)initWithRect:(CGRect)rect kProgress:(int)progress_ bonusValue:(int)bonus_;
{
    if((self = [super init]))
    {
        self.name = kNodeSpecialBonus;
        int plus = 150;
        int machinemaxNr = [Exp checMaxMachineWithLevelNr:kLEVEL];  //1;
        
        self.Coins = 200+(plus*machinemaxNr);
        self.size = CGSizeMake(kWidthScreen, kHeightScreen);
        
        // Add background node
        self.specBackground              = [SKSpriteNode spriteNodeWithImageNamed:@"bonus_background.png"];
        self.specBackground.anchorPoint  = ccp(0.5f, 0);
        self.specBackground.position     = ccp(kWidthScreen/2, 0);
        [self addChildToTopZ:self.specBackground];
        
        // Cache some textures
        self.Btn_Active          = [SKTexture textureWithImageNamed:@"btn_get_active.png"];
        self.Btn_notActive       = [SKTexture textureWithImageNamed:@"btn_get.png"];
        
        b1 = false;
        
        [self addProgress];
        [self addTxtLabel];
        [self addButton];
        
        //custom
        [self addTimeLeftLabel];
        
        [self UPDATE_ME];
        
        NSString *name = (IS_IPAD) ? @"Coins_fly" : @"Coins_fly_iPhone";
        
#warning EF this should a be an animation I believe
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",name]];
        
        self.Coin = [SKSpriteNode spriteNodeWithImageNamed:@"Coin_flat.png"];
        self.Coin.anchorPoint = ccp(0.5f, 0.5f);
        self.Coin.position = ccp(self.progress_line.position.x + self.progress_line.size.width *0.4f, self.progress_line.position.y);
        self.Coin.scale = IS_IPAD ? ([Combinations isRetina]) ? 0.7f : 0.4f    : ([Combinations isRetina]) ? 0.4f : 0.4f ;
        self.Coin.hidden = NO;
        [self addChildToTopZ:self.Coin];
        if (self.Coins > 1000) {
            self.Coin.position = ccpAdd(self.Coin.position, ccp(-self.Coin.size.width*0.25f, 0));
        }
    }
    
    return self;
}

-(void)internetCheckingUpdate:(ccTime)dt{
    
    [self UPDATE_ME];
    
}

-(void)UPDATE_ME{
    
    canTouch = NO;
    
    self.button.alpha = 100/255.0;    //  first always should be small opacity, later change

   // NSLog(@"Must update special bonus %@",self);
    
    [self changeSpecialBonusStateTo:state_connecting];
    
    if (![Combinations connectedToInternet])
    {
        //NSLog(@"No connection in bonus window");
        // make state no connection
        [self changeSpecialBonusStateTo:state_notconnected];
#warning EF
//        [self unschedule:@selector(internetCheckingUpdate:)];
//        [self schedule:@selector(internetCheckingUpdate:) interval:0.3f];
        return;
    }
//    else {
//        [self changeSpecialBonusStateTo:state_connected];
//    }
    
    [self changeSpecialBonusStateTo:state_connecting];
    
#warning EF
//    [self unschedule:@selector(internetCheckingUpdate:)];
    
    //check if it was no connection state -
    
    
    // generate uniq id if it's not created     //save to DB - Not nsdefaut
    if  ([self MY_ID]==nil ||
        [[self MY_ID] isEqualToString:@""])
    {
        NSString *s = [cfg GENERATE_ME_UNIQID];
        [Combinations saveNSDEFAULTS_String:s forKey:kUSER_UNIQE_IDE];
    }
    
    //begin server check for time
    if ([self canDisplayAD]) {
        [self CHECKFORBONUS_SS];
        if([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
            [self changeSpecialBonusStateTo:state_canTakeBonus];
        }else{
            [self changeSpecialBonusStateTo:state_waitingForbonus];
        }
        // [self changeSpecialBonusStateTo:state_canTakeBonus];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
            if([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
                [self changeSpecialBonusStateTo:state_canTakeBonus];
            }else{
                [self changeSpecialBonusStateTo:state_waitingForbonus];
            }
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
                if([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
                    [self changeSpecialBonusStateTo:state_canTakeBonus];
                }else{
                    [self changeSpecialBonusStateTo:state_waitingForbonus];
                }
            }
            
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
                if([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
                    [self changeSpecialBonusStateTo:state_canTakeBonus];
                }else{
                    [self changeSpecialBonusStateTo:state_waitingForbonus];
                }
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
                if([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
                    [self changeSpecialBonusStateTo:state_canTakeBonus];
                }else{
                    [self changeSpecialBonusStateTo:state_waitingForbonus];
                }
            }
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self canDisplayAD]) {
                if([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
                    [self changeSpecialBonusStateTo:state_canTakeBonus];
                }else{
                    [self changeSpecialBonusStateTo:state_waitingForbonus];
                }
            }
        });
        

    }
        [self updateBonusLabel];
}

-(NSString*)MY_ID{
    return [Combinations getNSDEFAULTS_String:kUSER_UNIQE_IDE];
}

-(void)CHECKFORBONUS_SS{
#warning EF this isnt implemented.
    return;
    
    __block NSString *timleftState = nil;
    
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
           // NSLog(@"loading bonus time from server...");
            
        });
  
        
        NSString *uniqid = [self MY_ID];
      //  NSLog(@"Uniq id was created : %@",uniqid);
        
        timleftState = [cfg SS_CHECK_BONUSTIMEFOR:uniqid];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            //NSLog(@"FINISHED SERVER time left %@",timleftState);
            
            if ([timleftState integerValue]==0 && timleftState != nil){
                //enalbe self.buttons press etc;
                [self changeSpecialBonusStateTo:state_canTakeBonus];
                
            }
            else if ([timleftState integerValue] > 0 && timleftState != nil){
                timeLeft = [timleftState integerValue];
                [self changeSpecialBonusStateTo:state_waitingForbonus];
#warning EF not used
//                [self schedule:@selector(specialBonusTimeUpdate:) interval:1.f];
            }
            else{
             //   NSLog(@"error !");
                [self changeSpecialBonusStateTo:state_connectionError];
                [self UPDATE_ME];
            }

        });
        
    });
  

    
}
-(int) updateTimeLeftStillNextAddInSeconds{
    NSDate* now = [NSDate date];
    NSDate* lastAdWatched = [[NSUserDefaults standardUserDefaults] objectForKey:@"AdWatchedDate"];
    
    NSTimeInterval secondsBetween = [now timeIntervalSinceDate:lastAdWatched];
    
    if (secondsBetween>[minutesBetweenAds integerValue]*60) {
        secondsBetween = 0;
    }
    
    return secondsBetween;
}
-(BOOL) canDisplayAD{
    NSDate* now = [NSDate date];
    NSDate* lastAdWatched = [[NSUserDefaults standardUserDefaults] objectForKey:@"AdWatchedDate"];
    if (!lastAdWatched)
    {
        return  YES;
    }
    //NSComparisonResult result = [now compare:lastAdWatched];
    
    NSTimeInterval secondsBetween = [now timeIntervalSinceDate:lastAdWatched];
    if (secondsBetween > [minutesBetweenAds integerValue]*60 /* && result == NSOrderedDescending*/) {
        return YES;
    }
    return NO;
    
}
-(NSString*) getTimeLeftStillNextAddString{
    int rawseconds = ([minutesBetweenAds integerValue]*60)-[self updateTimeLeftStillNextAddInSeconds];
    
    int hours = rawseconds / 3600;
    int minutes = (rawseconds-(hours*3600)) / 60;
    int seconds = rawseconds - ((hours*3600)+(minutes*60));
    
    return [NSString stringWithFormat:@"%i:%i:%i",hours,minutes,seconds];
}
-(void) updateBonusLabel{
    if(![self canDisplayAD]){
        [self changeSpecialBonusStateTo:state_waitingForbonus];
        self.progress_line.alpha = 0.0;
        self.TIME_LEFT_LABEL.text = [self getTimeLeftStillNextAddString];
    }else{
        if ([self canDisplayAD]) {
            if([Chartboost hasRewardedVideo:CBLocationMainMenu]) {
                [self changeSpecialBonusStateTo:state_canTakeBonus];
            }else{
                [self changeSpecialBonusStateTo:state_waitingForbonus];
            }
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self updateBonusLabel];
    });
}

-(void)GET_BONUS_SS{
    
    float oldscale = self.progress_line.xScale;

    self.progress_line.xScale = 0.0;

    if (![Combinations connectedToInternet]) {
      //  NSLog(@"Warning! Could not get bonus - check internet connection");
        return;
    }
    
    __block BOOL gavedBonus = NO;
    
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self changeSpecialBonusStateTo:state_connecting];
            
         //   NSLog(@"loading geting bonus...");
            // MUST SHOW LOADING HERE
            
        });
        
        gavedBonus = [cfg SS_TAKE_BONUS_FOR:[self MY_ID]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (gavedBonus) {
               // NSLog(@"Successfully gaved the bonus!  Reset all special bonus window settings");
                [self changeSpecialBonusStateTo:state_waitingForbonus];
                
                timeLeft = kFullWaiTime;
                [self specialBonusTimeUpdate:0.1f];
                
#warning EF
//                [self unschedule:@selector(specialBonusTimeUpdate:)];
//                [self schedule:@selector(specialBonusTimeUpdate:) interval:1.f];
                
                //save push
                
                [self saveLocalPushSettings];
                
                //
                    //GIVE self.CoinS HERE
                //
                
                
            }
            else if (!gavedBonus){
               // NSLog(@"Error getting bonus");
                [self UPDATE_ME];
            }
            
            
        });
        
    });

}

-(void)changeSpecialBonusStateTo:(int)state_{
    

    [self.button removeActionForKey:kButtonBlinkActionKey];
    
    self.Coin.hidden = NO;
    self.TIME_LEFT_LABEL.position = self.grille.position;
    
    if (state_ == state_notconnected){
        self.progress_line.alpha = 50/255.0;
        self.progress_line.xScale = 0.0;
        
//        [self unschedule:@selector(specialBonusTimeUpdate:)];
        self.TIME_LEFT_LABEL.hidden = NO;
        
#warning EF stop animation if exists on NO_CONNETION_LABEL
        self.NO_CONNECTION_LABEL.hidden = YES;

        // must show not connected to internet itp
    }
    
    //    else if(state_ == state_connected){
    //        self.progress_line.opacity = 255;
    //        self.NO_CONNECTION_LABEL.hidden = NO;
    //        self.progress_line.opacity = 50;
    //        self.progress_line.xScale = 0;
    //        [self.TIME_LEFT_LABEL setString:@"Connecting..."];
    //    }
    
    else if (state_ == state_waitingForbonus){
        canTouch = NO;
        self.progress_line.alpha = 255/255.0;
        self.TIME_LEFT_LABEL.text = @"Not available";
        
        self.button.alpha = 100/255.0;
        self.TIME_LEFT_LABEL.hidden = YES;
        self.NO_CONNECTION_LABEL.hidden = NO;
        
    }
    else if (state_ == state_canTakeBonus){
        canTouch = YES;
        self.progress_line.alpha = 255/255.0;
        self.button.alpha = 255/255.0;
        self.progress_line.xScale = 1;
        self.TIME_LEFT_LABEL.hidden = YES;
        self.Coin.hidden = YES;
        self.TIME_LEFT_LABEL.position = ccp(self.grille.position.x + self.grille.size.width*(IS_IPAD ? 0.1f : 0.2f), self.grille.position.y);
        self.TIME_LEFT_LABEL.text = [NSString stringWithFormat:@"%i",self.Coins];
        self.NO_CONNECTION_LABEL.hidden = NO;
#warning EF
//        [self unschedule:@selector(specialBonusTimeUpdate:)];
        [self getBonusButtonEffect];
    }
    if (state_ == state_connectionError){
        self.progress_line.alpha = 50/255.0;
        self.TIME_LEFT_LABEL.hidden = NO;
        self.NO_CONNECTION_LABEL.hidden = YES;
#warning EF
//        [self unschedule:@selector(specialBonusTimeUpdate:)];
    }
    if (state_ == state_connecting)
    {
        self.TIME_LEFT_LABEL.text = @"Connecting";
        self.button.alpha = 1.0;
        self.progress_line.xScale = 0;
#warning EF
//        [self unschedule:@selector(specialBonusTimeUpdate:)];
    }
    
}

-(void)saveLocalPushSettings{
    
    NSDate *now =[NSDate date];
    now = [now dateByAddingTimeInterval:kFullWaiTime];
    
    [self setLocalPush:now  withText:kPushText value:@"Yes" forKey:@"id_local"];

}

-(void)setLocalPush:(NSDate*)date withText:(NSString*)text_ value:(NSString*)value_ forKey:(NSString*)key_{
    
    //NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	
	// Get the current date
    
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = date;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
	
	// Notification details
    localNotif.alertBody = text_;
	// Set the action self.button
    localNotif.alertAction = @"View";
	
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
	
	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:value_ forKey:key_];
    localNotif.userInfo = infoDict;
	
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
	// Handle the notificaton when the app is running
    app.applicationIconBadgeNumber = 0;
    
	NSLog(@"[didReceiveLocalNotification] : Recieved Notification %@",notif);
    
    NSDictionary *info = notif.userInfo;
    NSLog(@"DICT IN PUSH %@",info);
    NSString *key = [[info allKeys] objectAtIndex:0];
    NSLog(@"KEY %@",key);
    
}

-(void)specialBonusTimeUpdate:(float)dt{
//-(void)specialBonusTimeUpdate:(ccTime)dt{
    
    timeLeft--;
    float progress = (float)((timeLeft*100)/kFullWaiTime)/100;    //(kFullWaiTime - timeLeft)/100;
    self.progress_line.xScale = 1-progress;
    
    NSString *stringTime = [NSString stringWithFormat:@"%02li:%02li:%02li",
                            lround(floor(timeLeft / 3600.)) % 100,
                            lround(floor(timeLeft / 60.)) % 60,
                            lround(floor(timeLeft)) % 60];
    
    self.TIME_LEFT_LABEL.text = stringTime;
    
    if (timeLeft <= 0) {
        timeLeft = 0;
        [self changeSpecialBonusStateTo:state_canTakeBonus];
#warning EF
//        [self unschedule:@selector(specialBonusTimeUpdate:)];
    }
    
}



-(void)getCoins
{
    UIAlertView* view = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Earn %i Coins!",self.Coins] message:[NSString stringWithFormat:@"Would you like to watch a video for %i Coins?", self.Coins] delegate:self cancelButtonTitle:@"No thanks" otherButtonTitles:@"Watch now", nil];
    [view show];
   
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
       // [self GET_BONUS_SS];
        [Chartboost showRewardedVideo:CBLocationMainMenu];
    }
}
-(void) reedemCoinReward{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"AdWatchedDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    float Coins_ = [DB_ getValueBy:d_Coins table:d_DB_Table];
    float finalCoins = Coins_ + self.Coins;
    [DB_ updateValue:d_Coins table:d_DB_Table :finalCoins];

    // Tell Menu to play coin animation.
    Menu* menu = (Menu*)[(SKScene*)GAMEVIEWCONTROLLER.scene childNodeWithName:kNodeMenu];
    if(menu)
    {
        [menu coinAnimation:self.Coins];
    }
    
    // Tell TopMenu to add coins.
    TopMenu *topMenu = (TopMenu *)[(SKScene*)GAMEVIEWCONTROLLER.scene childNodeWithName:kNodeTopMenu];
    if(topMenu)
    {
        [topMenu addCoins:self.Coins];
    }
    canTouch = NO;
    self.Coin.alpha = 0.0;
    //[self updateBonusLabel];
}

-(void)getBonusButtonEffect{
    SKAction* scale1 = [SKAction scaleTo:0.2 duration:1.1];
    SKAction* scaleDef = [SKAction scaleTo:1.1 duration:0.1];
    SKAction* delay = [SKAction waitForDuration:1.0];
    SKAction* seq = [SKAction sequence:@[scale1, scaleDef]];
    SKAction* repeat = [SKAction sequence:@[[SKAction repeatAction:seq count:2], delay]];
    SKAction* r = [SKAction repeatActionForever:repeat];
    [self.button runAction:r withKey:kButtonBlinkActionKey];
}

-(void)addTimeLeftLabel{
    self.TIME_LEFT_LABEL          = [SKLabelNode labelNodeWithFontNamed:kFONT_SPEC];
    self.TIME_LEFT_LABEL.text = @"00:00:00";
    
#warning EF positioning
    self.TIME_LEFT_LABEL.position = ccp(self.button.position.x, self.SBonusLabel.position.y);//ccpAdd(self.button.position, ccp(0, self.TIME_LEFT_LABEL.size.height/2));
    self.TIME_LEFT_LABEL.fontColor    = [SKColor lightTextColor];
    self.TIME_LEFT_LABEL.scale    = (IS_IPAD) ? 0.55f : 0.65f;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.TIME_LEFT_LABEL.scale = 1.4;
    }
    [self addChildToTopZ:self.TIME_LEFT_LABEL];
    self.TIME_LEFT_LABEL.position = self.grille.position;
}


-(void) addProgress
{
    self.grille              = [SKSpriteNode spriteNodeWithImageNamed:@"bonus_separator.png"];
    self.grille.anchorPoint  = ccp(0.5f, 0.5f);
    self.grille.position     = ccp(self.specBackground.position.x - self.specBackground.size.width*0.008f, self.specBackground.position.y + self.specBackground.size.height*0.34f);
    
    [self addChildToTopZ:self.grille];
    self.grille.hidden = NO;
    
    self.progress_line              = [SKSpriteNode spriteNodeWithImageNamed:@"bonus_progress.png"];
    self.progress_line.anchorPoint  = ccp(0.f, 0.5f);
    self.progress_line.position     = ccp(self.grille.position.x, self.grille.position.y);
    self.progress_line.position = ccpAdd(self.progress_line.position,
                                    ccp(-self.progress_line.size.width/2, 0));
    [self addChildToTopZ:self.progress_line];
    
    self.NO_CONNECTION_LABEL          = [SKLabelNode labelNodeWithFontNamed:kFONT_SPEC];
    self.NO_CONNECTION_LABEL.text     = @"NO INTERNET CONNECTION";
    
    if (self.NO_CONNECTION_LABEL) {
#warning EF
//        self.SBonusLabel.scale *= 2;
    }
    self.NO_CONNECTION_LABEL.position = self.grille.position;
    self.NO_CONNECTION_LABEL.fontColor = [SKColor lightTextColor];
    self.NO_CONNECTION_LABEL.scale    = 0.35f;
    [self addChildToTopZ:self.NO_CONNECTION_LABEL];
    self.NO_CONNECTION_LABEL.hidden = NO;
    
    [self noConnectionAction];
}

-(void)noConnectionAction{
    
    SKAction* blinkWhite = [SKAction fadeAlphaTo:1.0 duration:0.2];
    SKAction* blinkDef = [SKAction fadeAlphaTo:150/255.0 duration:0.3];
    SKAction* seq = [SKAction sequence:@[blinkWhite, blinkDef]];
    SKAction* repeatForever = [SKAction repeatActionForever:seq];
    [self.NO_CONNECTION_LABEL runAction:repeatForever withKey:kButtonBlinkActionKey];
}

-(void) addButton
{
    self.button              = [SKSpriteNode spriteNodeWithImageNamed:@"btn_get.png"];
    self.button.anchorPoint  = ccp(0.5f, 0.5f);
    self.button.position     = ccp(self.progress_line.position.x + self.progress_line.size.width*0.92f, self.progress_line.position.y);
    self.button.position = ccpAdd(self.button.position,
                                    ccp(self.progress_line.size.width/2, 0));
    [self addChildToTopZ:self.button];
}

-(void) addTxtLabel
{
    self.SBonusLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SPEC];
    self.SBonusLabel.text = @"GET FREE COINS";
    self.SBonusLabel.position = ccp(self.specBackground.position.x, self.specBackground.position.y + self.specBackground.size.height*0.72f);
#warning EF why add the cpp?
//    self.SBonusLabel.position = ccpAdd(self.SBonusLabel.position, ccp(self.SBonusLabel.size.width*0.15f, 0));
    self.SBonusLabel.fontColor = [SKColor lightTextColor];
    self.SBonusLabel.scale    = 0.8f;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.SBonusLabel.scale = 1.8;
    }
    [self addChildToTopZ:self.SBonusLabel];
}
////////////////////// TOUCHES //////////////////////////////////


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if(!canTouch)
    {
        return;
    }
    
    SKNode* touchedNode = [self nodeFromTouches:touches];
    if([touchedNode isEqualToNode:self.button])
    {
        b1 = true;
        [AUDIO playEffect:s_click1];
        self.button.texture = self.Btn_Active;
    }
}



-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (b1)
    {
        self.button.texture = self.Btn_notActive;
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SKNode* touchedNode = [self nodeFromTouches:touches];
    if([touchedNode isEqualToNode:self.button])
    {
        b1 = false;
        self.button.texture = self.Btn_notActive;
        //take bonus
        [self getCoins];
    }
    
    if (b1)
    {
        self.button.texture = self.Btn_notActive;
    }
}
//
//-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
//    
//    
//    if (CGRectContainsPoint(self.button.boundingBox, touchPos))
//    {
//        b1 = false;
//        [self.button setDisplayFrame:self.Btn_notActive];
//        //take bonus
//        
//        [self getself.Coins];
//        
//        
//        
//    }
//    
//    if (b1)
//    {
//        [self.button setDisplayFrame:self.Btn_notActive];
//    }
//    
//    
//    
//}
//


//
//-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
//    
//    if (!canTouch) {
//        return NO;
//    }
//    
//    if (CGRectContainsPoint(self.button.boundingBox, touchPos))
//    {
//        b1 = true;
//        [AUDIO playEffect:s_click1];
//        [self.button setDisplayFrame:self.Btn_Active];
//    }
//    
//    
//    return YES;
//}


#warning EF

//-(void) onEnter
//{
//    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_self.buttons swallowsTouches:NO];
//    [super onEnter];
//}
//-(void)onExit
//{
//    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
//    [super onExit];
//}
//




@end

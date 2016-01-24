#import "Menu.h"
#import "cfg.h"
#import "Constants.h"
#import "TopMenu.h"
#import "BottomMenu.h"
#import "ClippingNode.h"
#import "Lobby.h"
#import "SimpleAudioEngine.h"
#import "SlotMachine.h"
#import "SCombinations.h"
#import "b6luxLoadingView.h"
#import "ALSdk.h"
#import "ALInterstitialAd.h"
#import "IDSTOREPLACE.h"
#import "PayTableWindow.h"
#import "SKNode+SKNode_Extensions.h"

#import <Chartboost/Chartboost.h>

//#define kBottomMenuTAG  101
//#define kTopMenuTAG     102
#define kGoLeft         103
#define kGoRight        104
#define kLockTag        1111
#define kCoomTag        2222



@interface Menu()

@property (nonatomic, strong) SKSpriteNode* rateApp;
@property (nonatomic, strong) SKSpriteNode* freeApp;
@property (nonatomic, strong) SKSpriteNode* moreGames;
@property (nonatomic, strong) SKSpriteNode* playTables;
@property (nonatomic, strong) TopMenu*  tMenu;
@property (nonatomic, strong) SKSpriteNode* slotIcon;

@end


@implementation Menu

-(void)dealloc{
    self.rateApp = nil;
    self.freeApp = nil;
    self.moreGames = nil;
    self.playTables = nil;
    self.slotIcon = nil;
    self.tMenu = nil;
}

//-(NSString*)prefix
//{
//    if (IS_IPAD)return @"";return @"_iPhone";
//}
+(Menu*) menuWithRect:(CGRect) rect type:(NSInteger) type level:(NSInteger) level
{
    Menu* menu = [[Menu alloc] initWithRect:rect type:type level:(int)level];
    return menu;
}

-(id)initWithRect:(CGRect)rect type:(int)type_ level:(int)level_
{
    if((self = [super init]))
    {
        self.zPosition = ZDepthMenu;
        self.userInteractionEnabled = YES;
        #warning EF - what is DB used for, if anything?
        [DB_ setValueToDB:d_Coins table:d_DB_Table :k_First_Cash];
        self.anchorPoint    = CGPointZero;
        self.position       = rect.origin;
        self.size           = rect.size;
        //        self.contentSize    = rect.size;
        
        #warning EF - this MENU looks unused, it seems to provide a way of scrolling through multiple games on the lobby screen.
        //        MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_arrow.pvr.ccz"]];
        //        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_arrow.plist"]];
        //        [self addChild:MENU_];
        
        #warning EF - a lock image for locked games
        //        mLocked     = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"icon3.png"]];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        
        mTYPE       = type_;
        LEVEL       = level_;
        
        startPage   = 0;
        machineTag  = 0;
        iPageNum    = 0;
        
        // ------------
        iconW1 = 0.5f;
        iconW2 = 0.50f;
        iconW3 = 0.75f;
        
        iconH1 = 0.5f;
        iconH2 = 0.70f;
        // ------------
        
        
        #warning EF - implement a UIScrollView or other when doing multiple games in the lobby. all of this for for multiple games in lobby
        //		CCScrollLayer *scrollLayer = (CCScrollLayer *)[self getChildByTag:100];
        //        scrollLayer = [self scrollLayer];
        //        [self addChild: scrollLayer z: 0 tag:100];
        //        //[scrollLayer selectPage: 1];
        //        scrollLayer.delegate = self;
        //        [self startPage];
        //      [self nextPageButtons];
        //        [self changeButtons_boundingBoxes];
        
        // Create game Icon
        [self createGameIcons];
        [self topMenuType:2];
        [self openSBonusWindow];
        
        goLeftButton.opacity = 50;
        
        [self prepareCoinsFlyAct];

        // Calculate experience and post to Game Center.
        int exp__ = [DB_ getValueBy:d_Exp table:d_DB_Table];
        if (exp__ > 0) {
            [GC_ submitMainScore:exp__];
        }
        
        // Remove the loading screen after a delay.
        SKAction* delayAction = [SKAction waitForDuration:0.3];
        SKAction* removeLoadingAction = [SKAction performSelector:@selector(loadingOff) onTarget:self];
        [self runAction:[SKAction sequence:@[delayAction, removeLoadingAction]]];
        
        [self checkSound];
        
        // Chartboost stuff
        [Chartboost showInterstitial:CBLocationHomeScreen];
        [Chartboost cacheInterstitial:CBLocationHomeScreen];
        [Chartboost cacheRewardedVideo:CBLocationMainMenu];
        
        // App Lovin'
        if ([ApplovinAddAtGameOverandMenu  isEqual: @YES]) {
            if([ALInterstitialAd isReadyForDisplay]){
                [ALInterstitialAd show];
                NSLog(@"AD SHOW (APPLOVIN)");
            }
            else{
                NSLog(@"AD NOT READY, SO CAN'T SHOW");
                // No interstitial ad is currently available.  Perform failover logic...
            }
        }
        
        // Setup Buttons.
        self.rateApp = [SKSpriteNode spriteNodeWithImageNamed:@"rateapp.png"];
        self.freeApp = [SKSpriteNode spriteNodeWithImageNamed:@"freegames.png"];
        self.moreGames = [SKSpriteNode spriteNodeWithImageNamed:@"moregames.png"];
        self.playTables = [SKSpriteNode spriteNodeWithImageNamed:@"paytables.png"];
        
        self.rateApp.position = CGPointMake(self.size.width/8*1,self.size.height/3);
        [self.rateApp setScale:0.35];
        self.freeApp.position = CGPointMake(self.size.width/8*3,self.size.height/3);
        [self.freeApp setScale:0.35];
        self.moreGames.position = CGPointMake(self.size.width/8*5,self.size.height/3);
        [self.moreGames setScale:0.35];
        self.playTables.position = CGPointMake(self.size.width/8*7,self.size.height/3);
        [self.playTables setScale:0.35];
        
        [self addChild:self.rateApp];
        [self addChild:self.freeApp];
        [self addChild:self.moreGames];
        [self addChild:self.playTables];
    }
    return self;
}

-(void) createGameIcons{
    NSString* imageName = [NSString stringWithFormat:@"icon%d.png", [machineID intValue]];
    self.slotIcon = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    self.slotIcon.anchorPoint     = CGPointMake(0.5f, 0.62f);
    self.slotIcon.position = CGPointMake(kWidthScreen * iconW1,  kHeightScreen * iconH2); 
    
    [self.slotIcon setScale:1.2];
    machineTag               = machineTag + 1;
    [self addChild:self.slotIcon];
}

-(void)checkSound{
    
    if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
        AUDIO.backgroundMusicVolume = 0.5f;
    }
    else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
        AUDIO.backgroundMusicVolume = 0.f;
    }
    if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
        AUDIO.effectsVolume = 1.f;
    }
    else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
        AUDIO.effectsVolume = 0.f;
    }
    return;
#warning EF audio player
    [AUDIO playBackgroundMusic:@"menu.mp3" loop:YES];
   // AUDIO.backgroundMusicVolume = 0.5f;
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    // Get touch node.
    SKNode* node = [self nodeFromTouches:touches inParentNode:self];
    
    if([node isEqualToNode:self.rateApp])
    {
        [self.rateApp setTexture:[SKTexture textureWithImageNamed:@"rateapp_pressed.png"]];
    }
    else if([node isEqualToNode:self.freeApp])
    {
        [self.freeApp setTexture:[SKTexture textureWithImageNamed:@"freegames_pressed.png"]];
    }
    else if([node isEqualToNode:self.moreGames])
    {
        [self.moreGames setTexture:[SKTexture textureWithImageNamed:@"moregames_pressed.png"]];
    }
    else if([node isEqualToNode:self.playTables])
    {
        [self.playTables setTexture:[SKTexture textureWithImageNamed:@"paytables_pressed.png"]];
    }
    else if([node isEqualToNode:self.slotIcon])
    {
        [self.slotIcon setScale:0.9];
    }
    if([node isEqualToNode:self.slotIcon])
    {
        [self.slotIcon setScale:0.9];
    }
    #warning EF do touch handling for scroll view, see original cocos2d implementation
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    #warning EF create sprite texture cache
    [self.rateApp setTexture:   [SKTexture textureWithImageNamed:@"rateapp.png"]];
    [self.freeApp setTexture:   [SKTexture textureWithImageNamed:@"freegames.png"]];
    [self.moreGames setTexture: [SKTexture textureWithImageNamed:@"moregames.png"]];
    [self.playTables setTexture:[SKTexture textureWithImageNamed:@"paytables.png"]];
    [self.slotIcon setScale:1.2];

    SKNode* node = [self nodeFromTouches:touches inParentNode:self];
    
    if([node isEqualToNode:self.rateApp])
    {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
    }
    else if([node isEqualToNode:self.freeApp])
    {
        [self.tMenu openBuyWindow_withNR:@1];
    }
    else if([node isEqualToNode:self.moreGames])
    {
        [Chartboost showMoreApps:CBLocationHomeScreen];
    }
    else if([node isEqualToNode:self.playTables])
    {
#warning EF create SKPaytable
        PayTableWindow* payTable = [[PayTableWindow alloc] init_withMachineNR:[machineID intValue]];
        payTable.position = CGPointMake(self.size.width/2,self.size.height/2);
//        [self.parent addChild:payTable];
    }
    else if([node isEqualToNode:self.slotIcon])
    {
        [self goToMachineNR:@(1)];
    }
    #warning EF - do touch handling for scrollview
}

-(void)loading
{
    [b6luxLoadingView loadingViewWithLoadingType:kLOADING_MACHINE];
}

-(void)loadingOff
{
    [b6luxLoadingView removeLoadingView];
    SOUND_.musicVolume = 0.5f;
    #warning EF SKPopupmanager
//    [(PopupManager *)[self getChildByTag:kSpeWindowTAG] setUp:kWindowSpecialBonus someValue:0];
}

-(void) goToMachineNR:(NSNumber *)machineNumber
{
   /// SOUND_.musicVolume = 0.15f;
    [AUDIO stopBackgroundMusic];
    [AUDIO playEffect:s_click1];
//    [[CCDirector sharedDirector] replaceScene:[SlotMachine sceneWithMachineNr:machineNumber.intValue]];
}

////////////////////// TOP MENU ////////////////////////////////////////////////////////////////////////
-(void)topMenuType:(int) menuType
{
    if (!self.tMenu) {
        
        float coins_  = [DB_ getValueBy:d_Coins table:d_DB_Table];
        int exp_    = [DB_ getValueBy:d_Exp table:d_DB_Table];
        
        self.tMenu = [[TopMenu alloc] initWithRect:CGRectMake(0, kHeightScreen * 0.8f, kWidthScreen, kHeightScreen * 0.2f) type:menuType experience:exp_ coins:coins_];
        self.tMenu.anchorPoint = CGPointZero;
        self.tMenu.position = CGPointMake(self.tMenu.position.x, kHeightScreen);
        [self addChild:self.tMenu];
        
#warning EF maybe animate this
        self.tMenu.position = CGPointZero;

//        [self.tMenu runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.0f position:ccp(0, 0)] rate:1]];
    }
}
//

////////////////////// SPECIAL BONUS /////////////////////////////////////////////////////////////////
-(void) openSBonusWindow
{
    
#warning EF create PopupManager
    return;
    
    PopupManager *SBWindow = [[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)];
    SBWindow.anchorPoint = ccp(0, 0);
//    [self addChild:SBWindow z:10 tag:kSpeWindowTAG];
    
    //get special bonus
    SPECIAL_BONUS = [SBWindow GET_SPECIALBONUS];
    
}

-(SpecialBonus*)GET_SPECIAL_BONUS{
    
    return SPECIAL_BONUS;
    
}
//////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)delay
{
    [self performSelector:@selector(ChangeMenu) withObject:nil afterDelay:0.3f];
}

-(void)ChangeMenu
{
    [self topMenuType:2];
}

-(void)closeBottomMenu
{
#warning EF
    NSAssert(NO, @"not yet implemented");
//    [self removeChild:(BottomMenu *)[self getChildByTag:kBottomMenuTAG] cleanup:YES];
}

-(void)coinAnimation:(int)coins
{
    NSAssert(NO, @"EF not yet implemented");
    CFA.coinsNumber = coins;
    [CFA startFlyAct];
}

-(void)prepareCoinsFlyAct{
#warning EF set this up when its used
    return;
    CFA = [[coinsFA alloc]init];
//    [self addChild:CFA z:999 tag:929];
    CFA.startPosition = ccp(kWidthScreen*0.5f,kHeightScreen*0.f);//kHeightScreen*0.05f);
    [CFA setup_];
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark Scroll Layer Callbacks

- (void) scrollLayerScrollingStarted:(CCScrollLayer *) sender
{
    //NSLog(@"Scrolling started");
    //NSLog(@"-------> Slot Machine Icon TAG ........ %d .........", machineTag);
}

- (void) scrollLayer: (CCScrollLayer *) sender scrolledToPageNumber: (int) page
{
    //NSLog(@"Scrolled To Page Number: %d", page);
    
    iPageNum = page;
    
    if      (iPageNum > 0)  { goLeftButton.opacity = 255; }
    else if (iPageNum == 0) { goLeftButton.opacity = 50; }
    
    if      (iPageNum + 1 < numOfPages)  { goRightButton.opacity = 255; }
    else if (iPageNum + 1 == numOfPages) { goRightButton.opacity = 50;  }
}


/////////////////////////////////////////////////////////////////////
-(void) changeButtons_boundingBoxes
{
    goLeft_rect               = goLeftButton.boundingBox;
    goLeft_rect.origin.x      = goLeft_rect.origin.x - goLeft_rect.size.width*2;
    goLeft_rect.origin.y      = goLeft_rect.origin.y - goLeft_rect.size.height*2;
    goLeft_rect.size.width    = goLeft_rect.size.width*5;
    goLeft_rect.size.height   = goLeft_rect.size.height*5;
    
    goRight_rect               = goRightButton.boundingBox;
    goRight_rect.origin.x      = goRight_rect.origin.x - goRight_rect.size.width*2;
    goRight_rect.origin.y      = goRight_rect.origin.y - goRight_rect.size.height*2;
    goRight_rect.size.width    = goRight_rect.size.width*5;
    goRight_rect.size.height   = goRight_rect.size.height*5;
    
    
    // [self addChild:[SCombinations boxWithColor:ccc4(135, 220, 101, 100) pos:goLeft_rect.origin size:goLeft_rect.size] z:100];
     //[self addChild:[SCombinations boxWithColor:ccc4(135, 220, 101, 100) pos:goRight_rect.origin size:goRight_rect.size] z:100];
}


//////////////////////////////////////////////////// Buttons to change pages ///////////////////
-(void) nextPageButtons
{
    //    goLeftButton                  = [CCSprite spriteWithSpriteFrameName:@"arrow.png"];
    //    goLeftButton.anchorPoint      = ccp(0.5f, 0.5f);
    //    goLeftButton.flipX            = YES;
    //    goLeftButton.position         = ccp(kWidthScreen * 0.05f, kHeightScreen * 0.52f);
    //    goLeftButton.tag              = kGoLeft;
    //    [self addChild:goLeftButton];
    //
    //    goRightButton                 = [CCSprite spriteWithSpriteFrameName:@"arrow.png"];
    //    goRightButton.anchorPoint     = ccp(0.5f, 0.5f);
    //    goRightButton.position        = ccp(kWidthScreen * 0.95f, kHeightScreen * 0.52f);
    //    goRightButton.tag             = kGoRight;
    //    [MENU_ addChild:goRightButton];
    //
    //    [goLeftButton runAction:[CCTintTo actionWithDuration:0 red:100 green:100 blue:100]];
    //    [goRightButton runAction:[CCTintTo actionWithDuration:0 red:100 green:100 blue:100]];
    
    //[goLeftButton addChild:[SCombinations boxWithColor:ccc4(135, 220, 101, 100) pos:goLeftButton.position size:goLeftButton.contentSize]];
}
/////////////////////////////////////////////////////////////////////
//
//-(void) goToNextP
//{
//    if (iPageNum < numOfPages)
//    {
//        CCScrollLayer *s = (CCScrollLayer *)[self getChildByTag:100];
//        [s makeBool];
//        [s moveToPage:[s currentScreen] + 1];
//    }
//}
//
//-(void) goToPreviousP
//{
//    if (iPageNum >= 1)
//    {
//        CCScrollLayer *s = (CCScrollLayer *)[self getChildByTag:100];
//        [s makeBool];
//        [s moveToPage:[s currentScreen] - 1];
//    }
//}
///////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark ScrollLayer Creation
#warning EF this displays the game icon.

//// Returns array of CCLayers - pages for ScrollLayer --------------
//- (NSArray *) scrollLayerPages:(int)pages_ buttonsInPage:(int)btns_
//{
//    
//
//    
//    machineTag = [machineID intValue]-1;
//    NSLog(@"MACHINE TAG: %i, GIVEN:%@",machineTag,machineID);
//    NSMutableArray *a = [[[NSMutableArray alloc]init] autorelease];
//    
//    for (int i = 0; i <= pages_; i++)
//    {
//        CCSprite *page_ = [CCSprite node];
//        page_.tag       = i;
//        
//        //        if (x >= 1) { goBlack = true;  }
//        
//        for (int x = 1; x <= btns_; x++)
//        {
//            //CCSprite *self.slotIcon       = [CCSprite spriteWithFile:[NSString stringWithFormat:@"icon%d.png", x]];
//            if (machineTag <= 5)
//            {
//                self.slotIcon       = [CCSprite spriteWithFile:[NSString stringWithFormat:@"icon%d.png", [machineID intValue]]];
//                
//                int level_ = 0;
//                
//                switch (machineTag)
//                {
//                    case 1: level_ = 1; break;//5
//                    case 2: level_ = 1; break;//10
//                    case 3: level_ = 1; break;//25
//                    case 4: level_ = 1; break;//35
//                    case 5: level_ = 1; break;//50
//                        
//                    default:
//                        break;
//                }
//                
//                //                if (machineTag > 0 && LEVEL < level_)
//                //                {
//                //                    [self.slotIcon runAction:[CCTintTo actionWithDuration:0.f red:250 green:250 blue:250]];
//                //                    CCSprite *MLocked = [CCSprite spriteWithFile:@"lock.png"];
//                //                    MLocked.anchorPoint = ccp(0.5f, 0.5f);
//                //                    MLocked.position = ccp(self.slotIcon.boundingBox.size.width*0.70f, self.slotIcon.boundingBox.size.height*0.10f);
//                //
//                //                    [self.slotIcon addChild:MLocked z:9 tag:kLockTag];
//                //                    self.slotIcon.opacity = 150;
//                //
//                //                    CCLabelTTF *lvlLabel  = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"Level %d", level_] fntFile:kFONT_MENU];
//                //                    lvlLabel.position     = ccp(MLocked.boundingBox.size.width*0.35, MLocked.boundingBox.size.height*0.38f);
//                //                    if (IS_IPHONE) { //lvlLabel.scale = 0.8f;
//                //                    }
//                ////                    if (![Combinations isRetina]) { lvlLabel.scale = 0.9f; }
//                //                    if (iPhone3) { lvlLabel.scale = 0.5f; }
//                //                    lvlLabel.color        = ccBLACK;
//                //                    [MLocked addChild:lvlLabel z:10];
//                //
//                //
//                //                }
//                
//            }
//            else if (machineTag >= 6)
//            {
//                [self.slotIcon runAction:[CCTintTo actionWithDuration:0.f red:250 green:250 blue:250]];
//                switch (machineTag)
//                {
//                    case  6: self.slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico1.png"]]; break;
//                    case  7: self.slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico2.png"]]; break;
//                    case  8: self.slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico3.png"]]; break;
//                    case  9: self.slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico4.png"]]; break;
//                    case 10: self.slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico5.png"]]; break;
//                    case 11: self.slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico6.png"]]; break;
//                        
//                    default:
//                        break;
//                }
//                
//                CCSprite *MComming = [CCSprite spriteWithFile:@"coming_soon.png"];
//                MComming.anchorPoint = ccp(0.5f, 0.5f);
//                MComming.position = ccp(self.slotIcon.boundingBox.size.width*0.70f, self.slotIcon.boundingBox.size.height*0.10f);
//                
//                self.slotIcon.opacity = 150;
//                [self.slotIcon addChild:MComming z:9 tag:kCoomTag];
//                
//                
//                CCLabelTTF *Label  = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"Comming soon"] fntFile:kFONT_MENU];
//                Label.position     = ccp(MComming.boundingBox.size.width*0.35, MComming.boundingBox.size.height*0.50f);
//                if (IS_IPHONE) { Label.scale = 0.95f; }
//                // if (![Combinations isRetina]) { Label.scale = 0.8f; }
//                if (iPhone3) { Label.scale = 0.5f; }
//                Label.color        = ccBLACK;
//                [MComming addChild:Label z:10];
//                
//                
//            }
//            
//            self.slotIcon.anchorPoint     = ccp(0.5f, 0.62f);
//            self.slotIcon.tag             = machineTag + 1;
//            [self.slotIcon setScale:1.2];
//            machineTag               = self.slotIcon.tag;
//            [page_ addChild:self.slotIcon];
//            
//            //if (goBlack) { self.slotIcon.color = ccBLACK; }
//            
//            switch (x)
//            {
//                case 1: self.slotIcon.position = ccp(kWidthScreen * iconW1,  kHeightScreen * iconH2); break;
//                case 2: self.slotIcon.position = ccp(kWidthScreen * iconW2,  kHeightScreen * iconH2); break;
//                case 3: self.slotIcon.position = ccp(kWidthScreen * iconW3,  kHeightScreen * iconH2); break;
//                case 4: self.slotIcon.position = ccp(kWidthScreen * iconW1,  kHeightScreen * iconH1); break;
//                case 5: self.slotIcon.position = ccp(kWidthScreen * iconW2,  kHeightScreen * iconH1); break;
//                case 6: self.slotIcon.position = ccp(kWidthScreen * iconW3,  kHeightScreen * iconH1); break;
//                default: break;
//            }
//        }
//        
//        [a addObject:page_];
//    }
//    return [NSArray arrayWithArray:a];
//}

// Creates new Scroll Layer with pages returned from scrollLayerPages.
//- (CCScrollLayer *) scrollLayer
//{
//    numOfPages              = 1;
//    numberOfButtonsInPage   = 1;
//    
//    // Create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages).
//    CCScrollLayer *scroller = [CCScrollLayer nodeWithLayers: [self scrollLayerPages:numOfPages - 1 buttonsInPage:numberOfButtonsInPage]
//                                                widthOffset: 0.1f *kWidthScreen ];
//    
//    //scroller.pagesIndicatorPosition = ccp(kWidthScreen * 0.5f, 30.0f);
//    
//    // New feature: margin offset - to slowdown scrollLayer when scrolling out of it contents.
//    // Comment this line or change marginOffset to screenSize.width to disable this effect.
//    //scroller.marginOffset = kWidthScreen * 0.2f;
//    
//    return scroller;
//}

#pragma mark Callbacks

#warning EF some scrolling stuff
-(void)startPage
{
    //	CCScrollLayer *scroller = (CCScrollLayer *)[self getChildByTag:100];
    //	[scroller moveToPage: startPage];
}
//
//-(void) onEnter
//{
// //   int priority = -10;//kCCMenuTouchPriority - 2;
//    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_Menu swallowsTouches:YES];
//
//    [super onEnter];
//}
//
//-(void)onExit
//{
//
//    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:[NSString stringWithFormat:@"sp_arrow.plist"]];
//
//    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
//
//    [super onExit];
//}
//
-(void) unblockArrows
{
    if (blockArrow)
    {
        blockArrow = false;
    }
}




//-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
//
//    if (CGRectContainsPoint([self getChildByTag:1901].boundingBox,touchPos))
//    {
//        NSLog(@"Rate button touched");
//        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"rateapp_pressed.png"];
//        [[self getChildByTag:1901] setTexture: tex];
//        //[[self getChildByTag:1901] setScale:0.4];
//    }
//    else if (CGRectContainsPoint([self getChildByTag:1902].boundingBox,      touchPos))
//    {
//        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"freegames_pressed.png"];
//        [[self getChildByTag:1902] setTexture: tex];
//        //[[self getChildByTag:1902] setScale:0.4];
//        NSLog(@"Freeapp button touched");
//
//    }
//    else if (CGRectContainsPoint([self getChildByTag:1903].boundingBox,      touchPos))
//    {
//        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"moregames_pressed.png"];
//        [[self getChildByTag:1903] setTexture: tex];
//        //[[self getChildByTag:1903] setScale:0.4];
//        NSLog(@"More games touched");
//
//    }
//    else if (CGRectContainsPoint([self getChildByTag:1904].boundingBox,      touchPos))
//    {
//        NSLog(@"Paytables touhed");
//
//        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"paytables_pressed.png"];
//        [[self getChildByTag:1904] setTexture: tex];
//        //[[self getChildByTag:1904] setScale:0.4];
//    }else{
//
//
//
//    //id buttonAnimation1 = [CCScaleTo actionWithDuration:0.05f scale:0.9f];
//    //id buttonAnimation2 = [CCScaleTo actionWithDuration:0.05f scale:1.0f];
//    //id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
//
//    //id buttonAnimation_ = [CCScaleTo actionWithDuration:0.03f scale:0.9f];
//   // id buttonEase       = [CCEaseInOut actionWithAction:buttonAnimation_ rate:1.5f];
//
//
//
////    if (![(CCScrollLayer *)[self getChildByTag:100] getActionByTag:1234])
////    {
////
////        // go left
////        if (CGRectContainsPoint(goLeft_rect, touchPos))
////        {
////
////            [goLeftButton runAction:runAnimation];
////            [self goToPreviousP];
////
////            if (iPageNum > 0)
////            {
////                 [AUDIO playEffect:s_click1];
////                //[[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
////            }
////            return YES;
////        }
////
////
////    if (![(CCScrollLayer *)[self getChildByTag:100] getActionByTag:1234])
////    {
////        // go right
////
////        if (CGRectContainsPoint(goRight_rect, touchPos))
////        {
////            [goRightButton runAction:runAnimation];
////            [self goToNextP];
////
////            if (iPageNum + 1 < numOfPages)
////            {
////                 [AUDIO playEffect:s_click1];
////             //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
////            }
////            return YES;
////        }
////    }
////
////    }
//
//
//#warning EF Scroll touch handling.
//    for (CCNode *ss in [[self getChildByTag:100] getChildByTag:iPageNum].children)
//    {
//        int tagNR;
//
//        if      (iPageNum == 0) { tagNR =  0; }
//        else if (iPageNum == 1) { tagNR =  6; }
//        else if (iPageNum == 2) { tagNR = 12; }
//        else if (iPageNum == 3) { tagNR = 18; }
//        else if (iPageNum == 4) { tagNR = 24; }
//        else if (iPageNum == 5) { tagNR = 30; }
//        else if (iPageNum == 6) { tagNR = 36; }
//        else if (iPageNum == 7) { tagNR = 42; }
//
//        if (CGRectContainsPoint(ss.boundingBox,      touchPos) && ss.tag == tagNR + 1)
//        {
//            //[ss runAction:buttonEase];
//            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
//            ss.scale = 0.9f;
//            }
//
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 2)
//        {
//            //[ss runAction:buttonEase];
//            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
//                ss.scale = 0.9f;
//            }
//
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 3)
//        {
//            //[ss runAction:buttonEase];
//            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
//                ss.scale = 0.9f;
//            }
//
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 4)
//        {
//            //[ss runAction:buttonEase];
//            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
//                ss.scale = 0.9f;
//            }
//
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 5)
//        {
//            //[ss runAction:buttonEase];
//            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
//                ss.scale = 0.9f;
//            }
//
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 6)
//        {
//            //[ss runAction:buttonEase];
//            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
//                ss.scale = 0.9f;
//            }
//
//
//        }
//        if (IS_STANDARD_IPHONE_6_PLUS) {
//            ss.scale = 1.6;
//        }
//    }
//    }
//    return YES;
//}
//-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    //CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
//
////    //id buttonAnimation2 = [CCScaleTo actionWithDuration:0.03f scale:1.0f];
////    //id buttonEase       = [CCEaseInOut actionWithAction:buttonAnimation2 rate:1.5f];
////    for (CCNode *ss in [[self getChildByTag:100] getChildByTag:iPageNum].children)
////    {
////        //[ss runAction:[buttonEase copy]];
////        ss.scale = 1.2f;
////    }
//
//}
////////////////////// BOTTOM MENU ////////////////////////////////////////////////////////////////////
//-(void)bottomMenu
//{
//    if (![self getChildByTag:kBottomMenuTAG]) {
//        BottomMenu *BMenu = [[[BottomMenu alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen * 0.2f) type:1 lines:1 maxLines:25 maxBet:50] autorelease];
//
//        BMenu.anchorPoint = ccp(0.5f, 0);
//        BMenu.position = ccp(kWidthScreen / 2, kHeightScreen - kHeightScreen * 1.1f);
//        [self addChild:BMenu z:11 tag:kBottomMenuTAG];
//
//        [BMenu runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.05f position:ccp(kWidthScreen/2, 0)] rate:1]];
//    }
//}




//-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
//
//
//
//    [[self getChildByTag:1901] setTexture: [[CCTextureCache sharedTextureCache] addImage:@"rateapp.png"]];
//    [[self getChildByTag:1902] setTexture: [[CCTextureCache sharedTextureCache] addImage:@"freegames.png"]];
//    [[self getChildByTag:1903] setTexture: [[CCTextureCache sharedTextureCache] addImage:@"moregames.png"]];
//    [[self getChildByTag:1904] setTexture: [[CCTextureCache sharedTextureCache] addImage:@"paytables.png"]];
//
//
//    if (CGRectContainsPoint([self getChildByTag:1901].boundingBox,touchPos))
//    {
//     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
//    }
//    else if (CGRectContainsPoint([self getChildByTag:1902].boundingBox,      touchPos))
//    {
//        [self.tMenu openBuyWindow_withNR:@1];
//    }
//    else if (CGRectContainsPoint([self getChildByTag:1903].boundingBox,      touchPos))
//    {
//        [Chartboost showMoreApps:CBLocationHomeScreen];
//    }
//    else if (CGRectContainsPoint([self getChildByTag:1904].boundingBox,      touchPos))
//    {
//        PayTableWindow* payTable = [[PayTableWindow alloc] init_withMachineNR:[machineID intValue]];
//        payTable.position = CGPointMake(self.boundingBox.size.width/2,self.boundingBox.size.height/2);
//        [self.parent addChild:payTable];
//    }
//
//
//
//
//    for (CCNode *ss in [[self getChildByTag:100] getChildByTag:iPageNum].children)
//    {
//        int tagNR;
//
//        if      (iPageNum == 0) { tagNR =  0; }
//        else if (iPageNum == 1) { tagNR =  6; }
//        else if (iPageNum == 2) { tagNR = 12; }
//        else if (iPageNum == 3) { tagNR = 18; }
//        else if (iPageNum == 4) { tagNR = 24; }
//        else if (iPageNum == 5) { tagNR = 30; }
//        else if (iPageNum == 6) { tagNR = 36; }
//        else if (iPageNum == 7) { tagNR = 42; }
//
//        ss.scale = 1.2f;
//
//        if (CGRectContainsPoint(ss.boundingBox,      touchPos) && (ss.tag == tagNR + 1))
//        {
//
//
//            if ([ss getChildByTag:kLockTag]) {
//                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                 [AUDIO playEffect:s_lockedmachine];
//            }
//            else if ([ss getChildByTag:kCoomTag])
//            {
//                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//
//            if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
//
//                [self loading];
//
//          //      [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//                [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:1]], nil]];
//            }
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 2))
//        {
//
//            if ([ss getChildByTag:kLockTag]) {
//                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//            else if ([ss getChildByTag:kCoomTag])
//            {
//                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//
//             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
//                 [self loading];
//
//       //           [AUDIO playEffect:s_click1];
//                 //[[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//
//                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:2]], nil]];
//             }
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 3))
//        {
//
//            if ([ss getChildByTag:kLockTag]) {
//                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//            else if ([ss getChildByTag:kCoomTag])
//            {
//                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//
//             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
//                 [self loading];
//
//            //     [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//
//                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:3]], nil]];
//             }
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 4))
//        {
//
//            if ([ss getChildByTag:kLockTag]) {
//                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//            else if ([ss getChildByTag:kCoomTag])
//            {
//                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//
//             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
//                 [self loading];
//
//            //     [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//
//                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:4]], nil]];
//             }
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 5))
//        {
//
//            if ([ss getChildByTag:kLockTag]) {
//                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//            else if ([ss getChildByTag:kCoomTag])
//            {
//                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//
//             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
//
//                 [self loading];
//
//               //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//
//                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:5]], nil]];
//             }
//        }
//        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 6))
//        {
//            if ([ss getChildByTag:kLockTag]) {
//                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//            else if ([ss getChildByTag:kCoomTag])
//            {
//                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
//                [AUDIO playEffect:s_lockedmachine];
//            }
//
//
//             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
//                 [self loading];
//
//              //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//
//                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:6]], nil]];
//             }
//        }
//    }
//}



@end

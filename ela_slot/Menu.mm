#import "Menu.h"
#import "cfg.h"
#import "Constants.h"
#import "TopMenu.h"
#import "BottomMenu.h"
#import "ClippingNode.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "SlotMachine.h"
#import "SCombinations.h"
#import "b6luxLoadingView.h"
#import "ALSdk.h"
#import "ALInterstitialAd.h"
#import "IDSTOREPLACE.h"
#import "PayTableWindow.h"

#import <Chartboost/Chartboost.h>

//#define kBottomMenuTAG  101
//#define kTopMenuTAG     102
#define kGoLeft         103
#define kGoRight        104
#define kLockTag        1111
#define kCoomTag        2222

@implementation Menu{
    CCSprite* RateApp;
    CCSprite* FreeApp;
    CCSprite* MoreGames;
    CCSprite* PlayTables;
    TopMenu *TMenu;
}

//-(NSString*)prefix
//{
//    if (IS_IPAD)return @"";return @"_iPhone";
//}


-(id)initWithRect:(CGRect)rect type:(int)type_ level:(int)level_
{
    if((self = [super init]))
    {
        
        [DB_ setValueToDB:d_Coins table:d_DB_Table :k_First_Cash];
        self.anchorPoint    = ccp(0,0);
        self.position       = rect.origin;
        self.contentSize    = rect.size;
        
        MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_arrow.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_arrow.plist"]];
        [self addChild:MENU_];
        
        mLocked     = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"icon3.png"]];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        
        mTYPE       = type_;
        LEVEL       = level_;
//        LEVEL       = 10;
        
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

        
		CCScrollLayer *scrollLayer = (CCScrollLayer *)[self getChildByTag:100];
        scrollLayer = [self scrollLayer];
        [self addChild: scrollLayer z: 0 tag:100];
        //[scrollLayer selectPage: 1];
        scrollLayer.delegate = self;
        
        [self startPage];
       // [self nextPageButtons];
        
        [self topMenuType:2];
        [self changeButtons_boundingBoxes];
        [self openSBonusWindow];
        
        goLeftButton.opacity = 50;
        
        [self prepareCoinsFlyAct];
        
        int exp__ = [DB_ getValueBy:d_Exp table:d_DB_Table];
        
        if (exp__ > 0) {
            [GC_ submitMainScore:exp__];
        }
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.3f],[CCCallFunc actionWithTarget:self  selector:@selector(loadingOff)], nil]];
        
        [self checkSound];
        
    }

       [Chartboost showInterstitial:CBLocationHomeScreen];
     [Chartboost cacheInterstitial:CBLocationHomeScreen];
    [Chartboost cacheRewardedVideo:CBLocationMainMenu];
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
    

    RateApp = [CCSprite spriteWithFile:@"rateapp.png"];
    FreeApp = [CCSprite spriteWithFile:@"freegames.png"];
    MoreGames = [CCSprite spriteWithFile:@"moregames.png"];
    PlayTables = [CCSprite spriteWithFile:@"paytables.png"];
    
    
    if([[UIScreen mainScreen] respondsToSelector:NSSelectorFromString(@"scale")] && [(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]&&[[UIScreen mainScreen] scale] > 1.9)
    {
            RateApp = [CCSprite spriteWithFile:@"rateappipad.png"];
            FreeApp = [CCSprite spriteWithFile:@"freegamesipad.png"];
            MoreGames = [CCSprite spriteWithFile:@"moregamesipad.png"];
            PlayTables = [CCSprite spriteWithFile:@"paytablesipad.png"];
    }
    RateApp.position = CGPointMake(self.boundingBox.size.width/8*1,self.boundingBox.size.height/3);
    [RateApp setScale:0.6];
    RateApp.tag = 1901;
    FreeApp.position = CGPointMake(self.boundingBox.size.width/8*3,self.boundingBox.size.height/3);
    [FreeApp setScale:0.6];
    FreeApp.tag = 1902;
    MoreGames.position = CGPointMake(self.boundingBox.size.width/8*5,self.boundingBox.size.height/3);
    [MoreGames setScale:0.6];
    MoreGames.tag = 1903;
    PlayTables.position = CGPointMake(self.boundingBox.size.width/8*7,self.boundingBox.size.height/3);
    [PlayTables setScale:0.6];
    PlayTables.tag = 1904;
     [self addChild:RateApp];
     [self addChild:FreeApp];
     [self addChild:MoreGames];
     [self addChild:PlayTables];
    
    return self;
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
    
    [AUDIO playBackgroundMusic:@"menu.mp3" loop:YES];
   // AUDIO.backgroundMusicVolume = 0.5f;
    
}


#pragma mark ScrollLayer Creation

// Returns array of CCLayers - pages for ScrollLayer --------------
- (NSArray *) scrollLayerPages:(int)pages_ buttonsInPage:(int)btns_
{
    machineTag = [machineID intValue]-1;
    NSLog(@"MACHINE TAG: %i, GIVEN:%@",machineTag,machineID);
    NSMutableArray *a = [[[NSMutableArray alloc]init] autorelease];
    
    for (int i = 0; i <= pages_; i++)
    {
        CCSprite *page_ = [CCSprite node];
        page_.tag       = i;
        
//        if (x >= 1) { goBlack = true;  }
        
        for (int x = 1; x <= btns_; x++)
        {
            //CCSprite *slotIcon       = [CCSprite spriteWithFile:[NSString stringWithFormat:@"icon%d.png", x]];
            if (machineTag <= 5)
            {
                slotIcon       = [CCSprite spriteWithFile:[NSString stringWithFormat:@"icon%d.png", [machineID intValue]]];
                
                int level_ = 0;
                
                switch (machineTag)
                {
                    case 1: level_ = 1; break;//5
                    case 2: level_ = 1; break;//10
                    case 3: level_ = 1; break;//25
                    case 4: level_ = 1; break;//35
                    case 5: level_ = 1; break;//50
                        
                    default:
                        break;
                }
                
//                if (machineTag > 0 && LEVEL < level_)
//                {
//                    [slotIcon runAction:[CCTintTo actionWithDuration:0.f red:250 green:250 blue:250]];
//                    CCSprite *MLocked = [CCSprite spriteWithFile:@"lock.png"];
//                    MLocked.anchorPoint = ccp(0.5f, 0.5f);
//                    MLocked.position = ccp(slotIcon.boundingBox.size.width*0.70f, slotIcon.boundingBox.size.height*0.10f);
//                    
//                    [slotIcon addChild:MLocked z:9 tag:kLockTag];
//                    slotIcon.opacity = 150;
//                    
//                    CCLabelTTF *lvlLabel  = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"Level %d", level_] fntFile:kFONT_MENU];
//                    lvlLabel.position     = ccp(MLocked.boundingBox.size.width*0.35, MLocked.boundingBox.size.height*0.38f);
//                    if (IS_IPHONE) { //lvlLabel.scale = 0.8f;
//                    }
////                    if (![Combinations isRetina]) { lvlLabel.scale = 0.9f; }
//                    if (iPhone3) { lvlLabel.scale = 0.5f; }
//                    lvlLabel.color        = ccBLACK;
//                    [MLocked addChild:lvlLabel z:10];
//                    
//                    
//                }
                
            }
            else if (machineTag >= 6)
            {
                [slotIcon runAction:[CCTintTo actionWithDuration:0.f red:250 green:250 blue:250]];
                switch (machineTag)
                {
                    case  6: slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico1.png"]]; break;
                    case  7: slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico2.png"]]; break;
                    case  8: slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico3.png"]]; break;
                    case  9: slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico4.png"]]; break;
                    case 10: slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico5.png"]]; break;
                    case 11: slotIcon = [CCSprite spriteWithFile:[NSString stringWithFormat:@"ico6.png"]]; break;
                        
                    default:
                        break;
                }
                
                CCSprite *MComming = [CCSprite spriteWithFile:@"coming_soon.png"];
                MComming.anchorPoint = ccp(0.5f, 0.5f);
                MComming.position = ccp(slotIcon.boundingBox.size.width*0.70f, slotIcon.boundingBox.size.height*0.10f);
                
                slotIcon.opacity = 150;
                [slotIcon addChild:MComming z:9 tag:kCoomTag];
                
                
                CCLabelTTF *Label  = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"Comming soon"] fntFile:kFONT_MENU];
                Label.position     = ccp(MComming.boundingBox.size.width*0.35, MComming.boundingBox.size.height*0.50f);
                if (IS_IPHONE) { Label.scale = 0.95f; }
               // if (![Combinations isRetina]) { Label.scale = 0.8f; }
                if (iPhone3) { Label.scale = 0.5f; }
                Label.color        = ccBLACK;
                [MComming addChild:Label z:10];
                
                
            }
            
            slotIcon.anchorPoint     = ccp(0.5f, 0.62f);
            slotIcon.tag             = machineTag + 1;
            [slotIcon setScale:1.2];
            machineTag               = slotIcon.tag;
            [page_ addChild:slotIcon];
            
            //if (goBlack) { slotIcon.color = ccBLACK; }
            
            switch (x)
            {
                case 1: slotIcon.position = ccp(kWidthScreen * iconW1,  kHeightScreen * iconH2); break;
                case 2: slotIcon.position = ccp(kWidthScreen * iconW2,  kHeightScreen * iconH2); break;
                case 3: slotIcon.position = ccp(kWidthScreen * iconW3,  kHeightScreen * iconH2); break;
                case 4: slotIcon.position = ccp(kWidthScreen * iconW1,  kHeightScreen * iconH1); break;
                case 5: slotIcon.position = ccp(kWidthScreen * iconW2,  kHeightScreen * iconH1); break;
                case 6: slotIcon.position = ccp(kWidthScreen * iconW3,  kHeightScreen * iconH1); break;
                default: break;
            }
        }
        
        [a addObject:page_];
    }
    return [NSArray arrayWithArray:a];
}

// Creates new Scroll Layer with pages returned from scrollLayerPages.
- (CCScrollLayer *) scrollLayer
{
    numOfPages              = 1;
    numberOfButtonsInPage   = 1;
    
	// Create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages).
	CCScrollLayer *scroller = [CCScrollLayer nodeWithLayers: [self scrollLayerPages:numOfPages - 1 buttonsInPage:numberOfButtonsInPage]
                                                widthOffset: 0.1f *kWidthScreen ];
    
	//scroller.pagesIndicatorPosition = ccp(kWidthScreen * 0.5f, 30.0f);

    // New feature: margin offset - to slowdown scrollLayer when scrolling out of it contents.
    // Comment this line or change marginOffset to screenSize.width to disable this effect.
    //scroller.marginOffset = kWidthScreen * 0.2f;
	
	return scroller;
}

#pragma mark Callbacks

-(void)startPage
{
	CCScrollLayer *scroller = (CCScrollLayer *)[self getChildByTag:100];
	[scroller moveToPage: startPage];
}

-(void) onEnter
{
 //   int priority = -10;//kCCMenuTouchPriority - 2;
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_Menu swallowsTouches:YES];
    
    [[AnalyticsManager sharedManager] trackScreenView:kNodeLobby];
    
    [super onEnter];
}

-(void)onExit
{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:[NSString stringWithFormat:@"sp_arrow.plist"]];
    
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    
    [super onExit];
}

-(void) unblockArrows
{
    if (blockArrow)
    {
        blockArrow = false;
    }
    
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    if (CGRectContainsPoint([self getChildByTag:1901].boundingBox,touchPos))
    {
        NSLog(@"Rate button touched");
        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"rateapp_pressed.png"];
        [[self getChildByTag:1901] setTexture: tex];
        //[[self getChildByTag:1901] setScale:0.4];
    }
    else if (CGRectContainsPoint([self getChildByTag:1902].boundingBox,      touchPos))
    {
        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"freegames_pressed.png"];
        [[self getChildByTag:1902] setTexture: tex];
        //[[self getChildByTag:1902] setScale:0.4];
        NSLog(@"Freeapp button touched");
        
    }
    else if (CGRectContainsPoint([self getChildByTag:1903].boundingBox,      touchPos))
    {
        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"moregames_pressed.png"];
        [[self getChildByTag:1903] setTexture: tex];
        //[[self getChildByTag:1903] setScale:0.4];
        NSLog(@"More games touched");
        
    }
    else if (CGRectContainsPoint([self getChildByTag:1904].boundingBox,      touchPos))
    {
        NSLog(@"Paytables touhed");

        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"paytables_pressed.png"];
        [[self getChildByTag:1904] setTexture: tex];
        //[[self getChildByTag:1904] setScale:0.4];
    }else{
    
    
    
    //id buttonAnimation1 = [CCScaleTo actionWithDuration:0.05f scale:0.9f];
    //id buttonAnimation2 = [CCScaleTo actionWithDuration:0.05f scale:1.0f];
    //id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
    
    //id buttonAnimation_ = [CCScaleTo actionWithDuration:0.03f scale:0.9f];
   // id buttonEase       = [CCEaseInOut actionWithAction:buttonAnimation_ rate:1.5f];
    
    
    
//    if (![(CCScrollLayer *)[self getChildByTag:100] getActionByTag:1234])
//    {
//        
//        // go left
//        if (CGRectContainsPoint(goLeft_rect, touchPos))
//        {
//            
//            [goLeftButton runAction:runAnimation];
//            [self goToPreviousP];
//            
//            if (iPageNum > 0)
//            {
//                 [AUDIO playEffect:s_click1];
//                //[[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//            }
//            return YES;
//        }
//
//    
//    if (![(CCScrollLayer *)[self getChildByTag:100] getActionByTag:1234])
//    {
//        // go right
//        
//        if (CGRectContainsPoint(goRight_rect, touchPos))
//        {
//            [goRightButton runAction:runAnimation];
//            [self goToNextP];
//            
//            if (iPageNum + 1 < numOfPages)
//            {
//                 [AUDIO playEffect:s_click1];
//             //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//            }
//            return YES;
//        }
//    }
//    
//    }
    for (CCNode *ss in [[self getChildByTag:100] getChildByTag:iPageNum].children)
    {
        int tagNR;
        
        if      (iPageNum == 0) { tagNR =  0; }
        else if (iPageNum == 1) { tagNR =  6; }
        else if (iPageNum == 2) { tagNR = 12; }
        else if (iPageNum == 3) { tagNR = 18; }
        else if (iPageNum == 4) { tagNR = 24; }
        else if (iPageNum == 5) { tagNR = 30; }
        else if (iPageNum == 6) { tagNR = 36; }
        else if (iPageNum == 7) { tagNR = 42; }
        
        if (CGRectContainsPoint(ss.boundingBox,      touchPos) && ss.tag == tagNR + 1)
        {
            //[ss runAction:buttonEase];
            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
            ss.scale = 0.9f;
            }
 
        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 2)
        {
            //[ss runAction:buttonEase];
            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
                ss.scale = 0.9f;
            }

        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 3)
        {
            //[ss runAction:buttonEase];
            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
                ss.scale = 0.9f;
            }

        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 4)
        {
            //[ss runAction:buttonEase];
            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
                ss.scale = 0.9f;
            }

        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 5)
        {
            //[ss runAction:buttonEase];
            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
                ss.scale = 0.9f;
            }
   
        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && ss.tag == tagNR + 6)
        {
            //[ss runAction:buttonEase];
            if(![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]){
                ss.scale = 0.9f;
            }
    
            
        }
        if (IS_STANDARD_IPHONE_6_PLUS) {
            ss.scale = 1.6;
        }
    }
    }
    return YES;
}
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    //CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
//    //id buttonAnimation2 = [CCScaleTo actionWithDuration:0.03f scale:1.0f];
//    //id buttonEase       = [CCEaseInOut actionWithAction:buttonAnimation2 rate:1.5f];
//    for (CCNode *ss in [[self getChildByTag:100] getChildByTag:iPageNum].children)
//    {
//        //[ss runAction:[buttonEase copy]];
//        ss.scale = 1.2f;
//    }

}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    //id buttonAnimation2 = [CCScaleTo actionWithDuration:0.03f scale:1.0f];
    //id buttonEase       = [CCEaseInOut actionWithAction:buttonAnimation2 rate:1.5f];
    

    
    [[self getChildByTag:1901] setTexture: [[CCTextureCache sharedTextureCache] addImage:@"rateapp.png"]];
    //[[self getChildByTag:1901] setScale:0.6];
    [[self getChildByTag:1902] setTexture: [[CCTextureCache sharedTextureCache] addImage:@"freegames.png"]];
    //[[self getChildByTag:1902] setScale:0.6];
    [[self getChildByTag:1903] setTexture: [[CCTextureCache sharedTextureCache] addImage:@"moregames.png"]];
    //[[self getChildByTag:1903] setScale:0.6];
    [[self getChildByTag:1904] setTexture: [[CCTextureCache sharedTextureCache] addImage:@"paytables.png"]];
    //[[self getChildByTag:1904] setScale:0.6];
    
     BOOL didCaptureButtonTap = NO;
    if (CGRectContainsPoint([self getChildByTag:1901].boundingBox,touchPos))
    {
        [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonRate];
        didCaptureButtonTap = YES;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrl]];
    }
    else if (CGRectContainsPoint([self getChildByTag:1902].boundingBox,      touchPos))
    {
        [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonBuyCoins];
        didCaptureButtonTap = YES;
        [TMenu openBuyWindow_withNR:@1];
    }
    else if (CGRectContainsPoint([self getChildByTag:1903].boundingBox,      touchPos))
    {
        [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonMoreGames];
        didCaptureButtonTap = YES;
        [Chartboost showMoreApps:CBLocationHomeScreen];
        [[AnalyticsManager sharedManager] trackScreenView:kNodeMoreGames];
    }
    else if (CGRectContainsPoint([self getChildByTag:1904].boundingBox,      touchPos))
    {
        [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonPayTable];
        didCaptureButtonTap = YES;
        PayTableWindow* payTable = [[PayTableWindow alloc] init_withMachineNR:[machineID intValue]];
        payTable.position = CGPointMake(self.boundingBox.size.width/2,self.boundingBox.size.height/2);
        [self.parent addChild:payTable];
    }
    
    

    
    for (CCNode *ss in [[self getChildByTag:100] getChildByTag:iPageNum].children)
    {
        int tagNR;
        
        if      (iPageNum == 0) { tagNR =  0; }
        else if (iPageNum == 1) { tagNR =  6; }
        else if (iPageNum == 2) { tagNR = 12; }
        else if (iPageNum == 3) { tagNR = 18; }
        else if (iPageNum == 4) { tagNR = 24; }
        else if (iPageNum == 5) { tagNR = 30; }
        else if (iPageNum == 6) { tagNR = 36; }
        else if (iPageNum == 7) { tagNR = 42; }
    
        ss.scale = 1.2f;
        
        if (CGRectContainsPoint(ss.boundingBox,      touchPos) && (ss.tag == tagNR + 1))
        {
            
            [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonSlot value:@(tagNR+1)];
            didCaptureButtonTap = YES;
            if ([ss getChildByTag:kLockTag]) {
                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                 [AUDIO playEffect:s_lockedmachine];
            }
            else if ([ss getChildByTag:kCoomTag])
            {
                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            
            if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
            
                [self loading];
            
          //      [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
                [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:1]], nil]];
            }
        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 2))
        {
            [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonSlot value:@(tagNR+2)];
            didCaptureButtonTap = YES;

            if ([ss getChildByTag:kLockTag]) {
                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            else if ([ss getChildByTag:kCoomTag])
            {
                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            
             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
                 [self loading];
            
       //           [AUDIO playEffect:s_click1];
                 //[[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
            
                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:2]], nil]];
             }
        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 3))
        {
            [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonSlot value:@(tagNR+3)];
            didCaptureButtonTap = YES;

            if ([ss getChildByTag:kLockTag]) {
                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            else if ([ss getChildByTag:kCoomTag])
            {
                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            
             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
                 [self loading];
            
            //     [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
            
                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:3]], nil]];
             }
        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 4))
        {
            [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonSlot value:@(tagNR+4)];
            didCaptureButtonTap = YES;

            if ([ss getChildByTag:kLockTag]) {
                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            else if ([ss getChildByTag:kCoomTag])
            {
                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            
             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
                 [self loading];
            
            //     [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
            
                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:4]], nil]];
             }
        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 5))
        {
            [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonSlot value:@(tagNR+5)];
            didCaptureButtonTap = YES;

            if ([ss getChildByTag:kLockTag]) {
                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            else if ([ss getChildByTag:kCoomTag])
            {
                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            
             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
            
                 [self loading];
            
               //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
            
                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:5]], nil]];
             }
        }
        else if (CGRectContainsPoint(ss.boundingBox, touchPos) && (ss.tag == tagNR + 6))
        {
            [[AnalyticsManager sharedManager] trackButtonTap:kNodeLobbyButtonSlot value:@(tagNR+6)];
            didCaptureButtonTap = YES;
            if ([ss getChildByTag:kLockTag]) {
                [[ss getChildByTag:kLockTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            else if ([ss getChildByTag:kCoomTag])
            {
                [[ss getChildByTag:kCoomTag] runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.1f scale:0.85f],[CCScaleTo actionWithDuration:0.1f scale:1.f], nil] times:1]];
                [AUDIO playEffect:s_lockedmachine];
            }
            
            
             if (![ss getChildByTag:kLockTag] && ![ss getChildByTag:kCoomTag]) {
                 [self loading];
            
              //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
            
                 [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.06f],[CCCallFuncO actionWithTarget:self selector:@selector(goToMachineNR:) object:[NSNumber numberWithInt:6]], nil]];
             }
        }
    }
    
    if(!didCaptureButtonTap)
    {
        [[AnalyticsManager sharedManager] trackScreenTapPoint:touchPos];
    }
    
}
-(void)loading
{
    UIView *view__ = [[[b6luxLoadingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) loading:kLOADING_MACHINE]autorelease];
    view__.tag = kLOADINGTAG;
    [[[CCDirector sharedDirector] openGLView]addSubview:view__];

}
-(void)loadingOff
{
    for (UIView *a in [[[CCDirector sharedDirector] openGLView]subviews]) {
        if ([a viewWithTag:kLOADINGTAG]) {
            [[a viewWithTag:kLOADINGTAG]removeFromSuperview];
        }
    }
    
  //  SOUND_.musicVolume = 0.5f;
    [(PopupManager *)[self getChildByTag:kSpeWindowTAG] setUp:kWindowSpecialBonus someValue:0];
}


-(void) goToMachineNR:(NSNumber *)machineNumber
{
   /// SOUND_.musicVolume = 0.15f;
    
    [AUDIO stopBackgroundMusic];
    
     [AUDIO playEffect:s_click1];
    
    [[CCDirector sharedDirector] replaceScene:[SlotMachine sceneWithMachineNr:machineNumber.intValue]];
}

////////////////////// TOP MENU ////////////////////////////////////////////////////////////////////////
-(void)topMenuType:(int) menuType
{
    if (![self getChildByTag:kTopMenuTAG]) {
        
        float coins_  = [DB_ getValueBy:d_Coins table:d_DB_Table];
        
        int exp_    = [DB_ getValueBy:d_Exp table:d_DB_Table];
        
        TMenu = [[[TopMenu alloc] initWithRect:CGRectMake(0, kHeightScreen * 0.8f, kWidthScreen, kHeightScreen * 0.2f) type:menuType experience:exp_ coins:coins_] autorelease];
        
        TMenu.anchorPoint = ccp(0,0);
        TMenu.position = ccp(TMenu.position.x, kHeightScreen);
        [self addChild:TMenu z:11 tag:kTopMenuTAG];
        
        [TMenu runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.0f position:ccp(0, 0)] rate:1]];
    }
}

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
////////////////////// SPECIAL BONUS /////////////////////////////////////////////////////////////////
-(void) openSBonusWindow
{
    PopupManager *SBWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
    SBWindow.anchorPoint = ccp(0, 0);
    [self addChild:SBWindow z:10 tag:kSpeWindowTAG];
    
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
    [self removeChild:(BottomMenu *)[self getChildByTag:kBottomMenuTAG] cleanup:YES];
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

-(void)coinAnimation:(int)coins
{
    CFA.coinsNumber = coins;
    [CFA startFlyAct];
}

-(void)prepareCoinsFlyAct{
    
    CFA = [[[coinsFA alloc]init]autorelease];
    [self addChild:CFA z:999 tag:929];
    CFA.startPosition = ccp(kWidthScreen*0.5f,kHeightScreen*0.f);//kHeightScreen*0.05f);
    [CFA setup_];
}

//////////////////////////////////////////////////// Buttons to change pages ///////////////////
-(void) nextPageButtons
{
    goLeftButton                  = [CCSprite spriteWithSpriteFrameName:@"arrow.png"];
    goLeftButton.anchorPoint      = ccp(0.5f, 0.5f);
    goLeftButton.flipX            = YES;
    goLeftButton.position         = ccp(kWidthScreen * 0.05f, kHeightScreen * 0.52f);
    goLeftButton.tag              = kGoLeft;
    [self addChild:goLeftButton];
    
    goRightButton                 = [CCSprite spriteWithSpriteFrameName:@"arrow.png"];
    goRightButton.anchorPoint     = ccp(0.5f, 0.5f);
    goRightButton.position        = ccp(kWidthScreen * 0.95f, kHeightScreen * 0.52f);
    goRightButton.tag             = kGoRight;
    [MENU_ addChild:goRightButton];
    
    [goLeftButton runAction:[CCTintTo actionWithDuration:0 red:100 green:100 blue:100]];
    [goRightButton runAction:[CCTintTo actionWithDuration:0 red:100 green:100 blue:100]];
    
    //[goLeftButton addChild:[SCombinations boxWithColor:ccc4(135, 220, 101, 100) pos:goLeftButton.position size:goLeftButton.contentSize]];
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
/////////////////////////////////////////////////////////////////////

-(void) goToNextP
{
    if (iPageNum < numOfPages)
    {
        CCScrollLayer *s = (CCScrollLayer *)[self getChildByTag:100];
        [s makeBool];
        [s moveToPage:[s currentScreen] + 1];
    }
}

-(void) goToPreviousP
{
    if (iPageNum >= 1)
    {
        CCScrollLayer *s = (CCScrollLayer *)[self getChildByTag:100];
        [s makeBool];
        [s moveToPage:[s currentScreen] - 1];
    }
}
///////////////////////////////////////////////////////////////////////////////////////////////


@end

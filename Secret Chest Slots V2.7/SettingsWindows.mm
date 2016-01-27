#import "SettingsWindows.h"
#import "cfg.h"
#import "Constants.h"
#import "PopupManager.h"
#import "Reels.h"
#import "SlotMachine.h"
#import "SKNode+SKNode_Extensions.h"

@interface SettingsWindows()

// Sprites.
@property (nonatomic, strong) SKSpriteNode* background;
@property (nonatomic, strong) SKSpriteNode* closeBtn;
@property (nonatomic, strong) SKSpriteNode* slideBg1;
@property (nonatomic, strong) SKSpriteNode* slideBg2;
@property (nonatomic, strong) SKSpriteNode* button1;
@property (nonatomic, strong) SKSpriteNode* button2;

@property (nonatomic, strong) SKSpriteNode* show_LeaderBoardButton;
@property (nonatomic, strong) SKSpriteNode* show_AchievementsButton;
@property (nonatomic, strong) SKSpriteNode* show_AboutButton;
@property (nonatomic, strong) SKSpriteNode* autoSpinButton;

// Label.
@property (nonatomic, strong) SKLabelNode* developedByLabel;
@property (nonatomic, strong) SKLabelNode* b6luxLabel;
@property (nonatomic, strong) SKLabelNode* codeLabel;
@property (nonatomic, strong) SKLabelNode* artLabel;
@property (nonatomic, strong) SKLabelNode* toolsLabel;
@property (nonatomic, strong) SKLabelNode* cocos2dLabel;
@property (nonatomic, strong) SKLabelNode* eLabel;
@property (nonatomic, strong) SKLabelNode* mLabel;
@property (nonatomic, strong) SKLabelNode* sLabel;
@property (nonatomic, strong) SKLabelNode* jLabel;
@property (nonatomic, strong) SKLabelNode* musicLabel;
@property (nonatomic, strong) SKLabelNode* soundLabel;
@property (nonatomic, strong) SKLabelNode* onLabel;
@property (nonatomic, strong) SKLabelNode* offLabel;
@property (nonatomic, strong) SKLabelNode* on2Label;
@property (nonatomic, strong) SKLabelNode* off2Label;
@property (nonatomic, strong) SKLabelNode* menuLabel;
@property (nonatomic, strong) SKLabelNode* showLBlabel;
@property (nonatomic, strong) SKLabelNode* showAClabel;
@property (nonatomic, strong) SKLabelNode* aboutButtonLabel;
@property (nonatomic, strong) SKLabelNode* autoSpinLabel;

// Textures.
@property (nonatomic, strong) SKTexture* Btn_Active;
@property (nonatomic, strong) SKTexture* Btn_notActive;
@property (nonatomic, strong) SKTexture* Btn_Active2;
@property (nonatomic, strong) SKTexture* Btn_notActive2;
@property (nonatomic, strong) SKTexture* closeBtn_Active;
@property (nonatomic, strong) SKTexture* closeBtn_notActive;

@end



@implementation SettingsWindows


-(NSString*)prefix
{
    if (IS_IPAD)return @"";return @"_iPhone";
}

-(id)init
{
    if((self = [super init]))
    {
        self.name = kNodeSettings;
    }
    
    return self;
}

-(void)setUp:(int)state
{
    self.size = CGSizeMake(kWidthScreen, kHeightScreen);
    
    state__ = state;
    //// SCALE EFFECT
    self.scale = 0.3f;
    id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.2f];
    id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
    
    id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.97f];
    id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
    
    id scale3       = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    [self runAction:[CCSequence actions:easeScale1,easeScale2,easeScale3, nil]];
    
//          SETTINGS_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_settings_menu.pvr.ccz"]];
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_settings_menu.plist"]];
//        [self addChild:SETTINGS_MENU_ z:12];
        
        self.background             = [SKSpriteNode spriteNodeWithImageNamed:@"settingsMenuBG.png"];
        self.background.anchorPoint = ccp(0.5f, 0.5f);
        //background.scaleY      = 1.f;
        self.background.position    = ccp(kWidthScreen / 2, kHeightScreen / 2);
#warning EF is self.background ever added to stage?
//        [SETTINGS_MENU_ addChild:self.background];
    
        self.Btn_Active                 = [SKTexture textureWithImageNamed:@"menuBTN_active.png"];
        self.Btn_notActive              = [SKTexture textureWithImageNamed:@"menuBTN.png"];
        self.Btn_Active2                = [SKTexture textureWithImageNamed:@"menuBTN_active2.png"];
        self.Btn_notActive2             = [SKTexture textureWithImageNamed:@"menuBTN2.png"];
        self.closeBtn_Active            = [SKTexture textureWithImageNamed:@"menuBTN_close_active.png"];
        self.closeBtn_notActive         = [SKTexture textureWithImageNamed:@"menuBTN_close.png"];
    
    if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
    

    
    
    /*
        // restore music button position
        if ([CDAudioManager sharedManager].backgroundMusic.volume == 1.0f)
        { B1on = true;}
        else if ([CDAudioManager sharedManager].backgroundMusic.volume == 0.0f)
        { B1on = false;}
        
        // restore sound fx button position
        if ([CDAudioManager sharedManager].soundEngine.masterGain == 1.0f)
        { B2on = true;}
        else if ([CDAudioManager sharedManager].soundEngine.masterGain == 0.0f)
        { B2on = false;}
   */
    
    
    //music on of settings
        
        [self addCloseButton];
    
        if (state == 1) {
            [self addButtonsBg];
        }
        else if (state == 2)
        {
            [self menuSett];
        }
    
    //    [self setOnOffLabelsOpacity];
    
    
    if (state == 2) {
#warning EF check this parent.parent crap
//        if ([this.parent.parent.parent isKindOfClass:[SlotMachine class]]) {
//            if(![(Reels *)[_parent.parent.parent getChildByTag:5] checkAutoSpin])
//            {
//                [self.autoSpinButton setTexture:self.Btn_notActive];
//            }
//            else
//            {
//                [self.autoSpinButton setTexture:self.Btn_Active];
//            }
//        }
    }
    
    
    
    if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
     //   NSLog(@"MUSIC MUST BE ON");
        [self.onLabel setText:@"ON"];
        self.onLabel.hidden = YES;
        self.onLabel.alpha = 255/255.0;
        
    }
    else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
      //  NSLog(@"MUSIC MUST BE OFF");
        [self.onLabel setText:@"OFF"];
    }
    
    if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
       // NSLog(@"sound MUST BE ON");
        [self.on2Label setText:@"ON"];
        self.on2Label.hidden = YES;
        self.on2Label.alpha = 255/255.0;
    }
    else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
       // NSLog(@"sound MUST BE OFF");
        [self.on2Label setText:@"OFF"];
    }
}

-(void) addBlackBackground
{
#warning EF
    SKShapeNode* blackShape = [SKShapeNode shapeNodeWithRect:CGRectMake(0,0,kWidthScreen,kHeightScreen)];
//    blackShape.anchorPoint = CGPointZero;
    blackShape.alpha = 0.0;
    blackShape.fillColor = [SKColor blackColor];
    blackShape.name = kNodeBlackBackground;
    [self addChildToTopZ:blackShape];
//    CCSprite *spr   = [CCSprite node];
//    spr.textureRect = CGRectMake(0,0,kWidthScreen,kHeightScreen);
//    spr.opacity     = 0;
//    spr.anchorPoint = ccp(0, 0);
//    spr.color       = ccc3(255,255,255);
//    [self addChild:spr z:0 tag:kBlackBackgroundTAG];
}


-(void)menuSett
{
    self.show_LeaderBoardButton              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive];
    self.show_LeaderBoardButton.anchorPoint  = ccp(0.5f, 0.5f);
    self.show_LeaderBoardButton.position     = ccp(kWidthScreen/2, self.background.position.y);
    [self addChildToTopZ:self.show_LeaderBoardButton];
//    [SETTINGS_MENU_ addChild:self.show_LeaderBoardButton z:10];
    
    self.show_AboutButton              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive];
    self.show_AboutButton.anchorPoint  = ccp(0.5f, 0.5f);
    self.show_AboutButton.position     = ccp(kWidthScreen/2, self.show_LeaderBoardButton.position.y - self.show_LeaderBoardButton.size.height*1.3f);
    [self addChildToTopZ:self.show_AboutButton];
    
    //    show_AchievementsButton              = [SKSpriteNode spriteNodeWithTexture:@"menuBTN.png"];
    //    show_AchievementsButton.anchorPoint  = ccp(0.5f, 0.5f);
    //    show_AchievementsButton.position     = ccp(kWidthScreen/2, show_LeaderBoardButton.position.y + show_LeaderBoardButton.size.height/2 + kHeightScreen*0.07f);
    //    [SETTINGS_MENU_ addChild:show_AchievementsButton z:10];
    
    //    autoSpinButton              = [SKSpriteNode spriteNodeWithTexture:@"menuBTN.png"];
    //    autoSpinButton.anchorPoint  = ccp(0.5f, 0.5f);
    //    autoSpinButton.position     = ccp(kWidthScreen/2, show_AchievementsButton.position.y + show_AchievementsButton.size.height/2 + kHeightScreen*0.07f);
    //    [SETTINGS_MENU_ addChild:autoSpinButton z:10];
    //
    
    // -----------------------------------------
    
    self.button1              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive2 ];
    self.button1.anchorPoint  = ccp(0.0f, 0.5f);
    self.button1.position     = ccp(self.background.position.x - self.button1.size.width*0.05f, self.background.position.y + self.background.size.height*0.25f);
    [self addChildToTopZ:self.button1];
    
    self.button2              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive2];
    self.button2.anchorPoint  = ccp(0.0f, 0.5f);
    self.button2.position     = ccp(self.background.position.x - self.button1.size.width*0.05f, self.background.position.y + self.background.size.height*0.14f);
    [self.button2 addChildToTopZ:self.button2];
    
    [self labels];

}
-(void)addButtonsBg
{
    
    self.autoSpinButton              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive];
    self.autoSpinButton.anchorPoint  = ccp(0.5f, 0.5f);
    self.autoSpinButton.position     = ccp(kWidthScreen/2, self.background.position.y);
    [self addChildToTopZ:self.autoSpinButton];
//    [SETTINGS_MENU_ addChild:autoSpinButton z:10];
    
    self.show_LeaderBoardButton              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive];
    self.show_LeaderBoardButton.anchorPoint  = ccp(0.5f, 0.5f);
    self.show_LeaderBoardButton.position     = ccp(kWidthScreen/2, self.autoSpinButton.position.y - self.autoSpinButton.size.height*1.3f);
    [self addChildToTopZ:self.show_LeaderBoardButton];
//    [SETTINGS_MENU_ addChild:show_LeaderBoardButton z:10];
    
    self.show_AboutButton              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive];
    self.show_AboutButton.anchorPoint  = ccp(0.5f, 0.5f);
    self.show_AboutButton.position     = ccp(kWidthScreen/2, self.show_LeaderBoardButton.position.y - self.show_LeaderBoardButton.size.height*1.3f);
    [self addChildToTopZ:self.show_AboutButton];
//    [SETTINGS_MENU_ addChild:show_AboutButton z:10];
    
    //    show_AchievementsButton              = [SKSpriteNode spriteNodeWithTexture:@"menuBTN.png"];
    //    show_AchievementsButton.anchorPoint  = ccp(0.5f, 0.5f);
    //    show_AchievementsButton.position     = ccp(kWidthScreen/2, show_LeaderBoardButton.position.y + show_LeaderBoardButton.size.height/2 + kHeightScreen*0.07f);
    //    [SETTINGS_MENU_ addChild:show_AchievementsButton z:10];
    
        //
    
    // -----------------------------------------
    
    self.button1              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive2];
    self.button1.anchorPoint  = ccp(0.0f, 0.5f);
    //button1.scaleX       = .5f;
    self.button1.position     = ccp(self.background.position.x - self.button1.size.width*0.05f, self.background.position.y + self.background.size.height*0.25f);
    [self addChildToTopZ:self.button1];
    
    self.button2              = [SKSpriteNode spriteNodeWithTexture:self.Btn_notActive2];
    self.button2.anchorPoint  = ccp(0.0f, 0.5f);
    //button2.scaleX       = .5f;
    self.button2.position     = ccp(self.background.position.x - self.button1.size.width*0.05f, self.background.position.y + self.background.size.height*0.14f);
    [self addChildToTopZ:self.button2];
//    [SETTINGS_MENU_ addChild:button2 z:13];
    [self labels];
 
}
-(void)labels
{
    // ----------------LABELs-----------------------
    /////////////////////////////////////////////////////////////
    
    self.developedByLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS2];
    self.developedByLabel.text = @"DEVELOPED BY";
    self.developedByLabel.position = ccp(kWidthScreen/2, self.background.position.y + self.background.size.height*0.35f);
    self.developedByLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.developedByLabel.alpha  = 0;
    if (iPhone3) { self.developedByLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.developedByLabel.scale = 1.15;
    }
    [self addChildToTopZ:self.developedByLabel];
    
    self.b6luxLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];
    self.b6luxLabel.text = @"Outlandish Apps LLC";
    self.b6luxLabel.position = ccp(kWidthScreen/2, self.developedByLabel.position.y - self.background.size.height*0.05f);
    self.b6luxLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.b6luxLabel.alpha  = 0;
    if (iPhone3) { self.b6luxLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.b6luxLabel.scale = 1.15;
    }
    [self addChildToTopZ:self.b6luxLabel];
    
    
    /////////////////////////////////////////////////////////////
    
    self.codeLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS2];
    self.codeLabel.text = @"Update By";
    self.codeLabel.position = ccp(kWidthScreen/2, self.b6luxLabel.position.y - self.background.size.height*0.10f);
    self.codeLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.codeLabel.alpha  = 0;
    if (iPhone3) { self.codeLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.codeLabel.scale = 1.15;
    }
    [self addChildToTopZ:self.codeLabel];
    
    self.eLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];
    self.eLabel.text         = @"Outlandish Apps LLC";
    self.eLabel.position = ccp(kWidthScreen/2, self.codeLabel.position.y - self.background.size.height*0.05f);
    self.eLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.eLabel.alpha  = 0;
    if (iPhone3) { self.eLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.eLabel.scale = 1.15;
    }
    [self addChildToTopZ:self.eLabel];
    
    
    self.mLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];
    self.mLabel.position = ccp(kWidthScreen/2, self.eLabel.position.y - self.background.size.height*0.05f);
    self.mLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.mLabel.alpha  = 0;
    if (iPhone3) { self.mLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.mLabel.scale = 1.3;
    }
    [self addChildToTopZ:self.mLabel];
    
    
    self.sLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];
    self.sLabel.position = ccp(kWidthScreen/2, self.mLabel.position.y - self.background.size.height*0.05f);
    self.sLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.sLabel.alpha  = 0;
    if (iPhone3) { self.sLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.sLabel.scale = 1.3;
    }
    [self addChildToTopZ:self.sLabel];
    
    
    /////////////////////////////////////////////////////////////
    
    self.artLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS2];
    self.artLabel.position = ccp(kWidthScreen/2, self.sLabel.position.y - self.background.size.height*0.10f);
    self.artLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.artLabel.alpha  = 0;
    if (iPhone3) { self.artLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.artLabel.scale = 1.3;
    }
    [self addChildToTopZ:self.artLabel];
    //    [self addChild:self.artLabel z:13];
    
    self.jLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];
    self.jLabel.position = ccp(kWidthScreen/2, self.artLabel.position.y - self.background.size.height*0.05f);
    self.jLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.jLabel.alpha  = 0;
    if (iPhone3) { self.jLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.jLabel.scale = 1.3;
    }
    [self addChildToTopZ:self.jLabel];
    //    [self addChild:jLabel z:13];
    
    /////////////////////////////////////////////////////////////
    
    NSString *musicInfo = @"\nMusic by JewelBeat.\nDownload your free music and \nfree sound effects at\n www.jewelbeat.com.";
    
    self.toolsLabel          = [CCLabelBMFont labelWithString:musicInfo fntFile:kFONT_SETTINGS];
    self.toolsLabel.position = ccp(kWidthScreen/2, self.jLabel.position.y - self.background.size.height*0.10f);
    self.toolsLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    self.toolsLabel.alpha  = 0;
    self.toolsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    if (iPhone3) { self.toolsLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.toolsLabel.scale = 1.2;
    }
    [self addChildToTopZ:self.toolsLabel];
    
    
    /*
     cocos2dLabel          = [CCLabelBMFont labelWithString:@"COCOS2D" fntFile:kFONT_SETTINGS];
     cocos2dLabel.position = ccp(kWidthScreen/2, toolsLabel.position.y - background.size.height*0.05f);
     cocos2dLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
     cocos2dLabel.opacity  = 0;
     if (iPhone3) { cocos2dLabel.scale = 0.60f; }
     [self addChild:cocos2dLabel z:13];
     */
    /////////////////////////////////////////////////////////////
    
    self.musicLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];//[CCLabelBMFont labelWithString:@"MUSIC" fntFile:kFONT_SETTINGS];
    self.musicLabel.text = @"MUSIC";
    self.musicLabel.position = ccp(self.background.position.x - self.background.size.width*0.2f, self.button1.position.y);
    self.musicLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    if (iPhone3) { self.musicLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.musicLabel.scale = 1.6;
    }
    [self addChildToTopZ:self.musicLabel];
    
    
    self.soundLabel          = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];//[CCLabelBMFont labelWithString:@"SOUND" fntFile:kFONT_SETTINGS];
    self.soundLabel.text = @"SOUND";
    self.soundLabel.position = ccp(self.background.position.x - self.background.size.width*0.2f, self.button2.position.y);
    self.soundLabel.color    = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    if (iPhone3) { self.soundLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.soundLabel.scale = 1.6;
    }
    [self addChildToTopZ:self.soundLabel];
    
    
    self.menuLabel           = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS2];//[CCLabelBMFont labelWithString:@"MENU" fntFile:kFONT_SETTINGS2];
    self.menuLabel.text = @"MENU";
    self.menuLabel.position  = ccp(kWidthScreen/2, self.background.position.y + self.background.size.height/2 - kHeightScreen*0.05f);
    self.menuLabel.color     = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    if (iPhone3) { self.menuLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.menuLabel.scale = 1.6;
    }
    [self addChildToTopZ:self.musicLabel];
    
    //------------------------------------------
    self.onLabel           = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];//[CCLabelBMFont labelWithString:@"ON" fntFile:kFONT_SETTINGS];
    self.onLabel.text = @"ON";
    self.onLabel.position  = ccp(self.button1.position.x + self.button1.size.width/2, self.button1.position.y);
    self.onLabel.color     = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    if (iPhone3) { self.onLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.onLabel.scale = 1.6;
    }
    [self addChildToTopZ:self.onLabel];
//    [self addChild:self.onLabel z:12];
    
    //
    self.on2Label           = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];//[CCLabelBMFont labelWithString:@"ON" fntFile:kFONT_SETTINGS];
    self.on2Label.text = @"ON";
    self.on2Label.position  = ccp(self.button2.position.x + self.button2.size.width/2, self.button2.position.y);
    self.on2Label.color     = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    if (iPhone3) { self.on2Label.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.on2Label.scale = 1.6;
    }
    [self addChildToTopZ:self.on2Label];
//    [self addChild:self.on2Label z:12];
    
    /*
     offLabel           = [CCLabelBMFont labelWithString:@"ON" fntFile:kFONT_SETTINGS];
     //    offLabel.position  = ccp(button1.position.x + button1.size.width/2, button1.position.y);
     //    offLabel.color     = [SKColor lightTextColor]; //ccc3(69, 42, 4);
     //    if (iPhone3) { offLabel.scale = 0.60f; }
     //    [self addChild:offLabel z:12];
     
     off2Label           = [CCLabelBMFont labelWithString:@"ON" fntFile:kFONT_SETTINGS];
     //    off2Label.position  = ccp(button2.position.x + button2.size.width/2, button2.position.y);
     //    off2Label.color     = [SKColor lightTextColor]; //ccc3(69, 42, 4);
     //    if (iPhone3) { off2Label.scale = 0.60f; }
     //    [self addChild:off2Label z:12];
     */
    
    self.showLBlabel             = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS]; //[CCLabelBMFont labelWithString:@"LEADERBOARDS" fntFile:kFONT_SETTINGS];
    //    self.showLBlabel.anchorPoint = ccp(0.5f, 0.5f);
    self.showLBlabel.text = @"LEADERBOARDS";
    self.showLBlabel.position    = ccp(self.show_LeaderBoardButton.position.x, self.show_LeaderBoardButton.position.y);
    self.showLBlabel.color       = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    if (iPhone3) { self.showLBlabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.showLBlabel.scale = 1.6;
    }
    [self addChildToTopZ:self.showLBlabel];
//    [self addChild:self.showLBlabel z:13];
    
    
    //    showAClabel             = [CCLabelBMFont labelWithString:@"ACHIEVEMENTS" fntFile:kFONT_SETTINGS];
    //    showAClabel.anchorPoint = ccp(0.5f, 0.5f);
    //    showAClabel.position    = ccp(show_AchievementsButton.position.x, show_AchievementsButton.position.y);
    //    showAClabel.color       = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    //    if (iPhone3) { showAClabel.scale = 0.60f; }
    //    [self addChild:showAClabel z:13];
    //
    if (state__ == 1) {
        
        self.autoSpinLabel             = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];//[CCLabelBMFont labelWithString:@"AUTOSPIN" fntFile:kFONT_SETTINGS];
        self.autoSpinLabel.text = @"AUTOSPIN";
        //        self.autoSpinLabel.anchorPoint = ccp(0.5f, 0.5f);
        self.autoSpinLabel.position    = ccp(self.autoSpinButton.position.x, self.autoSpinButton.position.y);
        self.autoSpinLabel.color       = [SKColor lightTextColor]; //ccc3(69, 42, 4);
        if (iPhone3) { self.autoSpinLabel.scale = 0.60f; }
        if (IS_STANDARD_IPHONE_6_PLUS) {
            self.autoSpinLabel.scale = 1.6;
        }
        [self addChildToTopZ:self.autoSpinButton];
//        [self addChild:self.autoSpinLabel z:13];
        
        
    }
    
    self.aboutButtonLabel             = [SKLabelNode labelNodeWithFontNamed:kFONT_SETTINGS];//[CCLabelBMFont labelWithString:@"ABOUT" fntFile:kFONT_SETTINGS];
    self.aboutButtonLabel.text = @"ABOUT";
    //    self.aboutButtonLabel.anchorPoint = ccp(0.5f, 0.5f);
    self.aboutButtonLabel.position    = ccp(self.show_AboutButton.position.x, self.show_AboutButton.position.y);
    self.aboutButtonLabel.color       = [SKColor lightTextColor]; //ccc3(69, 42, 4);
    if (iPhone3) { self.aboutButtonLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        self.aboutButtonLabel.scale = 1.6;
    }
    [self addChildToTopZ:self.aboutButtonLabel];
//    [self addChild:self.aboutButtonLabel z:13];
    //------------------------------------
    
    
}
-(void) setOnOffLabelsOpacity
{
    if (B1on == true)   { self.onLabel.alpha = 0/255.0; self.offLabel.alpha = 255/255.0; }
    else                { self.onLabel.alpha = 255; self.offLabel.alpha = 0/255.0; }
    
    if (B2on == true)   { self.on2Label.alpha = 0/255.0; self.off2Label.alpha = 255/255.0; }
    else                { self.on2Label.alpha = 255/255.0; self.off2Label.alpha = 0/255.0; }
}
-(void) addCloseButton
{
    self.closeBtn                   = [SKSpriteNode spriteNodeWithTexture:self.closeBtn_notActive];
    self.closeBtn.anchorPoint       = ccp(0.5f, 0.5f);
    self.closeBtn.position          = ccp(self.background.position.x + self.background.size.width/2, self.background.position.y + self.background.size.height/2);
    [self addChildToTopZ:self.closeBtn];
}


#warning EF
//-(void) onEnter
//{
//    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
//    [super onEnter];
//}
//
//-(void) onExit
//{
//    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
//    [super onExit];
//}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SKNode* touchedNode = [self nodeFromTouches:touches];
    
    
    if ([touchedNode isEqualToNode:self.closeBtn])
    {
        b7 = true;
        
        [AUDIO playEffect:s_click1];
        [self.closeBtn setTexture:self.closeBtn_Active];
    }
    
    if ([touchedNode isEqualToNode:self.button1])
    {
        b1 = true;
        [self.button1 setTexture:self.Btn_Active2];
    }
    
    if ([touchedNode isEqualToNode:self.button2])
    {
        b2 = true;
        [self.button2 setTexture:self.Btn_Active2];
    }
    
    if ([touchedNode isEqualToNode:self.autoSpinButton])
    {
        b3 = true;
#warning EF check this parent parent crap
//        if ([this.parent.parent.parent isKindOfClass:[SlotMachine class]]) {
//            //NSLog(@"PAR::   %@",_parent.parent.parent);
//            
//            if(![(Reels *)[_parent.parent.parent getChildByTag:5] checkAutoSpin])
//            {
//                float c = [DB_ getValueBy:d_Coins table:d_DB_Table];
//                
//                if (c > 0) {
//                    [(Reels *)[_parent.parent.parent getChildByTag:5] setAutoSpin:YES];
//                    [self.autoSpinButton setTexture:self.Btn_Active];
//                    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self  selector:@selector(closeSettingsWindow2)], nil]];
//                }
//                else
//                {
//                    [(TopMenu *)[_parent.parent.parent getChildByTag:kTopMenuTAG] openBuyWindow];
//                }
//            }
//            else
//            {
//                [(Reels *)[_parent.parent.parent getChildByTag:5] setAutoSpin:NO];
//                [self.autoSpinButton setTexture:self.Btn_notActive];
//            }
//        }
    }
    
    if ([touchedNode isEqualToNode:self.show_LeaderBoardButton])
    {
        b4 = true;
        [self.show_LeaderBoardButton setTexture:self.Btn_Active];
    }
    if ([touchedNode isEqualToNode:self.show_AchievementsButton])
    {
        b5 = true;
        [self.show_AchievementsButton setTexture:self.Btn_Active];
    }
    if ([touchedNode isEqualToNode:self.show_AboutButton])
    {
        b6 = true;
        [self.show_AboutButton setTexture:self.Btn_Active];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SKNode* touchedNode = [self nodeFromTouches:touches];
    
    if([touchedNode isEqualToNode:self.closeBtn])//
    {
        b7 = true;
        [self.closeBtn setTexture:self.closeBtn_notActive];
        [self closeSettingsWindow2];
    }
    
    if ([touchedNode isEqualToNode:self.button1])//CGRectContainsPoint(button1.boundingBox, touchPos))
    {
        //music
        
        if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
            [self.onLabel setText:@"OFF"];
            AUDIO.backgroundMusicVolume = 0;
            [Combinations saveNSDEFAULTS_Bool:NO forKey:sound_music];
        }
        else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
            [self.onLabel setText:@"ON"];
            if ( [(AppDelegate *)[[UIApplication sharedApplication] delegate]inMenu]) {
                AUDIO.backgroundMusicVolume = 0.5f;
            }
            else AUDIO.backgroundMusicVolume = 0.35f;
            [Combinations saveNSDEFAULTS_Bool:YES forKey:sound_music];
        }
        
        /*
         if (B1on == false)
         {
         B1on = true;
         NSLog(@"..MUSIC OFF..");
         [AUDIO setBackgroundMusicVolume:1];
         [self setOnOffLabelsOpacity];
         }
         else
         {
         B1on = false;
         NSLog(@"..MUSIC ON..");
         [AUDIO setBackgroundMusicVolume:0.f];
         [self setOnOffLabelsOpacity];
         }
         b1 = false;
         [button1 setTexture:Btn_notActive2];
         [AUDIO playEffect:s_click1];
         */
    }
    
    if ([touchedNode isEqualToNode:self.button2])//CGRectContainsPoint(button2.boundingBox, touchPos))
    {
        
        if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
            [self.on2Label setText:@"OFF"];
            AUDIO.effectsVolume = 0;
            [Combinations saveNSDEFAULTS_Bool:NO forKey:sound_fx];
        }
        else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
            [self.on2Label setText:@"ON"];
            AUDIO.effectsVolume = 1.f;
            [Combinations saveNSDEFAULTS_Bool:YES forKey:sound_fx];
        }
        
        /*
         if (B2on == false)
         {
         B2on = true;
         NSLog(@"..SOUND FX OFF..");
         [AUDIO setEffectsVolume:1];
         [self setOnOffLabelsOpacity];
         }
         else
         {
         B2on = false;
         NSLog(@"..SOUND FX ON..");
         [AUDIO setEffectsVolume:0];
         [self setOnOffLabelsOpacity];
         }
         b2 = false;
         [button2 setTexture:Btn_notActive2];
         [AUDIO playEffect:s_click1];
         //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
         */
    }
    
    if ([touchedNode isEqualToNode:self.autoSpinButton])//CGRectContainsPoint(autoSpinButton.boundingBox, touchPos))
    {
        b3 = false;
        [AUDIO playEffect:s_click1];
        //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    if ([touchedNode isEqualToNode:self.show_LeaderBoardButton])
    {
        b4 = false;
        [self.show_LeaderBoardButton setTexture:self.Btn_notActive];
        //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        [AUDIO playEffect:s_click1];
        [self show_leader_board];
    }
    if ([touchedNode isEqualToNode:self.show_AchievementsButton])
    {
        b5 = false;
        [self.show_AchievementsButton setTexture:self.Btn_notActive];
        // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        [AUDIO playEffect:s_click1];
    }
    if ([touchedNode isEqualToNode:self.show_AboutButton])
    {
        b6 = false;
        [self.show_AboutButton setTexture:self.Btn_notActive];
        [AUDIO playEffect:s_click1];
        //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        
        if (onAbout == false)
        {
            onAbout = true;
            [self showAboutWindow];
        }
        else
        {
            onAbout = false;
            [self showNormalWindow];
        }
    }
    
    if (b1) { [self.button1 setTexture:self.Btn_notActive2]; }
    if (b2) { [self.button2 setTexture:self.Btn_notActive2]; }
    if (b3) { [self.autoSpinButton setTexture:self.Btn_notActive]; }
    if (b4) { [self.show_LeaderBoardButton setTexture:self.Btn_notActive]; }
    if (b5) { [self.show_AchievementsButton setTexture:self.Btn_notActive]; }
    if (b6) { [self.show_AboutButton setTexture:self.Btn_notActive]; }
    if (b7) { [self.closeBtn setTexture:self.closeBtn_notActive]; }
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (b1) { [self.button1 setTexture:self.Btn_notActive2]; }
    if (b2) { [self.button2 setTexture:self.Btn_notActive2]; }
    if (b3) { [self.autoSpinButton setTexture:self.Btn_notActive]; }
    if (b4) { [self.show_LeaderBoardButton setTexture:self.Btn_notActive]; }
    if (b5) { [self.show_AchievementsButton setTexture:self.Btn_notActive]; }
    if (b6) { [self.show_AboutButton setTexture:self.Btn_notActive]; }
    if (b7) { [self.closeBtn setTexture:self.closeBtn_notActive]; }
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
-(void) show_leader_board
{
    [GC_ showLeaderboard:GC_LEADERBOARD];
}


-(void)closeSettingsWindow2
{
    // [AUDIO playEffect:s_click1];
    //[[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
#warning EF check this parent reference
    PopupManager* popupManager = (PopupManager*)self.parent;
    if(popupManager)
    {
        [popupManager removeBlackBG];
    }
    
#warning EF check this animtions
    SKAction* scale3       = [SKAction scaleTo:0.5 duration:0.1];
    scale3.timingMode = SKActionTimingEaseInEaseOut;
//    SKAction* easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    [self runAction:scale3 completion:^{
#warning EF check this self.parent check
        if ([self.parent isKindOfClass:[PopupManager class]])
        {
            [self.parent performSelector:@selector(closeSettingsWindow) withObject:nil];
        }
    }];
}


-(void)showAboutWindow
{
    if (state__ == 1) {
        self.show_LeaderBoardButton.position   = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        self.autoSpinButton.position           = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        self.button1.position                  = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        self.button2.position                  = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        self.show_AboutButton.position         = ccp(self.background.position.x, self.background.position.y - self.background.size.height*0.4f);
    }
    else if (state__ == 2)
    {
        self.show_LeaderBoardButton.position   = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        self.button1.position                  = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        self.button2.position                  = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        self.show_AboutButton.position         = ccp(self.background.position.x, self.background.position.y - self.background.size.height*0.4f);
    }
    
    
    [self.aboutButtonLabel setText:@"BACK"];
    self.aboutButtonLabel.position = ccp(self.self.show_AboutButton.position.x, self.show_AboutButton.position.y);
    
    self.developedByLabel.alpha = 1.0;
    self.b6luxLabel.alpha      = 1.0;
    self.codeLabel.alpha       = 1.0;
    self.artLabel.alpha        = 1.0;
    self.toolsLabel.alpha      = 1.0;
    self.cocos2dLabel.alpha    = 1.0;
    self.eLabel.alpha          = 1.0;
    self.mLabel.alpha          = 1.0;
    self.sLabel.alpha          = 1.0;
    self.jLabel.alpha          = 1.0;
    
    self.onLabel.alpha         = 0;
    self.on2Label.alpha        = 0;
    self.offLabel.alpha        = 0;
    self.off2Label.alpha       = 0;
    self.soundLabel.alpha      = 0;
    self.musicLabel.alpha      = 0;
    self.menuLabel.alpha       = 0;
    self.showLBlabel.alpha     = 0;
    self.showAClabel.alpha     = 0;
    self.autoSpinLabel.alpha   = 0;
}

-(void)showNormalWindow
{
    if (state__ == 1) {
        self.autoSpinButton.position     = ccp(kWidthScreen/2, self.background.position.y);
        self.show_LeaderBoardButton.position     = ccp(kWidthScreen/2, self.autoSpinButton.position.y - self.autoSpinButton.size.height*1.3f);
        self.show_AboutButton.position     = ccp(kWidthScreen/2, self.show_LeaderBoardButton.position.y - self.show_LeaderBoardButton.size.height*1.3f);
    }
    else if (state__ == 2)
    {
        
        self.show_LeaderBoardButton.position     = ccp(kWidthScreen/2, self.background.position.y);
        self.show_AboutButton.position     = ccp(kWidthScreen/2, self.show_LeaderBoardButton.position.y - self.show_LeaderBoardButton.size.height*1.3f);
    }
    
    self.developedByLabel.alpha = 0.0;
    self.b6luxLabel.alpha      = 0.0;
    self.codeLabel.alpha       = 0.0;
    self.artLabel.alpha        = 0.0;
    self.toolsLabel.alpha      = 0.0;
    self.cocos2dLabel.alpha    = 0.0;
    self.eLabel.alpha          = 0.0;
    self.mLabel.alpha          = 0.0;
    self.sLabel.alpha          = 0.0;
    self.jLabel.alpha          = 0.0;
    
    [self setOnOffLabelsOpacity];
    
    self.soundLabel.alpha      = 1.0;
    self.musicLabel.alpha      = 1.0;
    self.menuLabel.alpha       = 1.0;
    self.showLBlabel.alpha     = 1.0;
    self.showAClabel.alpha     = 1.0;
    self.autoSpinLabel.alpha   = 1.0;
    
    [self.aboutButtonLabel setText:@"ABOUT"];
    self.aboutButtonLabel.position = ccp(self.show_AboutButton.position.x, self.show_AboutButton.position.y);
    
//    autoSpinButton.position             = ccp(kWidthScreen/2, show_AchievementsButton.position.y + show_AchievementsButton.size.height/2 + kHeightScreen*0.07f);
    self.button1.position     = ccp(self.background.position.x - self.button1.size.width*0.05f, self.background.position.y + self.background.size.height*0.25f);
    self.button2.position     = ccp(self.background.position.x - self.button1.size.width*0.05f, self.background.position.y + self.background.size.height*0.14f);
    
}





//
//-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
//    
//    
//    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
//    {
//        b7 = true;
//        
//        [AUDIO playEffect:s_click1];
//        [closeBtn setTexture:closeBtn_Active];
//    }
//    
//    if (CGRectContainsPoint(button1.boundingBox, touchPos))
//    {
//        b1 = true;
//        [button1 setTexture:Btn_Active2];
//    }
//    
//    if (CGRectContainsPoint(button2.boundingBox, touchPos))
//    {
//        b2 = true;
//        [button2 setTexture:Btn_Active2];
//    }
//    
//    if (CGRectContainsPoint(autoSpinButton.boundingBox, touchPos))
//    {
//        b3 = true;
//        if ([_parent.parent.parent isKindOfClass:[SlotMachine class]]) {
//            //NSLog(@"PAR::   %@",_parent.parent.parent);
//            
//            if(![(Reels *)[_parent.parent.parent getChildByTag:5] checkAutoSpin])
//            {
//                float c = [DB_ getValueBy:d_Coins table:d_DB_Table];
//                
//                if (c > 0) {
//                    [(Reels *)[_parent.parent.parent getChildByTag:5] setAutoSpin:YES];
//                    [autoSpinButton setTexture:Btn_Active];
//                    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self  selector:@selector(closeSettingsWindow2)], nil]];
//                }
//                else
//                {
//                    [(TopMenu *)[_parent.parent.parent getChildByTag:kTopMenuTAG] openBuyWindow];
//                }
//            }
//            else
//            {
//                [(Reels *)[_parent.parent.parent getChildByTag:5] setAutoSpin:NO];
//                [autoSpinButton setTexture:Btn_notActive];
//            }
//        }
//    }
//    
//    if (CGRectContainsPoint(show_LeaderBoardButton.boundingBox, touchPos))
//    {
//        b4 = true;
//        [show_LeaderBoardButton setTexture:Btn_Active];
//    }
//    if (CGRectContainsPoint(show_AchievementsButton.boundingBox, touchPos))
//    {
//        b5 = true;
//        [show_AchievementsButton setTexture:Btn_Active];
//    }
//    if (CGRectContainsPoint(show_AboutButton.boundingBox, touchPos))
//    {
//        b6 = true;
//        [show_AboutButton setTexture:Btn_Active];
//    }
//    
//    
//    return YES;
//}

//
//
//-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
//
//
//    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
//    {
//        b7 = true;
//        [closeBtn setTexture:closeBtn_notActive];
//        [self closeSettingsWindow2];
//    }
//
//    if (CGRectContainsPoint(button1.boundingBox, touchPos))
//    {
//        //music
//
//        if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
//            [onLabel setText:@"OFF"];
//            AUDIO.backgroundMusicVolume = 0;
//            [Combinations saveNSDEFAULTS_Bool:NO forKey:sound_music];
//        }
//        else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
//            [onLabel setText:@"ON"];
//            if ( [(AppDelegate *)[[UIApplication sharedApplication] delegate]inMenu]) {
//                 AUDIO.backgroundMusicVolume = 0.5f;
//            }
//            else AUDIO.backgroundMusicVolume = 0.35f;
//           [Combinations saveNSDEFAULTS_Bool:YES forKey:sound_music];
//        }
//
//        /*
//        if (B1on == false)
//        {
//            B1on = true;
//            NSLog(@"..MUSIC OFF..");
//            [AUDIO setBackgroundMusicVolume:1];
//            [self setOnOffLabelsOpacity];
//        }
//        else
//        {
//            B1on = false;
//            NSLog(@"..MUSIC ON..");
//            [AUDIO setBackgroundMusicVolume:0.f];
//            [self setOnOffLabelsOpacity];
//        }
//        b1 = false;
//        [button1 setTexture:Btn_notActive2];
//         [AUDIO playEffect:s_click1];
//         */
//    }
//
//    if (CGRectContainsPoint(button2.boundingBox, touchPos))
//    {
//
//        if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
//            [on2Label setText:@"OFF"];
//            AUDIO.effectsVolume = 0;
//            [Combinations saveNSDEFAULTS_Bool:NO forKey:sound_fx];
//        }
//        else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
//            [on2Label setText:@"ON"];
//            AUDIO.effectsVolume = 1.f;
//            [Combinations saveNSDEFAULTS_Bool:YES forKey:sound_fx];
//        }
//
//        /*
//        if (B2on == false)
//        {
//            B2on = true;
//            NSLog(@"..SOUND FX OFF..");
//            [AUDIO setEffectsVolume:1];
//            [self setOnOffLabelsOpacity];
//        }
//        else
//        {
//            B2on = false;
//            NSLog(@"..SOUND FX ON..");
//            [AUDIO setEffectsVolume:0];
//            [self setOnOffLabelsOpacity];
//        }
//        b2 = false;
//        [button2 setTexture:Btn_notActive2];
//         [AUDIO playEffect:s_click1];
//      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//         */
//    }
//
//    if (CGRectContainsPoint(autoSpinButton.boundingBox, touchPos))
//    {
//        b3 = false;
//        [AUDIO playEffect:s_click1];
//     //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//    }
//
//    if (CGRectContainsPoint(show_LeaderBoardButton.boundingBox, touchPos))
//    {
//        b4 = false;
//        [show_LeaderBoardButton setTexture:Btn_notActive];
//     //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//         [AUDIO playEffect:s_click1];
//        [self show_leader_board];
//    }
//    if (CGRectContainsPoint(show_AchievementsButton.boundingBox, touchPos))
//    {
//        b5 = false;
//        [show_AchievementsButton setTexture:Btn_notActive];
//       // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//         [AUDIO playEffect:s_click1];
//    }
//    if (CGRectContainsPoint(show_AboutButton.boundingBox, touchPos))
//    {
//        b6 = false;
//        [show_AboutButton setTexture:Btn_notActive];
//         [AUDIO playEffect:s_click1];
//      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//
//        if (onAbout == false)
//        {
//            onAbout = true;
//            [self showAboutWindow];
//        }
//        else
//        {
//            onAbout = false;
//            [self showNormalWindow];
//        }
//    }
//
//    if (b1) { [button1 setTexture:Btn_notActive2]; }
//    if (b2) { [button2 setTexture:Btn_notActive2]; }
//    if (b3) { [autoSpinButton setTexture:Btn_notActive]; }
//    if (b4) { [show_LeaderBoardButton setTexture:Btn_notActive]; }
//    if (b5) { [show_AchievementsButton setTexture:Btn_notActive]; }
//    if (b6) { [show_AboutButton setTexture:Btn_notActive]; }
//    if (b7) { [closeBtn setTexture:closeBtn_notActive]; }
//}


@end

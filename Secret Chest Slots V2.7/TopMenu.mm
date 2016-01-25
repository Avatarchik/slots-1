#import "TopMenu.h"
#import "cfg.h"
#import "Constants.h"
#import "Menu.h"
#import "SCombinations.h"
#import "Lobby.h"

#import "SimpleAudioEngine.h"
#import "Exp.h"
#import "WheelGame.h"
#import "CardGame.h"
#import "SlotMachine.h"
#import "WinsWindow.h"
#import "coinsFA.h"
#import "b6luxLoadingView.h"
#import "SKNode+SKNode_Extensions.h"
#import "FSSpriteKitProgressBar.h"



@interface TopMenu()

@property (nonatomic, strong) SKNode* TOP_MENU_;
@property (nonatomic, strong) SKTexture *settingsBtn_Active;
@property (nonatomic, strong) SKTexture *paytableBtn_Active;
@property (nonatomic, strong) SKTexture *lobbyBtn_Active;
@property (nonatomic, strong) SKTexture *buyBtn_Active;
@property (nonatomic, strong) SKTexture *settingsBtn_notActive;
@property (nonatomic, strong) SKTexture *paytableBtn_notActive;
@property (nonatomic, strong) SKTexture *lobbyBtn_notActive;
@property (nonatomic, strong) SKTexture *buyBtn_notActive;

@property (nonatomic, strong) SKSpriteNode *menu_line;
@property (nonatomic, strong) SKSpriteNode *coins_button;
@property (nonatomic, strong) SKSpriteNode *setings_button;
@property (nonatomic, strong) SKSpriteNode *coinsBg;
@property (nonatomic, strong) SKSpriteNode *expStar;
@property (nonatomic, strong) SKSpriteNode *expBg;
@property (nonatomic, strong) SKSpriteNode *winBg;
@property (nonatomic, strong) SKSpriteNode *lobby_button;
@property (nonatomic, strong) SKSpriteNode *ptable_button;

@property (nonatomic, strong) SKLabelNode *levelLabel;
@property (nonatomic, strong) SKLabelNode *expLabel;
@property (nonatomic, strong) SKLabelNode *coinsLabel;
@property (nonatomic, strong) SKLabelNode *winLabel;

@property (nonatomic, strong) FSSpriteKitProgressBar* progress;

@end

@implementation TopMenu

-(id)initWithRect:(CGRect)rect type:(int)TYPE experience:(int)EXP coins:(float)COINS
{
    if((self = [super init]))
    {
        self.userInteractionEnabled = YES;
        self.name = kNodeTopMenu;
        self.position       = rect.origin;
        self.size           = rect.size;
        
        int lvl = [Exp returnLevelByEXP:EXP];
        level_ = lvl;
        exp_   = EXP;
        coins_ = COINS;
        menuType = TYPE;
        
        counter = 0;

        // Create TopMenu parent node.
        self.TOP_MENU_ = [SKNode node];
        [self addChildToTopZ:self.TOP_MENU_];
        
#warning EF research best practices  and dealloc for this
        // Create button textures and cache.
        self.settingsBtn_Active          = [SKTexture textureWithImageNamed:@"btn_settings_active.png"];
        self.paytableBtn_Active          = [SKTexture textureWithImageNamed:@"btn_paytable_active.png"];
        self.lobbyBtn_Active             = [SKTexture textureWithImageNamed:@"btn_lobby_active.png"];
        self.buyBtn_Active               = [SKTexture textureWithImageNamed:@"btn_menubuy_active.png"];
        self.settingsBtn_notActive       = [SKTexture textureWithImageNamed:@"btn_settings.png"];
        self.paytableBtn_notActive       = [SKTexture textureWithImageNamed:@"btn_paytable.png"];
        self.lobbyBtn_notActive          = [SKTexture textureWithImageNamed:@"btn_lobby.png"];
        self.buyBtn_notActive            = [SKTexture textureWithImageNamed:@"btn_menubuy.png"];
        
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        
        if (IS_IPAD)    { fSize = 16; lHeight = 3.5f; }
        else            { fSize = 10; lHeight = 5.0f; }
        
        
//#warning  EF debug only
//        TYPE = 1;
        
        
        if (TYPE == 1)
        {
            gamePlay = true;
            [self addMenuLine];
            [self addButtons];
            [self addScoreLabel];
            [self addWinLabel];
            [self addLevelLabel];
            [self addExpLabel];
        }
        else if (TYPE == 2)
        {
            gamePlay = false;
            [self addMenuLine];
            [self addButtons];
            [self addScoreLabel];
            [self addLevelLabel];
            [self addExpLabel];
        }
        
        [self addExpValue:exp_ scale:NO];
        [self addCoins:coins_];
        [self changeButtons_boundingBoxes];

        openSett = false;
        openPay  = false;
        progress_value = 0;
        sizee          = 0;
        
        int expPercents = [Exp returnExpPercentage:EXP];
        [self progressNumber:expPercents scale:NO];
        [self activeButtons:YES];
 
    }
    
    return self;
}

-(void)addMenuLine
{
    self.menu_line = [SKSpriteNode spriteNodeWithImageNamed:@"top_bar.png"];
    self.menu_line.anchorPoint = ccp(0.5f, 0.5f);
    self.menu_line.position = ccp(kWidthScreen / 2, kHeightScreen - self.menu_line.size.height/2);
    [self.TOP_MENU_ addChildToTopZ:self.menu_line];
}


-(void)addButtons
{
    // Create Settings Button.
    self.setings_button              = [SKSpriteNode spriteNodeWithTexture:self.settingsBtn_notActive];
    self.setings_button.anchorPoint  = ccp(0.5f, 0.5f);
    self.setings_button.position     = ccp(self.menu_line.position.x + (self.menu_line.size.width/2) - self.setings_button.size.width/1.2, self.menu_line.position.y);
    [self.TOP_MENU_ addChildToTopZ:self.setings_button];
    
    // Create Experience BG.
    self.expBg                       = [SKSpriteNode spriteNodeWithImageNamed:@"exp_field.png"];
    self.expBg.anchorPoint           = ccp(0.5f, 0.5f);
    self.expBg.position              = ccp(self.menu_line.position.x - (self.menu_line.size.width/2) + self.expBg.size.width/1.5f, self.menu_line.position.y);
    [self.TOP_MENU_ addChildToTopZ:self.expBg];
    
    // Create Experience Star.
    self.expStar                     = [SKSpriteNode spriteNodeWithImageNamed:@"exp_field_star.png"];
    self.expStar.anchorPoint         = ccp(0.5f, 0.5f);
    self.expStar.position            = ccp(self.expBg.position.x - (self.expBg.size.width/2), self.expBg.position.y);

    // Progress Bar.
    SKSpriteNode* progressSp                  = [SKSpriteNode spriteNodeWithImageNamed:@"exp_field_fill.png"];
    self.progress                   = [[FSSpriteKitProgressBar alloc] initWithSpriteNode:progressSp];
    self.progress.position        = ccp(self.expBg.position.x, self.expBg.position.y);
    [self.TOP_MENU_ addChildToTopZ:_progress];

    [self.TOP_MENU_ addChildToTopZ:self.expStar];
    
    
    // --------------------------------------------------------------------------------------------------------------------------
    
    
    // COINS
    // Create Coins count
    self.coinsBg                     = [SKSpriteNode spriteNodeWithImageNamed:@"coins_field.png"];
    self.coinsBg.anchorPoint         = ccp(0.5f, 0.5f);
    if (gamePlay)
    {
        self.coinsBg.position          = ccp(self.expBg.position.x + (self.expBg.size.width/2) + self.coinsBg.size.width/1.9f, self.menu_line.position.y);
    }
    else
    {
        self.coinsBg.position         = ccp(self.menu_line.position.x, self.menu_line.position.y);
    }
    [self.TOP_MENU_ addChildToTopZ:self.coinsBg];
    
    // Create buy coins button.
    self.coins_button                = [SKSpriteNode spriteNodeWithTexture:self.buyBtn_notActive];
    self.coins_button.anchorPoint    = ccp(0.5f, 0.5f);
    self.coins_button.position       = ccp(self.coinsBg.position.x + (self.coinsBg.size.width/2.035f) - (self.coins_button.size.width/2), self.coinsBg.position.y - (self.coinsBg.size.height*0.015f));
    [self.TOP_MENU_ addChildToTopZ:self.coins_button];
    

    // Win Label, Lobby Button and Paytable Button.
    if (gamePlay)
    {
        // Create last Win label and field;
        self.winBg                     = [SKSpriteNode spriteNodeWithImageNamed:@"exp_field.png"];
        self.winBg.anchorPoint         = ccp(0.5f, 0.5f);
        self.winBg.position        = ccp(self.coinsBg.position.x + (self.coinsBg.size.width/2) + self.winBg.size.width/1.8f, self.menu_line.position.y);
        [self.TOP_MENU_ addChildToTopZ:self.winBg];
        
        // Create Lobby Button.
        self.lobby_button              = [SKSpriteNode spriteNodeWithTexture:self.lobbyBtn_notActive];
        self.lobby_button.anchorPoint  = ccp(0.5f, 0.5f);
        self.lobby_button.position = ccp(self.winBg.position.x + (self.winBg.size.width/2) + self.lobby_button.size.width/1.8f, self.menu_line.position.y);
        [self.TOP_MENU_ addChildToTopZ:self.lobby_button];
        
        // Create Paytable Button.
        self.ptable_button             = [SKSpriteNode spriteNodeWithTexture:self.paytableBtn_notActive];
        self.ptable_button.anchorPoint = ccp(0.5f, 0.5f);
        self.ptable_button.position = ccp(self.lobby_button.position.x + (self.lobby_button.size.width/2) + self.ptable_button.size.width, self.menu_line.position.y);
        [self.TOP_MENU_ addChildToTopZ:self.ptable_button];
    }
    else
    {
        // Move buttons off screen so the hit detection isnt triggered
        self.ptable_button.position = ccp(kWidthScreen, kHeightScreen);
        self.lobby_button.position = ccp(kWidthScreen, kHeightScreen);
    }

}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addLevelLabel
{
    self.levelLabel = [SKLabelNode labelNodeWithFontNamed:IS_IPAD ? ([Combinations isRetina]) ? kFONT_BIG : kFONT_MEDIUM  : kFONT_MEDIUM];
    self.levelLabel.scale = 0.75f;
    if (iPhone3) { self.levelLabel.scale = 0.35f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        self.levelLabel.scale = 1.0;
    }
    self.levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.levelLabel.position = ccp(-self.expStar.size.width/2.1f ,-self.expStar.size.height/2);
    self.levelLabel.fontColor  = [SKColor colorWithRed:69/255.0 green:42/255.0 blue:4/255.0 alpha:1.0];
    [self.expStar addChildToTopZ:self.levelLabel];

}

-(void)addLevelNr:(int)levelValue
{
    if (level_ < levelValue)
    {
    #warning EF do this
//        [(SlotMachine *)_parent levelUp:levelValue levelup:NO];
        [self.expStar runAction:[SKAction rotateToAngle:360 duration:1.5]];
    }
    level_ = levelValue;
    self.levelLabel.text = [NSString stringWithFormat:@"%d", level_];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addExpLabel
{
    self.expLabel = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    self.expLabel.position = ccp(self.expBg.position.x, self.expBg.position.y);
    self.expLabel.fontColor = [SKColor lightTextColor];
    if (iPhone3) { self.expLabel.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD||IS_IPAD) {
        self.expLabel.scale = 1.6;
    }
    
    [self.TOP_MENU_ addChildToTopZ:self.expLabel];
}



-(void)scaleAction:(SKNode *)node_
{
    SKAction* buttonAnimation3 = [SKAction scaleTo:node_.xScale + 0.1f duration:0.05];
    SKAction* buttonAnimation4 = [SKAction scaleTo:node_.xScale duration:0.1];
    SKAction* runAnimation2 = [SKAction sequence:@[buttonAnimation3, buttonAnimation4]];
    [node_ runAction:runAnimation2];
}
-(void)addExpValue:(float)expValue scale:(bool)bool_
{
    if (bool_) {
       [self scaleAction:self.expStar];
    }
    exp_ = expValue;
    
    NSString *stringFormated = [cfg formatTo3digitsValue:exp_];
    self.expLabel.text = stringFormated;
    
    int lvl = [Exp returnLevelByEXP:exp_];
    [self addLevelNr:lvl];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addWinLabel
{
    SKLabelNode *winL = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    winL.text = @"Win:";
    winL.position     = CGPointMake(self.winBg.position.x - self.winBg.size.width/4, self.winBg.position.y );
    winL.fontColor    = [SKColor lightTextColor];
    if (iPhone3) { winL.scale = 0.65f;  winL.position = ccp((self.winBg.position.x - self.winBg.size.width*0.60f), self.menu_line.position.y);}
    if (IS_STANDARD_IPHONE_6_PLUS) {
        winL.position = ccp((self.winBg.position.x - self.winBg.size.width*0.45 ), self.menu_line.position.y);
        winL.scale = 1.3;
    }
    if (IS_IPAD) {
        winL.scale = 1.3;
    }

    
    self.winLabel = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    self.winLabel.text = @"0";
    self.winLabel.position = CGPointMake(self.winBg.position.x, self.winBg.position.y );
    self.winLabel.fontColor = [SKColor colorWithRed:233/255.0 green:192/255.0 blue:0 alpha:1.0];
    if (iPhone3) { self.winLabel.scale = 0.65f;
    self.winLabel.position = ccp(self.winBg.position.x - self.winBg.size.width*0.1f, self.menu_line.position.y);}
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        self.winLabel.scale = 1.3;
    }
    
    [self.TOP_MENU_ addChildToTopZ:winL];
    [self.TOP_MENU_ addChildToTopZ:self.winLabel];
    
}

-(void)addLastWin:(float)winValue
{
    win_ = winValue;
    
    NSString *numberString;
    
    if (win_ < 10  && win_ >= 0.1) {
        numberString = [NSString stringWithFormat:@"%.1f0", win_];
        self.winLabel.text = numberString;
    }
    else
    {
        NSString *stringFormated = [cfg formatTo3digitsValue:win_];
        self.winLabel.text = stringFormated;
    }
    
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addScoreLabel
{
//    Create and add the score label as a child
    self.coinsLabel = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    self.coinsLabel.position     = ccp(self.coinsBg.position.x - self.coins_button.size.width/3, self.menu_line.position.y);
    self.coinsLabel.fontColor = [SKColor colorWithRed:233/255.0 green:192/255.0 blue:0.0 alpha:1.0];
    if (iPhone3) { self.coinsLabel.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        self.coinsLabel.scale = 1.6;
    }
    [self.TOP_MENU_ addChildToTopZ:self.coinsLabel];
}

-(void)activeButtons:(bool)bool_
{
    buttonActive = bool_;
    
    if (bool_) {
        #warning EF
        SKAction* tintIn =[SKAction colorizeWithColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] colorBlendFactor:1.0 duration:0.1];
//        id tintIn = [CCTintTo actionWithDuration:0.1f red:255 green:255 blue:255];
        
        [self.lobby_button       runAction:tintIn];
        [self.setings_button     runAction:tintIn];
        [self.ptable_button      runAction:tintIn];
    }
    else
    {
//        id tintOut = [CCTintTo actionWithDuration:0.1f red:130 green:130 blue:130];
        #warning EF
        SKAction* tintOut =[SKAction colorizeWithColor:[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0] colorBlendFactor:1.0 duration:0.1];

        [self.lobby_button       runAction:tintOut];
        [self.setings_button     runAction:[tintOut copy]];
        [self.ptable_button      runAction:[tintOut copy]];
    }

}


-(void)txtAnimation:(ccTime)dt
{
    //TODO: hook up coin flying animation
#warning EF hook up coin flying animation
    
//    int i = [(coinsFA *)[_parent getChildByTag:675] getPowerByCoinsAmmount:coins_];
//    //coinsFA *f = (coinsFA*)[_parent getChildByTag:675];
//    int ff = 100;
//    if (coins_ < 100) {
//        ff = coins_;
//    }
//    
//    float coinsSpeed = 3;
//    
//    if (coins_ > 1000 && coins_ < 50) {
//        coinsSpeed = 2;
//    }
//    else if (coinsSpeed > 100000) {
//        coinsSpeed = 1;
//    }
//    soundloop++;
//   
//    if ([cfg isNumber:soundloop devidableBy:coinsSpeed]) {
//         [AUDIO playEffect:s_coinHit];
//    }
//    
//   // [AUDIO playEffect:s_coinHit];
//    //[SOUND_ playSound:s_coinHit looping:NO];
//    
//    counter+=(coins_ *0.03f)/((((ff/60)) + ((coins_ < 100) ? 0.1f : 0.7f)));
//    
//    NSString *numberString;
//  
//    if (final_coins < 10) {
//        numberString = [NSString stringWithFormat:@"%.1f0", (final_coins - coins_) + counter];
//        [coinsLabel setString:numberString];
//    }
//    else
//    {
//        numberString = [NSString stringWithFormat:@"%.0f", (final_coins - coins_) + counter];
//        
//        NSString *stringFormated = [cfg formatTo3digitsValue:numberString.floatValue];
//        [coinsLabel setString:stringFormated];
//    }
//  //  l.scale = 1.1;
//   
//    if (((final_coins - coins_) + counter) >= final_coins) {
//        
//        if (final_coins < 10) {
//            numberString = [NSString stringWithFormat:@"%.1f0", final_coins];
//            [coinsLabel setString:numberString];
//        }
//        else
//        {
//           // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
//             NSString *stringFormated = [cfg formatTo3digitsValue:final_coins];
//            [coinsLabel setString:stringFormated];
//        }
//        
//        
//        //[coinsLabel setString:[NSString stringWithFormat:@"%@", numberString]];
//        
//        counter = 0;
//        soundloop = 0;
//        
//        [self unschedule:@selector(txtAnimation:)];
//        coinDropAnim = false;
//        
//    }
    
}
-(void)loading
{
    [b6luxLoadingView loadingViewWithLoadingType:kLOADING_MACHINE];
}

-(void)minusCoins:(float)coins
{
    [DB_ updateValue:d_Coins table:d_DB_Table :coins];

    NSString *numberString;
    NSString *stringFormated = [cfg formatTo3digitsValue:coins];

    
    if (coins > 0.09 && coins < 10) {
        numberString = [NSString stringWithFormat:@"%.1f0", coins];
        self.coinsLabel.text = numberString;
    }
    else
    {
        self.coinsLabel.text = stringFormated;
    }
#warning EF
//    [self unschedule:@selector(txtAnimation:)];

}

-(void)addCoins:(float)coinsValue
{
    coins_ = coinsValue;
    
    if (coins_ <= 0.1f) {
        [DB_ updateValue:d_WinAllTime table:d_DB_Table :0];
        [DB_ updateValue:d_LoseAllTime table:d_DB_Table :0];
    }
    
    final_coins = [DB_ getValueBy:d_Coins table:d_DB_Table];
    
    [self scaleAction:self.coinsLabel];

    
    if (coins_ == final_coins) {
        
    
        NSString *numberString;
    
        if (coins_ > 0.09 && coins_ < 10) {
            numberString = [NSString stringWithFormat:@"%.1f0", coins_];
            self.coinsLabel.text = numberString;
        }
        else
        {
            NSString *stringFormated = [cfg formatTo3digitsValue:coins_];
            self.coinsLabel.text = stringFormated;
        }

        return;
    }
    
    if (coinDropAnim) {
#warning EF
//        [self unschedule:@selector(txtAnimation:)];
        NSString *numberString;
        
        if (final_coins > 0.09 && final_coins < 10) {
            numberString = [NSString stringWithFormat:@"%.1f0", final_coins];
            self.coinsLabel.text = numberString;
        }
        else
        {
            NSString *stringFormated = [cfg formatTo3digitsValue:final_coins];
            self.coinsLabel.text = stringFormated;
        }
        
        counter = 0;
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.7f],[CCCallBlock actionWithBlock:^{
            coinDropAnim = true;
#warning EF
//            [self schedule:@selector(txtAnimation:) interval:0.03f];
        }], nil]];
        
        return;
    }
    
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.7f],[CCCallBlock actionWithBlock:^{
        coinDropAnim = true;
#warning EF
//         [self schedule:@selector(txtAnimation:) interval:0.03f];
    }], nil]];
   
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)progressNumber:(float)progress_number scale:(bool)bool_
{
    if (bool_) {
        [self scaleAction:self.progress];
        [self scaleAction:self.expLabel];
    }
    [self.progress setProgress: progress_number];
}

//////////////////////////////////////////////////////////////////////////////////////////// < -------------------------------------------------------------- >

/////////////////////////////////////////////////////////////////////
-(void) changeButtons_boundingBoxes
{
    buyButton_Rect               = self.coins_button.frame;
    buyButton_Rect.origin.x      = buyButton_Rect.origin.x - buyButton_Rect.size.width/2;
    buyButton_Rect.origin.y      = buyButton_Rect.origin.y - buyButton_Rect.size.height/2;
    buyButton_Rect.size.width    = buyButton_Rect.size.width  * 2.0f;
    buyButton_Rect.size.height   = buyButton_Rect.size.height * 2.0f;
    
    settingsButton_Rect               = self.setings_button.frame;
    settingsButton_Rect.origin.x      = settingsButton_Rect.origin.x - settingsButton_Rect.size.width/2;
    settingsButton_Rect.origin.y      = settingsButton_Rect.origin.y - settingsButton_Rect.size.height/2;
    settingsButton_Rect.size.width    = settingsButton_Rect.size.width  * 2.0f;
    settingsButton_Rect.size.height   = settingsButton_Rect.size.height * 2.0f;
    
    paytableButton_Rect               = self.ptable_button.frame;
    paytableButton_Rect.origin.x      = paytableButton_Rect.origin.x - paytableButton_Rect.size.width/2;
    paytableButton_Rect.origin.y      = paytableButton_Rect.origin.y - paytableButton_Rect.size.height/2;
    paytableButton_Rect.size.width    = paytableButton_Rect.size.width  * 1.5f;
    paytableButton_Rect.size.height   = paytableButton_Rect.size.height * 1.5f;
    
    
}
/////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////// < -------------------------------------------------------------- >


- (CGPoint)convertTouchToNodeSpace:(UITouch *)touch
{
    CGPoint point = [touch locationInView: [touch view]];
    return point;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint touchPos = [self convertTouchToNodeSpace:touches.anyObject];
    
    
    CGRect r = self.lobby_button.frame;
    r.origin.y = r.origin.y - r.size.height*2;
    r.size.height = r.size.height*5;
    
    SKNode* touchedNode = [self nodeFromTouches:touches inParentNode:self];
    
    if([touchedNode isEqualToNode:self.setings_button])
    {
        [self.setings_button setTexture:self.settingsBtn_Active];
        openSett = true;
        [self openSettingsWindow];
        [AUDIO playEffect:s_click1];
    }
    else if([touchedNode isEqualToNode:self.coins_button])
    {
        [self.coins_button setTexture:self.buyBtn_Active];
        openSett = true;
        [self openBuyWindow_withNR:@(1)];
        [AUDIO playEffect:s_click1];
    }
    else if ([touchedNode isEqualToNode:self.lobby_button] && buttonActive)
    {
        [self.lobby_button setTexture:self.lobbyBtn_Active];
        
        [self loading];
        sizee = 0;
        
        [AUDIO playEffect:s_click1];
        
        #warning EF
        //[[CCDirector sharedDirector] replaceScene:[Lobby scene]];//node]];
        
        return;
    }
    else if ([touchedNode isEqualToNode:self.ptable_button] && buttonActive)
    {
        [self.ptable_button setTexture:self.paytableBtn_Active];
        if (openPay == false && gamePlay == true)
        {
            openPay = true;
            [self openPayTableWindow];
            [AUDIO playEffect:s_click1];
        }
    }
}


-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setButtonsToUpState];
}

-(void) setButtonsToUpState{
    [self.setings_button setTexture:self.settingsBtn_notActive];
    [self.ptable_button setTexture:self.paytableBtn_notActive];
    [self.lobby_button setTexture:self.lobbyBtn_notActive];
    [self.coins_button setTexture:self.buyBtn_notActive];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    openSett = false;
    openPay  = false;
    [self setButtonsToUpState];
}

-(void) openSettingsWindow
{
    PopupManager *SWindow = [[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)];
    SWindow.anchorPoint = ccp(0, 0);
    [self addChildToTopZ:SWindow];
//    [self addChildToTopZ:SWindow z:15 tag:kSetWindowTAG];
    [SWindow setUp:kWindowSettings someValue:0];
}

-(void) openPayTableWindow
{
#warning EF
//    PopupManager *PWindow = [[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] ;
//    PWindow.anchorPoint = ccp(0, 0);
//    [self addChildToTopZ:PWindow z:15 tag:kPayWindowTAG];
//    [PWindow setUp:kWindowPayTable someValue:0];
    
    
////////////////////// WHEEL GAME ////////////////////////////////
//    WheelGame *WGame = [[[WheelGame alloc] init] autorelease];
//    WGame.anchorPoint = ccp(0, 0);
//    [self addChildToTopZ:WGame z:12 tag:kWheelGameTAG];
  
    
    
////////////////////// CARD GAME /////////////////////////////////
//    if ([self getChildByTag:kCardGameTAG] != nil) {
//        return;
//    }
//    CardGame *WGame = [[[CardGame alloc] init] autorelease];
//    WGame.anchorPoint = ccp(0, 0);
//    [self addChildToTopZ:WGame z:12 tag:kCardGameTAG];
    
    
    
///////////////////// WIN WINDOW /////////////////////////////////
//    PopupManager *PWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
//    PWindow.anchorPoint = ccp(0, 0);
//    [self addChildToTopZ:PWindow z:10 tag:kWinWindowTAG];
//    [PWindow setUp:kWindowWin someValue:2700];
    
    
    
///////////////////// NEW LEVEL WINDOW ///////////////////////////  
//    PopupManager *PWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
//    PWindow.anchorPoint = ccp(0, 0);
//    //PWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
//    [self addChildToTopZ:PWindow z:10 tag:kNewWindowTAG];
//    [PWindow setUp:kWindowWin someValue:2002];
    
}

-(void) openBuyWindow_withNR:(NSNumber *)nr_
{
#warning EF
//    switch (nr_.intValue)
//    {
//        case 1: BWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
//            BWindow.anchorPoint = ccp(0, 0);
//            if (![self getChildByTag:kBuyWindowTAG]) {
//                [self addChildToTopZ:BWindow z:15 tag:kBuyWindowTAG];
//                [BWindow setUp:kWindowBuyCoins someValue:0];
//            }
//        
//        break;
//        case 2: BWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
//            BWindow.anchorPoint = ccp(0, 0);
//            if (![self getChildByTag:kBuyWindowTAG]) {
//                [self addChildToTopZ:BWindow z:15 tag:kBuyWindowTAG];
//                [BWindow setUp:kWindowBuyBoosts someValue:0];
//            }
//            break;
//        default: break;
//    }
}

-(void) closeWindowSet
{
//    [self removeChild:[self getChildByTag:kSetWindowTAG] cleanup:YES];
}

-(void) closeWindowPay
{
//    [self removeChild:[self getChildByTag:kPayWindowTAG] cleanup:YES];
}

-(void) closeWindowBuy
{
//    [self removeChild:[self getChildByTag:kBuyWindowTAG] cleanup:YES];
}

-(void) closeWheelGame
{
//    [self removeChild:[self getChildByTag:kWheelGameTAG] cleanup:YES];
}

-(void) closeCardGame
{
//    [self removeChild:[self getChildByTag:kCardGameTAG] cleanup:YES];
}

-(void) closeWindowWin
{
//    [self removeChild:[self getChildByTag:kWinWindowTAG] cleanup:YES];
}

-(void) closeWindowLvl
{
//    [self removeChild:[self getChildByTag:kNewWindowTAG] cleanup:YES];
}




//-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//
//    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
//
//    if (touchPos.y < kHeightScreen - self.menu_line.contentSize.height) {
//        return NO;
//    }
//
//    CGRect r = self.lobby_button.boundingBox;
//
//    r.origin.y = r.origin.y - r.size.height*2;
//    r.size.height = r.size.height*5;
//
//    ////////////// changed boundingox ////////////////////
//    if ((CGRectContainsPoint(settingsButton_Rect, touchPos)) && buttonActive)
//    {
//        [self.setings_button setDisplayFrame:self.settingsBtn_Active];
//
//        openSett = true;
//        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFuncN actionWithTarget:self  selector:@selector(openSettingsWindow)], nil]];
//
//      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//    }
//
//    ////////////// changed boundingox ////////////////////
//    else if (CGRectContainsPoint(buyButton_Rect,   touchPos))
//    {
//        [self.coins_button setDisplayFrame:self.buyBtn_Active];
//
//        openSett = true;
//        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFuncO actionWithTarget:self selector:@selector(openBuyWindow_withNR:) object:[NSNumber numberWithInt:1]], nil]];
//     [AUDIO playEffect:s_click1];
//       /// [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//    }
//
//    else if ((CGRectContainsPoint(r, touchPos)) && buttonActive)
//    {
//        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.f],[CCCallFunc actionWithTarget:self selector:@selector(loading)], nil]];
//
//        [self.lobby_button setDisplayFrame:self.lobbyBtn_Active];
//
//        sizee = 0;
//
//        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallBlock actionWithBlock:^{
//            if ([_parent isKindOfClass:[Menu class]])
//            {
//            [_parent performSelector:@selector(closeTopMenu) withObject:nil];
//            }
//             [AUDIO playEffect:s_click1];
//           // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//#warning EF
////            [[CCDirector sharedDirector] replaceScene:[Lobby scene]];//node]];
//
//            }], nil]];
//
//        return NO;
//    }
//
//    ////////////// changed boundingox ////////////////////
//    else if ((CGRectContainsPoint(paytableButton_Rect, touchPos)) && buttonActive)
//    {
//         [self.ptable_button setDisplayFrame:self.paytableBtn_Active];
//
//        if (openPay == false && gamePlay == true)
//        {
//            openPay = true;
//            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFuncN actionWithTarget:self  selector:@selector(openPayTableWindow)], nil]];
//             [AUDIO playEffect:s_click1];
//           // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//        }
//    }
//
//
//
//    return YES;
//}


//-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    [self.setings_button setDisplayFrame:self.settingsBtn_notActive];
//    [self.ptable_button setDisplayFrame:self.paytableBtn_notActive];
//    [self.lobby_button setDisplayFrame:self.lobbyBtn_notActive];
//    [self.coins_button setDisplayFrame:self.buyBtn_notActive];
//}




//-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
//
//    openSett = false;
//    openPay  = false;
//
//    [self.setings_button setDisplayFrame:self.settingsBtn_notActive];
//    [self.ptable_button setDisplayFrame:self.paytableBtn_notActive];
//    [self.lobby_button setDisplayFrame:self.lobbyBtn_notActive];
//    [self.coins_button setDisplayFrame:self.buyBtn_notActive];
//
//    ////////////// changed boundingox ////////////////////
//    if ((CGRectContainsPoint(settingsButton_Rect, touchPos)) && buttonActive)
//    {
//        if (openSett == false)
//        {
////            openSett = true;
////            [self openSettingsWindow];
////            [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//        }
//
//    }
//    ////////////// changed boundingox ////////////////////
//    else if (CGRectContainsPoint(buyButton_Rect,   touchPos))
//    {
//        if (openSett == false)
//        {
////            openSett = true;
////            [self openBuyWindow];
////            [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//        }
//
//    }
//
//    else if ((CGRectContainsPoint(self.lobby_button.boundingBox, touchPos)) && buttonActive)
//    {
////        sizee = 0;
////
////        if ([_parent isKindOfClass:[Menu class]])
////        {
////            [_parent performSelector:@selector(closeTopMenu) withObject:nil];
////            [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
////        }
////
////        [[CCDirector sharedDirector] replaceScene:[Lobby node]];
//
//    }
//
//    ////////////// changed boundingox ////////////////////
//    else if ((CGRectContainsPoint(paytableButton_Rect, touchPos)) && buttonActive)
//    {
//       // sizee = sizee + 200;
//
//       // [self progressNumber:sizee nextLevel:2500];
//       // progressSp.scaleX = scaleXsize;
//
//
//
//    }
//
//}


@end

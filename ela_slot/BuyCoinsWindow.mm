#import "BuyCoinsWindow.h"
#import "PopupManager.h"
#import "BuyBoostsWindow.h"
#import "SKNode+SKNode_Extensions.h"

#define kBoostsTAG  11

@interface BuyCoinsWindow()

@property (nonatomic, strong) SKSpriteNode* background;

@property (nonatomic, strong) SKSpriteNode* closeBtn;

@property (nonatomic, strong) SKSpriteNode* coinsBtn;
@property (nonatomic, strong) SKSpriteNode* boostBtn;

@property (nonatomic, strong) SKLabelNode* coinsLabel;
@property (nonatomic, strong) SKLabelNode* boostsLabel;

@property (nonatomic, strong) SKLabelNode* buyLabel1;
@property (nonatomic, strong) SKLabelNode* buyLabel2;
@property (nonatomic, strong) SKLabelNode* buyLabel3;
@property (nonatomic, strong) SKLabelNode* buyLabel4;
@property (nonatomic, strong) SKLabelNode* buyLabel5;
@property (nonatomic, strong) SKLabelNode* buyLabel6;

@property (nonatomic, strong) SKLabelNode* lineLabel1;
@property (nonatomic, strong) SKLabelNode* lineLabel2;
@property (nonatomic, strong) SKLabelNode* lineLabel3;
@property (nonatomic, strong) SKLabelNode* lineLabel4;
@property (nonatomic, strong) SKLabelNode* lineLabel5;
@property (nonatomic, strong) SKLabelNode* lineLabel6;

@property (nonatomic, strong) SKLabelNode* priceLabel1;
@property (nonatomic, strong) SKLabelNode* priceLabel2;
@property (nonatomic, strong) SKLabelNode* priceLabel3;
@property (nonatomic, strong) SKLabelNode* priceLabel4;
@property (nonatomic, strong) SKLabelNode* priceLabel5;
@property (nonatomic, strong) SKLabelNode* priceLabel6;

@property (nonatomic, strong) SKSpriteNode* field1;
@property (nonatomic, strong) SKSpriteNode* field2;
@property (nonatomic, strong) SKSpriteNode* field3;
@property (nonatomic, strong) SKSpriteNode* field4;
@property (nonatomic, strong) SKSpriteNode* field5;
@property (nonatomic, strong) SKSpriteNode* field6;
/////////////////////////////////
@property (nonatomic, strong) SKSpriteNode* coinIco1;
@property (nonatomic, strong) SKSpriteNode* coinIco2;
@property (nonatomic, strong) SKSpriteNode* coinIco3;
@property (nonatomic, strong) SKSpriteNode* coinIco4;
@property (nonatomic, strong) SKSpriteNode* coinIco5;
@property (nonatomic, strong) SKSpriteNode* coinIco6;

@property (nonatomic, strong) SKSpriteNode* coinIco11;
@property (nonatomic, strong) SKSpriteNode* coinIco22;
@property (nonatomic, strong) SKSpriteNode* coinIco33;
@property (nonatomic, strong) SKSpriteNode* coinIco44;
@property (nonatomic, strong) SKSpriteNode* coinIco55;
@property (nonatomic, strong) SKSpriteNode* coinIco66;
/////////////////////////////////
@property (nonatomic, strong) SKSpriteNode* buyBtn1;
@property (nonatomic, strong) SKSpriteNode* buyBtn2;
@property (nonatomic, strong) SKSpriteNode* buyBtn3;
@property (nonatomic, strong) SKSpriteNode* buyBtn4;
@property (nonatomic, strong) SKSpriteNode* buyBtn5;
@property (nonatomic, strong) SKSpriteNode* buyBtn6;

@property (nonatomic, strong) SKSpriteNode* bonusPercent1;
@property (nonatomic, strong) SKSpriteNode* bonusPercent2;
@property (nonatomic, strong) SKSpriteNode* bonusPercent3;
@property (nonatomic, strong) SKSpriteNode* bonusPercent4;
@property (nonatomic, strong) SKSpriteNode* bonusPercent5;
@property (nonatomic, strong) SKSpriteNode* bonusPercent6;

@property (nonatomic, strong) SKLabelNode* bonusLabel1;
@property (nonatomic, strong) SKLabelNode* bonusLabel2;
@property (nonatomic, strong) SKLabelNode* bonusLabel3;
@property (nonatomic, strong) SKLabelNode* bonusLabel4;
@property (nonatomic, strong) SKLabelNode* bonusLabel5;
@property (nonatomic, strong) SKLabelNode* bonusLabel6;

@property (nonatomic, strong) SKLabelNode* equal1;
@property (nonatomic, strong) SKLabelNode* equal2;
@property (nonatomic, strong) SKLabelNode* equal3;
@property (nonatomic, strong) SKLabelNode* equal4;
@property (nonatomic, strong) SKLabelNode* equal5;
@property (nonatomic, strong) SKLabelNode* equal6;

@property (nonatomic, strong) SKLabelNode* finalAmountLabel1;
@property (nonatomic, strong) SKLabelNode* finalAmountLabel2;
@property (nonatomic, strong) SKLabelNode* finalAmountLabel3;
@property (nonatomic, strong) SKLabelNode* finalAmountLabel4;
@property (nonatomic, strong) SKLabelNode* finalAmountLabel5;
@property (nonatomic, strong) SKLabelNode* finalAmountLabel6;

@property (nonatomic, strong) SKTexture* fieldTexture;
@property (nonatomic, strong) SKTexture* coinTexture;
@property (nonatomic, strong) SKTexture* buyButtonTexture;
@property (nonatomic, strong) SKTexture* buyButtonActiveTexture;
@property (nonatomic, strong) SKTexture* percentBackgroundTexture;
@property (nonatomic, strong) SKTexture* framePressed;
@property (nonatomic, strong) SKTexture* boostFrame;
@property (nonatomic, strong) SKTexture* closeFrame;

@end





@implementation BuyCoinsWindow

@synthesize background = background;
@synthesize closeBtn = closeBtn;
@synthesize coinsBtn = coinsBtn;
@synthesize boostBtn = boostBtn;
@synthesize coinsLabel = coinsLabel;
@synthesize boostsLabel = boostsLabel;
@synthesize buyLabel1 = buyLabel1;
@synthesize buyLabel2 = buyLabel2;
@synthesize buyLabel3 = buyLabel3;
@synthesize buyLabel4 = buyLabel4;
@synthesize buyLabel5 = buyLabel5;
@synthesize buyLabel6 = buyLabel6;
@synthesize lineLabel1 = lineLabel1;
@synthesize lineLabel2 = lineLabel2;
@synthesize lineLabel3 = lineLabel3;
@synthesize lineLabel4 = lineLabel4;
@synthesize lineLabel5 = lineLabel5;
@synthesize lineLabel6 = lineLabel6;
@synthesize priceLabel1 = priceLabel1;
@synthesize priceLabel2 = priceLabel2;
@synthesize priceLabel3 = priceLabel3;
@synthesize priceLabel4 = priceLabel4;
@synthesize priceLabel5 = priceLabel5;
@synthesize priceLabel6 = priceLabel6;
@synthesize field1 = field1;
@synthesize field2 = field2;
@synthesize field3 = field3;
@synthesize field4 = field4;
@synthesize field5 = field5;
@synthesize field6 = field6;
@synthesize coinIco1 = coinIco1;
@synthesize coinIco2 = coinIco2;
@synthesize coinIco3 = coinIco3;
@synthesize coinIco4 = coinIco4;
@synthesize coinIco5 = coinIco5;
@synthesize coinIco6 = coinIco6;
@synthesize coinIco11 = coinIco11;
@synthesize coinIco22 = coinIco22;
@synthesize coinIco33 = coinIco33;
@synthesize coinIco44 = coinIco44;
@synthesize coinIco55 = coinIco55;
@synthesize coinIco66 = coinIco66;
@synthesize buyBtn1 = buyBtn1;
@synthesize buyBtn2 = buyBtn2;
@synthesize buyBtn3 = buyBtn3;
@synthesize buyBtn4 = buyBtn4;
@synthesize buyBtn5 = buyBtn5;
@synthesize buyBtn6 = buyBtn6;
@synthesize bonusPercent1 = bonusPercent1;
@synthesize bonusPercent2 = bonusPercent2;
@synthesize bonusPercent3 = bonusPercent3;
@synthesize bonusPercent4 = bonusPercent4;
@synthesize bonusPercent5 = bonusPercent5;
@synthesize bonusPercent6 = bonusPercent6;
@synthesize bonusLabel1 = bonusLabel1;
@synthesize bonusLabel2 = bonusLabel2;
@synthesize bonusLabel3 = bonusLabel3;
@synthesize bonusLabel4 = bonusLabel4;
@synthesize bonusLabel5 = bonusLabel5;
@synthesize bonusLabel6 = bonusLabel6;
@synthesize equal1 = equal1;
@synthesize equal2 = equal2;
@synthesize equal3 = equal3;
@synthesize equal4 = equal4;
@synthesize equal5 = equal5;
@synthesize equal6 = equal6;
@synthesize finalAmountLabel1 = finalAmountLabel1;
@synthesize finalAmountLabel2 = finalAmountLabel2;
@synthesize finalAmountLabel3 = finalAmountLabel3;
@synthesize finalAmountLabel4 = finalAmountLabel4;
@synthesize finalAmountLabel5 = finalAmountLabel5;
@synthesize finalAmountLabel6 = finalAmountLabel6;
@synthesize framePressed = framePressed;
@synthesize boostFrame = boostFrame;
@synthesize closeFrame = closeFrame;

-(id)init_WithNumber:(int) nr_
{
    if((self = [super init]))
    {
        self.userInteractionEnabled = YES;
        self.size = CGSizeMake(kWidthScreen, kHeightScreen);
        
        self.fieldTexture = [SKTexture textureWithImageNamed:@"field"];
        self.coinTexture = [SKTexture textureWithImageNamed:@"coin"];
        self.buyButtonTexture = [SKTexture textureWithImageNamed:@"btn_buy"];
        self.buyButtonActiveTexture = [SKTexture textureWithImageNamed:@"btn_buy_active"];
        closeFrame = [SKTexture textureWithImageNamed:@"menuBTN_close"];
        self.percentBackgroundTexture = [SKTexture textureWithImageNamed:@"discountBG"];
        
        //// SCALE EFFECT
#warning EF replace this with Spring animation
//        SKAction* scale1       = [SKAction scaleTo:1.2 duration:1.0];// [CCScaleTo actionWithDuration:0.1f scale:1.2f];
//        SKAction* scale2       = [CCScaleTo  cvbfactionWithDuration:0.07f scale:0.97f];
//        SKAction* scale3       = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
//        
//        [self runAction:[CCSequence actions:easeScale1,easeScale2,easeScale3, nil]];
//        
//        BUY_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_buy_menu.pvr.ccz"]];
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_buy_menu.plist"]];
//        [self addChildToTopZ:BUY_MENU_];
//        
//        SETTINGS_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_settings_menu.pvr.ccz"]];
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_settings_menu.plist"]];
//        [self addChildToTopZ:SETTINGS_MENU_];
        
        background             = [SKSpriteNode spriteNodeWithImageNamed:@"buy_BG.png"];
        background.anchorPoint = ccp(0.5f, 0.5f);
        background.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChildToTopZ:background];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        
        [self addFields];
        [self addCoinsIcons];
        [self addCoins_value_for_line1:@"350,000" for_line2:@"150,000" for_line3:@"40,000" for_line4:@"15,000" for_line5:@"4,000" for_line6:@"1,000"];
        [self addBonusPercent1:75 percent2:45 percent3:30 percent4:15 percent5:10 percent6:5];
        [self addEquallitySymbol];
        [self addCoinsIcons2];
        [self count_Final_Coins_Amount];
        
        [self addRedArrow];
        
        [self addCoinsButton];
        [self addBoostButton];
        [self addCloseButton];
        [self addBuyCoinsButtons];
        [self addCoins_prices];
        
        
        if(nr_ == 1)
        {
            self.name = kNodeBuyCoins;
        }
        else if (nr_ == 2)
        {
            self.name = kNodeBuyBoosts;
            coinsBtn.hidden = NO;
            boostBtn.hidden = NO;
            closeBtn.hidden = NO;
            [self openBoostsWindow];
        }
    }
    
    return self;
}
-(void)addRedArrow
{
    SKSpriteNode *s = [SKSpriteNode spriteNodeWithImageNamed:@"buy_arrow0.png"];
    s.anchorPoint = ccp(0.5f, 0);
    s.position = ccp(bonusPercent1.position.x, bonusPercent1.position.y + bonusPercent1.size.height/2);
    [self addChildToTopZ:s];
    
    SKSpriteNode *s2 = [SKSpriteNode spriteNodeWithImageNamed:@"buy_arrow.png"];
    s2.anchorPoint = ccp(0.5f, 0.9f);
    s2.position = ccp(s.position.x, s.position.y + s2.size.height*0.65f);
    [self addChildToTopZ:s2];
    
#warning EF redo as SKActions
//    [s2 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRepeat actionWithAction:[CCSequence actions:[CCSpawn actions:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.08f scaleX:0.9f scaleY:1.2f] rate:1.5f],[CCMoveBy actionWithDuration:0.08f position:ccp(0, -s2.size.height*0.15f)], nil],[CCSpawn actions:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.065f scaleX:1.1f scaleY:0.9f] rate:1.5f],[CCMoveBy actionWithDuration:0.065f position:ccp(0, s2.size.height*0.2f)], nil],[CCSpawn actions:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.045f scaleX:1.0f scaleY:1.f] rate:1.5f],[CCMoveBy actionWithDuration:0.045f position:ccp(0, -s2.size.height*0.05f)], nil], nil] times:2],[CCDelayTime actionWithDuration:2.f], nil]]];
}

-(void) addCoinsButton
{
    coinsBtn                   = [SKSpriteNode spriteNodeWithImageNamed:@"tab_active.png"];
    coinsBtn.anchorPoint       = ccp(0.5f, 0.5f);
    coinsBtn.position          = ccp(background.position.x - background.size.width/2 + coinsBtn.size.width*0.55f, background.position.y + background.size.height/2 + coinsBtn.size.height*0.35f);
    [self addChildToTopZ:coinsBtn];

    coinsLabel           = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    coinsLabel.text = @"COINS";
    coinsLabel.position  = ccp(coinsBtn.position.x, coinsBtn.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        coinsLabel.scale = 1.6;
    }
    [self addChildToTopZ:coinsLabel];
}

-(void) addBoostButton
{
    boostBtn                   = [SKSpriteNode spriteNodeWithImageNamed:@"tab.png"];
    boostBtn.anchorPoint       = ccp(0.5f, 0.5f);
    boostBtn.position          = ccp(coinsBtn.position.x + coinsBtn.size.width/2 + boostBtn.size.width*0.55f, background.position.y + background.size.height/2 + boostBtn.size.height*0.35f);
    [self addChildToTopZ:boostBtn];
    
    boostsLabel           = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    boostsLabel.text = @"BOOSTS";
    boostsLabel.position  = ccp(boostBtn.position.x, boostBtn.position.y);
    boostsLabel.fontColor    = SKColor3(80, 65, 45);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostsLabel.scale = 1.6;
    }
    [self addChildToTopZ:boostsLabel];
}

-(void) addCloseButton
{
    closeBtn                   = [SKSpriteNode spriteNodeWithImageNamed:@"menuBTN_close.png"];
    closeBtn.anchorPoint       = ccp(0.5f, 0.5f);
    closeBtn.position          = ccp(background.position.x + background.size.width/2, background.position.y + background.size.height/2);
    [self addChildToTopZ:closeBtn];
}

-(void) addFields
{
    field1                   = [SKSpriteNode spriteNodeWithTexture: self.fieldTexture];
    field1.anchorPoint       = ccp(0.5f, 0.5f);
    field1.position          = ccp(kWidthScreen/2, background.position.y - background.size.height/2 + field1.size.height/2 + field1.size.height*0.6f);
    [self addChildToTopZ:field1];
    
    field2                   = [SKSpriteNode spriteNodeWithTexture: self.fieldTexture];
    field2.anchorPoint       = ccp(0.5f, 0.5f);
    field2.position          = ccp(kWidthScreen/2, field1.position.y + field2.size.height*1.3f);
    [self addChildToTopZ:field2];
    
    field3                   = [SKSpriteNode spriteNodeWithTexture: self.fieldTexture];
    field3.anchorPoint       = ccp(0.5f, 0.5f);
    field3.position          = ccp(kWidthScreen/2, field2.position.y + field3.size.height*1.3f);
    [self addChildToTopZ:field3];
    
    field4                   = [SKSpriteNode spriteNodeWithTexture: self.fieldTexture];
    field4.anchorPoint       = ccp(0.5f, 0.5f);
    field4.position          = ccp(kWidthScreen/2, field3.position.y + field4.size.height*1.3f);
    [self addChildToTopZ:field4];
    
    field5                   = [SKSpriteNode spriteNodeWithTexture: self.fieldTexture];
    field5.anchorPoint       = ccp(0.5f, 0.5f);
    field5.position          = ccp(kWidthScreen/2, field4.position.y + field5.size.height*1.3f);
    [self addChildToTopZ:field5 ];
    
    field6                   = [SKSpriteNode spriteNodeWithTexture: self.fieldTexture];
    field6.anchorPoint       = ccp(0.5f, 0.5f);
    field6.position          = ccp(kWidthScreen/2, field5.position.y + field6.size.height*1.3f);
    [self addChildToTopZ:field6 ];
}

-(void) addCoinsIcons
{
    coinIco1                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco1.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco1.position          = ccp(field1.position.x - field1.size.width*0.46f, field1.position.y);
    [self addChildToTopZ:coinIco1];
    
    coinIco2                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco2.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco2.position          = ccp(field2.position.x - field2.size.width*0.46f, field2.position.y);
    [self addChildToTopZ:coinIco2];
    
    coinIco3                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco3.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco3.position          = ccp(field3.position.x - field3.size.width*0.46f, field3.position.y);
    [self addChildToTopZ:coinIco3];
    
    coinIco4                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco4.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco4.position          = ccp(field4.position.x - field4.size.width*0.46f, field4.position.y);
    [self addChildToTopZ:coinIco4];
    
    coinIco5                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco5.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco5.position          = ccp(field5.position.x - field5.size.width*0.46f, field5.position.y);
    [self addChildToTopZ:coinIco5];
    
    coinIco6                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco6.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco6.position          = ccp(field6.position.x - field6.size.width*0.46f, field6.position.y);
    [self addChildToTopZ:coinIco6];
}

-(void) addBuyCoinsButtons
{
    buyBtn6                   = [SKSpriteNode spriteNodeWithTexture: self.buyButtonTexture];
    buyBtn6.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn6.position          = ccp(field1.position.x + field1.size.width*0.495f, field1.position.y);
    [self addChildToTopZ:buyBtn6];
    
    buyLabel1                 = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    buyLabel1.text = @"BUY";
    buyLabel1.position        = ccp(buyBtn6.position.x - buyBtn6.size.width/2, buyBtn6.position.y);
    buyLabel1.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel1.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel1.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel1];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn5                   = [SKSpriteNode spriteNodeWithTexture: self.buyButtonTexture];
    buyBtn5.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn5.position          = ccp(field2.position.x + field2.size.width*0.495f, field2.position.y);
    [self addChildToTopZ:buyBtn5];
    
    buyLabel2                 = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    buyLabel2.text = @"BUY";
    buyLabel2.position        = ccp(buyBtn5.position.x - buyBtn5.size.width/2, buyBtn5.position.y);
    buyLabel2.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel2.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel2.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel2];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn4                   = [SKSpriteNode spriteNodeWithTexture: self.buyButtonTexture];
    buyBtn4.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn4.position          = ccp(field3.position.x + field3.size.width*0.495f, field3.position.y);
    [self addChildToTopZ:buyBtn4];
    
    buyLabel3                 = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    buyLabel3.text = @"BUY";
    buyLabel3.position        = ccp(buyBtn4.position.x - buyBtn4.size.width/2, buyBtn4.position.y);
    buyLabel3.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel3.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel3.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel3];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn3                   = [SKSpriteNode spriteNodeWithTexture: self.buyButtonTexture];
    buyBtn3.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn3.position          = ccp(field4.position.x + field4.size.width*0.495f, field4.position.y);
    [self addChildToTopZ:buyBtn3];
    
    buyLabel4                 = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    buyLabel4.text = @"BUY";
    buyLabel4.position        = ccp(buyBtn3.position.x - buyBtn3.size.width/2, buyBtn3.position.y);
    buyLabel4.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel4.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel4.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel4];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn2                   = [SKSpriteNode spriteNodeWithTexture: self.buyButtonTexture];
    buyBtn2.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn2.position          = ccp(field5.position.x + field5.size.width*0.495f, field5.position.y);
    [self addChildToTopZ:buyBtn2];;
    
    buyLabel5                 = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    buyLabel5.text = @"BUY";
    buyLabel5.position        = ccp(buyBtn2.position.x - buyBtn2.size.width/2, buyBtn2.position.y);
    buyLabel5.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel5.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel5.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel5];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn1                   = [SKSpriteNode spriteNodeWithTexture: self.buyButtonTexture];
    buyBtn1.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn1.position          = ccp(field6.position.x + field6.size.width*0.495f, field6.position.y);
    
    [self addChildToTopZ:buyBtn1];
    
    buyLabel6                 = [SKLabelNode labelNodeWithFontNamed:kFONT_MENU];
    buyLabel6.text = @"BUY";
    buyLabel6.position        = ccp(buyBtn1.position.x - buyBtn1.size.width/2, buyBtn1.position.y);
    buyLabel6.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel6.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel6.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel6];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

-(void) addCoins_value_for_line1:(NSString *)l1_ for_line2:(NSString *)l2_ for_line3:(NSString *)l3_ for_line4:(NSString *)l4_ for_line5:(NSString *)l5_ for_line6:(NSString *)l6_
{
    coinsAmount1 = l1_.floatValue; coinsAmount2 = l2_.floatValue; coinsAmount3 = l3_.floatValue; coinsAmount4 = l4_.floatValue; coinsAmount5 = l5_.floatValue; coinsAmount6 = l6_.floatValue;
    
    lineLabel1 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    lineLabel1.text = [NSString stringWithFormat:@"%@", l6_];
    lineLabel1.position        = ccp(coinIco1.position.x + coinIco1.size.width *0.85f, coinIco1.position.y);
    lineLabel1.alpha         = 110/255.0;
    lineLabel1.fontColor           = SKColor3(233, 192, 0);
    lineLabel1.scale           = 0.8f;
    lineLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    if (iPhone3) { lineLabel1.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel1.scale = 1.6;
    }
    [self addChildToTopZ:lineLabel1];
    
    lineLabel2 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    lineLabel2.text = [NSString stringWithFormat:@"%@", l5_];
    lineLabel2.position        = ccp(coinIco2.position.x + coinIco2.size.width *0.85f, coinIco2.position.y);
    lineLabel2.alpha         = 145/255.0;
    lineLabel2.scale           = 0.8f;
    lineLabel2.fontColor           = SKColor3(233, 192, 0);
    lineLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    if (iPhone3) { lineLabel2.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel2.scale = 1.6;
    }
    [self addChildToTopZ:lineLabel2];
    
    lineLabel3 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    lineLabel3.text = [NSString stringWithFormat:@"%@", l4_];
    lineLabel3.position        = ccp(coinIco3.position.x + coinIco3.size.width *0.85f, coinIco3.position.y);
    lineLabel3.alpha         = 160/255.0;
    lineLabel3.scale           = 0.8f;
    lineLabel3.fontColor           = SKColor3(233, 192, 0);
    lineLabel3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    if (iPhone3) { lineLabel3.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel3.scale = 1.6;
    }
    [self addChildToTopZ:lineLabel3];
    
    lineLabel4 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    lineLabel4.text = [NSString stringWithFormat:@"%@", l3_];
    lineLabel4.position        = ccp(coinIco4.position.x + coinIco4.size.width *0.85f, coinIco4.position.y);
    lineLabel4.alpha         = 185/255.0;
    lineLabel4.scale           = 0.8f;
    lineLabel4.fontColor           = SKColor3(233, 192, 0);
    lineLabel4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    if (iPhone3) { lineLabel4.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel4.scale = 1.6;
    }
    [self addChildToTopZ:lineLabel4];
    
    lineLabel5 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    lineLabel5.text = [NSString stringWithFormat:@"%@", l2_];
    lineLabel5.position        = ccp(coinIco5.position.x + coinIco5.size.width *0.85f, coinIco5.position.y);
    lineLabel5.alpha         = 200/255.0;
    lineLabel5.scale           = 0.8f;
    lineLabel5.fontColor           = SKColor3(233, 192, 0);
    lineLabel5.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    if (iPhone3) { lineLabel5.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel5.scale = 1.6;
    }
    [self addChildToTopZ:lineLabel5];
    
    lineLabel6 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    lineLabel6.text = [NSString stringWithFormat:@"%@", l1_];
    lineLabel6.position        = ccp(coinIco6.position.x + coinIco6.size.width *0.85f, coinIco6.position.y);
    lineLabel6.alpha         = 255/255.0;
    lineLabel6.scale           = 0.8f;
    lineLabel6.fontColor           = SKColor3(233, 192, 0);
    lineLabel6.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    if (iPhone3) { lineLabel6.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel6.scale = 1.6;
    }
    [self addChildToTopZ:lineLabel6];
}

-(void) addCoins_prices
{
    CGFloat priceLabelSpacing = 1.1f;
    
    priceLabel1 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    priceLabel1.text = @"$99.99";
    priceLabel1.position        = ccp(buyBtn1.position.x - buyBtn1.size.width*priceLabelSpacing, buyBtn1.position.y);
    priceLabel1.fontColor           = [SKColor lightTextColor];
    priceLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    if (iPhone3) { priceLabel1.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel1.scale = 1.6;
    }
    [self addChildToTopZ:priceLabel1];
    
    priceLabel2 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    priceLabel2.text = @"$49.99";
    priceLabel2.position        = ccp(buyBtn2.position.x - buyBtn2.size.width*priceLabelSpacing, buyBtn2.position.y);
    priceLabel2.fontColor           = [SKColor lightTextColor];
    priceLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    if (iPhone3) { priceLabel2.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel2.scale = 1.6;
    }
    [self addChildToTopZ:priceLabel2];
    
    priceLabel3 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    priceLabel3.text = @"$19.99";
    priceLabel3.position        = ccp(buyBtn3.position.x - buyBtn3.size.width*priceLabelSpacing, buyBtn3.position.y);
    priceLabel3.fontColor           = [SKColor lightTextColor];
    priceLabel3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    if (iPhone3) { priceLabel3.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel3.scale = 1.6;
    }
    [self addChildToTopZ:priceLabel3];
    
    priceLabel4 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    priceLabel4.text = @"$9.99";
    priceLabel4.position        = ccp(buyBtn4.position.x - buyBtn4.size.width*priceLabelSpacing, buyBtn4.position.y);
    priceLabel4.fontColor           = [SKColor lightTextColor];
    priceLabel4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    if (iPhone3) { priceLabel4.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel4.scale = 1.6;
    }
    [self addChildToTopZ:priceLabel4];
    
    priceLabel5 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    priceLabel5.text = @"$4.99";
    priceLabel5.position        = ccp(buyBtn5.position.x - buyBtn5.size.width*priceLabelSpacing, buyBtn5.position.y);
    priceLabel5.fontColor           = [SKColor lightTextColor];
    priceLabel5.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    if (iPhone3) { priceLabel5.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel5.scale = 1.6;
    }
    [self addChildToTopZ:priceLabel5];
    
    priceLabel6 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    priceLabel6.text = @"$1.99";
    priceLabel6.position        = ccp(buyBtn6.position.x - buyBtn6.size.width*priceLabelSpacing, buyBtn6.position.y);
    priceLabel6.fontColor           = [SKColor lightTextColor];
    priceLabel6.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    if (iPhone3) { priceLabel6.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel6.scale = 1.6;
    }
    [self addChildToTopZ:priceLabel6];

}

-(NSString*)percenetSign
{
    return @"%";
}

-(void) addBonusPercent1:(int)p1_ percent2:(int)p2_ percent3:(int)p3_ percent4:(int)p4_ percent5:(int)p5_ percent6:(int)p6_
{
    if (IS_IPAD) { dis_ = 3.0f; }
    else         { if (iPhone3) { dis_ = 3.5f; } else { dis_ = 3.0f; }}
    
    bonusP1 = p1_; bonusP2 = p2_; bonusP3 = p3_; bonusP4 = p4_; bonusP5 = p5_; bonusP6 = p6_;
    
    
    CGFloat percentBGXPosition = lineLabel1.right + lineLabel1.frame.size.width  * 0.5;
    
    bonusPercent1               = [SKSpriteNode spriteNodeWithTexture: self.percentBackgroundTexture];
    bonusPercent1.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent1.position      = ccp(percentBGXPosition, field6.position.y);
    [self addChildToTopZ:bonusPercent1];
    
    bonusLabel1 =   [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    bonusLabel1.text = [NSString stringWithFormat:@"+%d%@", p1_,[self percenetSign]];
    bonusLabel1.position        = ccp(bonusPercent1.position.x, bonusPercent1.position.y);
    bonusLabel1.fontColor           = [SKColor darkTextColor];
    bonusLabel1.scale           = 0.85f;
    if (iPhone3) { bonusLabel1.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel1.scale = 1.6;
    }
    [self addChildToTopZ:bonusLabel1];
    
    
    bonusPercent2               = [SKSpriteNode spriteNodeWithTexture: self.percentBackgroundTexture];
    bonusPercent2.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent2.position      = ccp(percentBGXPosition, field5.position.y);
    [self addChildToTopZ:bonusPercent2];
    
    bonusLabel2 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    bonusLabel2.text = [NSString stringWithFormat:@"+%d%@", p2_,[self percenetSign]];
    bonusLabel2.position        = ccp(bonusPercent2.position.x, bonusPercent2.position.y);
    bonusLabel2.fontColor           = [SKColor darkTextColor];
    bonusLabel2.scale           = 0.85f;
    if (iPhone3) { bonusLabel2.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel2.scale = 1.6;
    }
    [self addChildToTopZ:bonusLabel2];
    
    
    bonusPercent3               = [SKSpriteNode spriteNodeWithTexture: self.percentBackgroundTexture];
    bonusPercent3.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent3.position      = ccp(percentBGXPosition, field4.position.y);
    [self addChildToTopZ:bonusPercent3];
    
    bonusLabel3 =   [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    bonusLabel3.text = [NSString stringWithFormat:@"+%d%@", p3_,[self percenetSign]];
    bonusLabel3.position        = ccp(bonusPercent3.position.x, bonusPercent3.position.y);
    bonusLabel3.fontColor           = [SKColor darkTextColor];
    bonusLabel3.scale           = 0.85f;
    if (iPhone3) { bonusLabel3.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel3.scale = 1.6;
    }
    [self addChildToTopZ:bonusLabel3];
    
    
    bonusPercent4               = [SKSpriteNode spriteNodeWithTexture: self.percentBackgroundTexture];
    bonusPercent4.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent4.position      = ccp(percentBGXPosition, field3.position.y);
    [self addChildToTopZ:bonusPercent4];
    
    bonusLabel4 =   [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    bonusLabel4.text = [NSString stringWithFormat:@"+%d%@", p4_,[self percenetSign]];
    bonusLabel4.position        = ccp(bonusPercent4.position.x, bonusPercent4.position.y);
    bonusLabel4.fontColor           = [SKColor darkTextColor];
    bonusLabel4.scale           = 0.85f;
    if (iPhone3) { bonusLabel4.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel4.scale = 1.6;
    }
    [self addChildToTopZ:bonusLabel4];
    
    
    bonusPercent5               = [SKSpriteNode spriteNodeWithTexture: self.percentBackgroundTexture];
    bonusPercent5.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent5.position      = ccp(percentBGXPosition, field2.position.y);
    [self addChildToTopZ:bonusPercent5];
    
    
    
    bonusLabel5 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    bonusLabel5.text = [NSString stringWithFormat:@"+%d%@", p5_,[self percenetSign]] ;
    bonusLabel5.position        = ccp(bonusPercent5.position.x, bonusPercent5.position.y);
    bonusLabel5.fontColor           = [SKColor darkTextColor];
    bonusLabel5.scale           = 0.85f;
    if (iPhone3) { bonusLabel5.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel5.scale = 1.6;
    }
    [self addChildToTopZ:bonusLabel5];
    
    
    bonusPercent6               = [SKSpriteNode spriteNodeWithTexture: self.percentBackgroundTexture];
    bonusPercent6.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent6.position      = ccp(percentBGXPosition, field1.position.y);
    [self addChildToTopZ:bonusPercent6];
    
    bonusLabel6 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    bonusLabel6.text = [NSString stringWithFormat:@"+%d%@", p6_,[self percenetSign]] ;
    bonusLabel6.position        = ccp(bonusPercent6.position.x, bonusPercent6.position.y);
    bonusLabel6.fontColor           = [SKColor darkTextColor];
    bonusLabel6.scale           = 0.85f;
    if (iPhone3) { bonusLabel6.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel6.scale = 1.6;
    }
    [self addChildToTopZ:bonusLabel6];

  
}

-(void) addEquallitySymbol
{
    equal1 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    equal1.text = @"=";
    equal1.position        = ccp(bonusPercent1.position.x + bonusPercent1.size.width*0.7f, bonusPercent1.position.y);
    equal1.fontColor           = SKColor3(233, 192, 0);
    if (iPhone3) { equal1.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal1.scale = 1.6;
    }
    [self addChildToTopZ:equal1];
    
    equal2 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    equal2.text = @"=";
    equal2.position        = ccp(bonusPercent2.position.x + bonusPercent2.size.width*0.7f, bonusPercent2.position.y);
    equal2.fontColor           = SKColor3(233, 192, 0);
    if (iPhone3) { equal2.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal2.scale = 1.6;
    }
    [self addChildToTopZ:equal2];
    
    equal3 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    equal3.text = @"=";
    equal3.position        = ccp(bonusPercent3.position.x + bonusPercent3.size.width*0.7f, bonusPercent3.position.y);
    equal3.fontColor           = SKColor3(233, 192, 0);
    if (iPhone3) { equal3.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal3.scale = 1.6;
    }
    [self addChildToTopZ:equal3];
    
    equal4 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    equal4.text = @"=";
    equal4.position        = ccp(bonusPercent4.position.x + bonusPercent4.size.width*0.7f, bonusPercent4.position.y);
    equal4.fontColor           = SKColor3(233, 192, 0);
    if (iPhone3) { equal4.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal4.scale = 1.6;
    }
    [self addChildToTopZ:equal4];
    
    equal5 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    equal5.text = @"=";
    equal5.position        = ccp(bonusPercent5.position.x + bonusPercent5.size.width*0.7f, bonusPercent5.position.y);
    equal5.fontColor           = SKColor3(233, 192, 0);
    if (iPhone3) { equal5.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal5.scale = 1.6;
    }
    [self addChildToTopZ:equal5];
    
    equal6 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    equal6.text = @"=";
    equal6.position        = ccp(bonusPercent6.position.x + bonusPercent6.size.width*0.7f, bonusPercent6.position.y);
    equal6.fontColor           = SKColor3(233, 192, 0);
    if (iPhone3) { equal6.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal6.scale = 1.6;
    }
    [self addChildToTopZ:equal6];


}

-(void) addCoinsIcons2
{
    coinIco11                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco11.position          = ccp(equal1.position.x + equal1.frame.size.width * 2, equal1.position.y);
    [self addChildToTopZ:coinIco11];
    
    coinIco22                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco22.position          = ccp(equal2.position.x + equal2.frame.size.width * 2, equal2.position.y);
    [self addChildToTopZ:coinIco22];
    
    coinIco33                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco33.position          = ccp(equal3.position.x + equal3.frame.size.width * 2, equal3.position.y);
    [self addChildToTopZ:coinIco33];
    
    coinIco44                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco44.position          = ccp(equal4.position.x + equal4.frame.size.width * 2, equal4.position.y);
    [self addChildToTopZ:coinIco44];
    
    coinIco55                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco55.position          = ccp(equal5.position.x + equal5.frame.size.width * 2, equal5.position.y);
    [self addChildToTopZ:coinIco55];
    
    coinIco66                   = [SKSpriteNode spriteNodeWithTexture: self.coinTexture];
    coinIco66.position          = ccp(equal6.position.x + equal6.frame.size.width * 2 , equal6.position.y);
    [self addChildToTopZ:coinIco66];
}

-(void) count_Final_Coins_Amount
{
    
    [self setFinalCoins_amount_for_line1:@"612,500" for_line2:@"217,500" for_line3:@"52,000" for_line4:@"17,250" for_line5:@"4,400" for_line6:@"1,050"];
}

-(void) setFinalCoins_amount_for_line1:(NSString *)l1_ for_line2:(NSString *)l2_ for_line3:(NSString *)l3_ for_line4:(NSString *)l4_ for_line5:(NSString *)l5_ for_line6:(NSString *)l6_
{
    finalAmountLabel1 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    finalAmountLabel1.text = [NSString stringWithFormat:@"%@", l1_];
    finalAmountLabel1.position        = ccp(coinIco11.right, coinIco11.position.y);
    finalAmountLabel1.alpha         = 255/255.0;
    finalAmountLabel1.scale           = 1.1;
    finalAmountLabel1.fontColor           = SKColor3(233, 192, 0);
    finalAmountLabel1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    if (iPhone3) { finalAmountLabel1.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel1.scale = 1.6;
    }
    [self addChildToTopZ:finalAmountLabel1];
    
    finalAmountLabel2 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    finalAmountLabel2.text = [NSString stringWithFormat:@"%@", l2_];
    finalAmountLabel2.position        = ccp(coinIco22.right, coinIco22.position.y);
    finalAmountLabel2.alpha         = 200/255.0;
    finalAmountLabel2.scale           = 1.1;
    finalAmountLabel2.fontColor           = SKColor3(233, 192, 0);
    finalAmountLabel2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    if (iPhone3) { finalAmountLabel2.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel2.scale = 1.6;
    }
    [self addChildToTopZ:finalAmountLabel2];
    
    finalAmountLabel3 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    finalAmountLabel3.text = [NSString stringWithFormat:@"%@", l3_];
    finalAmountLabel3.position        = ccp(coinIco33.right, coinIco33.position.y);
    finalAmountLabel3.alpha         = 185/255.0;
    finalAmountLabel3.scale           = 1.1;
    finalAmountLabel3.fontColor           = SKColor3(233, 192, 0);
    finalAmountLabel3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    if (iPhone3) { finalAmountLabel3.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel3.scale = 1.6;
    }
    [self addChildToTopZ:finalAmountLabel3];
    
    finalAmountLabel4 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    finalAmountLabel4.text = [NSString stringWithFormat:@"%@", l4_];
    finalAmountLabel4.position        = ccp(coinIco44.right, coinIco44.position.y);
    finalAmountLabel4.alpha         = 160/255.0;
    finalAmountLabel4.scale           = 1.1;
    finalAmountLabel4.fontColor           = SKColor3(233, 192, 0);
    finalAmountLabel4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    if (iPhone3) { finalAmountLabel4.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel4.scale = 1.6;
    }
    [self addChildToTopZ:finalAmountLabel4];
    
    finalAmountLabel5 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    finalAmountLabel5.text = [NSString stringWithFormat:@"%@", l5_];
    finalAmountLabel5.position        = ccp(coinIco55.right, coinIco55.position.y);
    finalAmountLabel5.alpha         = 145/255.0;
    finalAmountLabel5.scale           = 1.1;
    finalAmountLabel5.fontColor           = SKColor3(233, 192, 0);
    finalAmountLabel5.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;

    if (iPhone3) { finalAmountLabel5.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel5.scale = 1.6;
    }
    [self addChildToTopZ:finalAmountLabel5];
    
    finalAmountLabel6 = [SKLabelNode labelNodeWithFontNamed:kFONT_BUY_TXT];
    finalAmountLabel6.text = [NSString stringWithFormat:@"%@", l6_];
    finalAmountLabel6.position        = ccp(coinIco66.right, coinIco66.position.y);
    finalAmountLabel6.alpha         = 110/255.0;
    finalAmountLabel6.scale           = 1.1;
    finalAmountLabel6.fontColor           = SKColor3(233, 192, 0);
    finalAmountLabel6.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;

    if (iPhone3) { finalAmountLabel6.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel6.scale = 1.6;
    }
    [self addChildToTopZ:finalAmountLabel6];

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
//



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SKNode* touchedNode = [self nodeFromTouches:touches];
    
    
    if ([touchedNode isEqualToNode: closeBtn])
    {
        [AUDIO playEffect:s_click1];
        [closeBtn setTexture:closeFrame];
    }
    
    if ([touchedNode isEqualToNode: boostBtn])
    {
        [AUDIO playEffect:s_click1];
        [buyBtn1 setTexture:self.buyButtonActiveTexture];
    }
    ///////////////////////////////////////////////////////////// BUY BUTTONS //////////////////////////
    if ([touchedNode isEqualToNode: buyBtn1])
    {
        [AUDIO playEffect:s_click1];
        [buyBtn1 setTexture:self.buyButtonActiveTexture];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_99_99 parent:self];
    }
    
    if ([touchedNode isEqualToNode: buyBtn2])
    {
        [AUDIO playEffect:s_click1];
        [buyBtn2 setTexture:self.buyButtonActiveTexture];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_49_99 parent:self];
    }
    
    if ([touchedNode isEqualToNode: buyBtn3])
    {
        [AUDIO playEffect:s_click1];
        [buyBtn3 setTexture:self.buyButtonActiveTexture];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_19_99 parent:self];
    }
    
    if ([touchedNode isEqualToNode: buyBtn4])
    {
        [AUDIO playEffect:s_click1];
        [buyBtn4 setTexture:self.buyButtonActiveTexture];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_9_99 parent:self];
    }
    
    if ([touchedNode isEqualToNode: buyBtn5])
    {
        [AUDIO playEffect:s_click1];
        [buyBtn5 setTexture:self.buyButtonActiveTexture];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_4_99 parent:self];
    }
    if ([touchedNode isEqualToNode: buyBtn6])
    {
        [AUDIO playEffect:s_click1];
        [buyBtn6 setTexture:self.buyButtonActiveTexture];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_1_99 parent:self];
    }
    
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SKNode* touchedNode = [self nodeFromTouches:touches];
    
    if ([touchedNode isEqualToNode:closeBtn])
    {
        [closeBtn setTexture:closeFrame];
        [self closeWindow];
        // [AUDIO playEffect:s_click1];
        //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    if ([touchedNode isEqualToNode:boostBtn])
    {
        coinsBtn.hidden = NO;
        boostBtn.hidden = NO;
        closeBtn.hidden = NO;
        [self openBoostsWindow];
        // [AUDIO playEffect:s_click1];
        //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    [buyBtn1 setTexture:self.buyButtonTexture];
    [buyBtn2 setTexture:self.buyButtonTexture];
    [buyBtn3 setTexture:self.buyButtonTexture];
    [buyBtn4 setTexture:self.buyButtonTexture];
    [buyBtn5 setTexture:self.buyButtonTexture];
    [buyBtn6 setTexture:self.buyButtonTexture];
    
}

//
//
//-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
////    
////    if(framePressed == nil)
////    {
////        framePressed = [SKTexture textureWithImageNamed:@"btn_buy_active.png"]
////    }= [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_buy_active.png"]];
////    closeFrame      = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_close_active.png"]];
//    
////    id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:0.9f];
////    id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
////    id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
//    
//    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
//    {
//        [AUDIO playEffect:s_click1];
//        [closeBtn setDisplayFrame:closeFrame];
//    }
//    
//    if (CGRectContainsPoint(boostBtn.boundingBox, touchPos))
//    {
//        [AUDIO playEffect:s_click1];
//        [buyBtn1 setTexture:[[SKSpriteNode spriteNodeWithImageNamed:@"btn_buy_active.png"]CCtexture]];
//    }
//    ///////////////////////////////////////////////////////////// BUY BUTTONS //////////////////////////
//    if (CGRectContainsPoint(buyBtn1.boundingBox, touchPos))
//    {
//        [AUDIO playEffect:s_click1];
//        [buyBtn1 setDisplayFrame:framePressed];
//        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_99_99 parent:self];
//    }
//    
//    if (CGRectContainsPoint(buyBtn2.boundingBox, touchPos))
//    {
//        [AUDIO playEffect:s_click1];
//        [buyBtn2 setDisplayFrame:framePressed];
//        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_49_99 parent:self];
//    }
//    
//    if (CGRectContainsPoint(buyBtn3.boundingBox, touchPos))
//    {
//        [AUDIO playEffect:s_click1];
//        [buyBtn3 setDisplayFrame:framePressed];
//        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_19_99 parent:self];
//    }
//    
//    if (CGRectContainsPoint(buyBtn4.boundingBox, touchPos))
//    {
//        [AUDIO playEffect:s_click1];
//        [buyBtn4 setDisplayFrame:framePressed];
//        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_9_99 parent:self];
//    }
//    
//    if (CGRectContainsPoint(buyBtn5.boundingBox, touchPos))
//    {
//        [AUDIO playEffect:s_click1];
//        [buyBtn5 setDisplayFrame:framePressed];
//        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_4_99 parent:self];
//    }
//    if (CGRectContainsPoint(buyBtn6.boundingBox, touchPos))
//    {
//        [AUDIO playEffect:s_click1];
//        [buyBtn6 setDisplayFrame:framePressed];
//        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_1_99 parent:self];
//    }
//    ////////////////////////////////////////////////////////////////////////////////////////////////////
//    
//    
//    return YES;
//}
//
//-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
//{
//    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
//    
//    closeFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_close.png"]];
//    [closeBtn setDisplayFrame:closeFrame];
//    
//    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
//    {
//        [self closeWindow];
//        // [AUDIO playEffect:s_click1];
//      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//    }
//    
//    if (CGRectContainsPoint(boostBtn.boundingBox, touchPos))
//    {
//        coinsBtn.hidden = NO;
//        boostBtn.hidden = NO;
//        closeBtn.hidden = NO;
//        [self openBoostsWindow];
//        // [AUDIO playEffect:s_click1];
//      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//    }
//    
//    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_buy.png"]];
//    [buyBtn1 setDisplayFrame:frame];
//    [buyBtn2 setDisplayFrame:frame];
//    [buyBtn3 setDisplayFrame:frame];
//    [buyBtn4 setDisplayFrame:frame];
//    [buyBtn5 setDisplayFrame:frame];
//    [buyBtn6 setDisplayFrame:frame];
//
//}

-(void) openBoostsWindow
{
#warning EF

    BuyBoostsWindow *BWindow = [[BuyBoostsWindow alloc] initWithBool:NO];
    BWindow.anchorPoint = ccp(0, 0);
//    [self addChildToTopZ:BWindow z:15 tag:kBoostsTAG];
}

-(void) closeBoostsWindow
{
    coinsBtn.hidden = YES;
    boostBtn.hidden = YES;
    closeBtn.hidden = YES;
    SKNode* boostWindow = [self childNodeWithName:kNodeBuyBoosts];
    if(boostWindow && boostWindow.parent)
    {
        [boostWindow removeFromParent];
    }
}


-(void) closeWindow
{
   
#warning EF check this parent
    if ([self.parent isKindOfClass:[PopupManager class]]) {
        PopupManager* popupManager = (PopupManager*) self.parent;
        [popupManager closeBuyWindow];
    }
//#warning EF animation this maybe?
//    SKAction* scale3       = [SKAction scaleTo:0.1 duration:0.2];
//
//    __weak BuyCoinsWindow* weakSelf = self;
//    [self runAction:scale3 completion:^{
//        if ([weakSelf.parent isKindOfClass:[PopupManager class]])
//        {
//            [weakSelf.parent performSelector:@selector(closeBuyWindow) withObject:nil];
//        }
//
//    }];
}
























@end

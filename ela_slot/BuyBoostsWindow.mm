#import "BuyBoostsWindow.h"
#import "PopupManager.h"
#import "BuyCoinsWindow.h"
#import "SKNode+SKNode_Extensions.h"

@interface BuyBoostsWindow()
@property(nonatomic, strong) SKSpriteNode *background;

@property(nonatomic, strong) SKLabelNode *coinsLabel;
@property(nonatomic, strong) SKLabelNode *boostsLabel;

@property(nonatomic, strong) SKLabelNode *buyLabel1;
@property(nonatomic, strong) SKLabelNode *buyLabel2;
@property(nonatomic, strong) SKLabelNode *buyLabel3;
@property(nonatomic, strong) SKLabelNode *buyLabel4;

@property(nonatomic, strong) SKSpriteNode *closeBtn;
@property(nonatomic, strong) SKSpriteNode *coinsBtn;
@property(nonatomic, strong) SKSpriteNode *boostBtn;

@property(nonatomic, strong) SKTexture *closeFrame;
@property(nonatomic, strong) SKTexture *framePressed;
@property(nonatomic, strong) SKTexture *frameNotPressed;

@property(nonatomic, strong) SKTexture *selectedBoost2x;
@property(nonatomic, strong) SKTexture *selectedBoost3x;
@property(nonatomic, strong) SKTexture *selectedBoost4x;
@property(nonatomic, strong) SKTexture *selectedBoost5x;

@property(nonatomic, strong) SKTexture *NOTselectedBoost2x;
@property(nonatomic, strong) SKTexture *NOTselectedBoost3x;
@property(nonatomic, strong) SKTexture *NOTselectedBoost4x;
@property(nonatomic, strong) SKTexture *NOTselectedBoost5x;


@property(nonatomic, strong) SKTexture *boostBuyTexture;
@property(nonatomic, strong) SKTexture *boostBuyOneBGTexture;
//@property(nonatomic, strong) SKTexture *NOTselectedBoost5x;



@property(nonatomic, strong) SKSpriteNode *blackBG;

@property(nonatomic, strong) SKSpriteNode *selectedBG;

@property(nonatomic, strong) SKSpriteNode *brownBG1;
@property(nonatomic, strong) SKSpriteNode *brownBG2;
@property(nonatomic, strong) SKSpriteNode *brownBG3;
@property(nonatomic, strong) SKSpriteNode *brownBG4;

@property(nonatomic, strong) SKSpriteNode *buyButton1;
@property(nonatomic, strong) SKSpriteNode *buyButton2;
@property(nonatomic, strong) SKSpriteNode *buyButton3;
@property(nonatomic, strong) SKSpriteNode *buyButton4;

@property(nonatomic, strong) SKSpriteNode *buyButtonP1;
@property(nonatomic, strong) SKSpriteNode *buyButtonP2;
@property(nonatomic, strong) SKSpriteNode *buyButtonP3;
@property(nonatomic, strong) SKSpriteNode *buyButtonP4;

@property(nonatomic, strong) SKSpriteNode *buyBSelect1;
@property(nonatomic, strong) SKSpriteNode *buyBSelect2;
@property(nonatomic, strong) SKSpriteNode *buyBSelect3;
@property(nonatomic, strong) SKSpriteNode *buyBSelect4;


@property(nonatomic, strong) SKLabelNode *priceLabel1;
@property(nonatomic, strong) SKLabelNode *priceLabel2;
@property(nonatomic, strong) SKLabelNode *priceLabel3;
@property(nonatomic, strong) SKLabelNode *priceLabel4;

@property(nonatomic, strong) SKLabelNode *boostNumber;
@property(nonatomic, strong) SKLabelNode *boostNumber2;
@property(nonatomic, strong) SKLabelNode *boostNumber3;
@property(nonatomic, strong) SKLabelNode *boostNumber4;




@end

@implementation BuyBoostsWindow
@synthesize background = background;
@synthesize coinsLabel = coinsLabel;
@synthesize boostsLabel = boostsLabel;
@synthesize buyLabel1 = buyLabel1;
@synthesize buyLabel2 = buyLabel2;
@synthesize buyLabel3 = buyLabel3;
@synthesize buyLabel4 = buyLabel4;
@synthesize closeBtn = closeBtn;
@synthesize coinsBtn = coinsBtn;
@synthesize boostBtn = boostBtn;
@synthesize closeFrame = closeFrame;
@synthesize framePressed = framePressed;
@synthesize frameNotPressed = frameNotPressed;
@synthesize selectedBoost2x = selectedBoost2x;
@synthesize selectedBoost3x = selectedBoost3x;
@synthesize selectedBoost4x = selectedBoost4x;
@synthesize selectedBoost5x = selectedBoost5x;
@synthesize NOTselectedBoost2x = NOTselectedBoost2x;
@synthesize NOTselectedBoost3x = NOTselectedBoost3x;
@synthesize NOTselectedBoost4x = NOTselectedBoost4x;
@synthesize NOTselectedBoost5x = NOTselectedBoost5x;
@synthesize blackBG = blackBG;
@synthesize selectedBG = selectedBG;
@synthesize brownBG1 = brownBG1;
@synthesize brownBG2 = brownBG2;
@synthesize brownBG3 = brownBG3;
@synthesize brownBG4 = brownBG4;
@synthesize buyButton1 = buyButton1;
@synthesize buyButton2 = buyButton2;
@synthesize buyButton3 = buyButton3;
@synthesize buyButton4 = buyButton4;
@synthesize buyButtonP1 = buyButtonP1;
@synthesize buyButtonP2 = buyButtonP2;
@synthesize buyButtonP3 = buyButtonP3;
@synthesize buyButtonP4 = buyButtonP4;
@synthesize buyBSelect1 = buyBSelect1;
@synthesize buyBSelect2 = buyBSelect2;
@synthesize buyBSelect3 = buyBSelect3;
@synthesize buyBSelect4 = buyBSelect4;
@synthesize priceLabel1 = priceLabel1;
@synthesize priceLabel2 = priceLabel2;
@synthesize priceLabel3 = priceLabel3;
@synthesize priceLabel4 = priceLabel4;
@synthesize boostNumber = boostNumber;
@synthesize boostNumber2 = boostNumber2;
@synthesize boostNumber3 = boostNumber3;
@synthesize boostNumber4 = boostNumber4;



-(id)initWithBool:(bool)bool_
{
    if((self = [super init]))
    {
        self.userInteractionEnabled = YES;
        self.name = kNodeBuyBoosts;
        self.size = CGSizeMake(kWidthScreen, kHeightScreen);
        
        //// SCALE EFFECT
        if (bool_) {
#warning EF use spring animation
//            self.scale = 0.3f;
//            id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.2f];
//            id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
//            
//            id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.97f];
//            id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
//            
//            id scale3       = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
//            id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
//            
//            [self runAction:[CCSequence actions:easeScale1,easeScale2,easeScale3, nil]];
        }
        
        
        background             = [SKSpriteNode spriteNodeWithImageNamed:@"buy_BG"];
        background.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChildToTopZ:background];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        [self loadFrames];

        [self addCoinsButton];
        [self addBoostButton];
        [self addCloseButton];
        
        [self addBoostBlackBG];
        [self addBoostBuyButtons];
        [self addSelectedBG];
        [self addBoostSelectButtons];



        BOOSTx2 = true;
        [self changeSelectedBGposition];
        
        [self addBoostLabels];
        
        coinsBtn.hidden = NO;
        boostBtn.hidden = NO;
        
        [self addBoostPrices];
        
        [self changeBoostsPrices];
    }
    
    return self;
}
-(void) loadFrames
{
    selectedBoost2x    = [SKTexture textureWithImageNamed:@"boost_2x_active"];
    selectedBoost3x    = [SKTexture textureWithImageNamed:@"boost_3x_active"];
    selectedBoost4x    = [SKTexture textureWithImageNamed:@"boost_4x_active"];
    selectedBoost5x    = [SKTexture textureWithImageNamed:@"boost_5x_active"];
    
    NOTselectedBoost2x = [SKTexture textureWithImageNamed:@"boost_2x"];
    NOTselectedBoost3x = [SKTexture textureWithImageNamed:@"boost_3x"];
    NOTselectedBoost4x = [SKTexture textureWithImageNamed:@"boost_4x"];
    NOTselectedBoost5x = [SKTexture textureWithImageNamed:@"boost_5x"];
    
    self.boostBuyOneBGTexture = [SKTexture textureWithImageNamed:@"boost_oneBG"];
    self.boostBuyTexture = [SKTexture textureWithImageNamed:@"boost_buy"];
    
}

-(void) addBoostBlackBG
{
    blackBG                   = [SKSpriteNode spriteNodeWithImageNamed:@"boost_bigBG"];
    blackBG.anchorPoint       = ccp(0.5f, 0.0f);
    blackBG.position          = ccp(background.position.x, background.position.y - background.size.height/2 + kHeightScreen*0.05f);
    [self addChildToTopZ:blackBG];
    

    brownBG1                   = [SKSpriteNode spriteNodeWithTexture: self.boostBuyOneBGTexture];
    brownBG1.anchorPoint       = ccp(0.5f, 0.5f);
    brownBG1.position          = ccp(blackBG.position.x - blackBG.size.width/2 + brownBG1.size.width/2 + kWidthScreen*0.014f, blackBG.position.y + blackBG.size.height/2);
    [self addChildToTopZ:brownBG1];
    
    brownBG2                   = [SKSpriteNode spriteNodeWithTexture: self.boostBuyOneBGTexture];
    brownBG2.anchorPoint       = ccp(0.5f, 0.5f);
    brownBG2.position          = ccp(brownBG1.position.x + brownBG1.size.width + kWidthScreen*0.02f, blackBG.position.y + blackBG.size.height/2);
    [self addChildToTopZ:brownBG2];
    
    brownBG3                   = [SKSpriteNode spriteNodeWithTexture: self.boostBuyOneBGTexture];
    brownBG3.anchorPoint       = ccp(0.5f, 0.5f);
    brownBG3.position          = ccp(brownBG2.position.x + brownBG2.size.width + kWidthScreen*0.02f, blackBG.position.y + blackBG.size.height/2);
    [self addChildToTopZ:brownBG3];
    
    brownBG4                   = [SKSpriteNode spriteNodeWithTexture: self.boostBuyOneBGTexture];
    brownBG4.anchorPoint       = ccp(0.5f, 0.5f);
    brownBG4.position          = ccp(brownBG3.position.x + brownBG3.size.width + kWidthScreen*0.02f, blackBG.position.y + blackBG.size.height/2);
    [self addChildToTopZ:brownBG4];

}

-(void) addBoostBuyButtons
{
    buyButton1                   = [SKSpriteNode spriteNodeWithTexture:self.boostBuyTexture];
    buyButton1.anchorPoint       = ccp(0.5f, 0.5f);
    buyButton1.position          = ccp(brownBG1.position.x, brownBG1.position.y - brownBG1.size.height/2 + buyButton1.size.height/2);
    [self addChildToTopZ:buyButton1];
    
    
    buyButton2                   = [SKSpriteNode spriteNodeWithTexture:self.boostBuyTexture];
    buyButton2.anchorPoint       = ccp(0.5f, 0.5f);
    buyButton2.position          = ccp(brownBG2.position.x, brownBG2.position.y - brownBG2.size.height/2 + buyButton2.size.height/2);
    [self addChildToTopZ:buyButton2];
    
    buyButton3                   = [SKSpriteNode spriteNodeWithTexture:self.boostBuyTexture];
    buyButton3.anchorPoint       = ccp(0.5f, 0.5f);
    buyButton3.position          = ccp(brownBG3.position.x, brownBG3.position.y - brownBG3.size.height/2 + buyButton3.size.height/2);
    [self addChildToTopZ:buyButton3];
    
    buyButton4                   = [SKSpriteNode spriteNodeWithTexture:self.boostBuyTexture];
    buyButton4.anchorPoint       = ccp(0.5f, 0.5f);
    buyButton4.position          = ccp(brownBG4.position.x, brownBG4.position.y - brownBG4.size.height/2 + buyButton4.size.height/2);
    [self addChildToTopZ:buyButton4];
    
    
    buyLabel1 = [SKLabelNode labelNodeWithText:@"BUY"];
    buyLabel1.fontName = kFONT_MEDIUM;// [SKLabelNode labelNodeWithText:@"BUY"]; .fontName = kFONT_MEDIUM];
    buyLabel1.position        = ccp(buyButton1.position.x, buyButton1.position.y);
    buyLabel1.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel1.scale = 0.50f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel1.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel1];
    
    buyLabel2 = [SKLabelNode labelNodeWithText:@"BUY"];
    buyLabel2.fontName = kFONT_MEDIUM;
    buyLabel2.position        = ccp(buyButton2.position.x, buyButton2.position.y);
    buyLabel2.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel2.scale = 0.50f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel2.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel2];
    
    buyLabel3 = [SKLabelNode labelNodeWithText:@"BUY"];
    buyLabel3.fontName = kFONT_MEDIUM;
    buyLabel3.position        = ccp(buyButton3.position.x, buyButton3.position.y);
    buyLabel3.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel3.scale = 0.50f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel3.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel3];
    
    buyLabel4 = [SKLabelNode labelNodeWithText:@"BUY"];
    buyLabel4.fontName = kFONT_MEDIUM;
    buyLabel4.position        = ccp(buyButton4.position.x, buyButton4.position.y);
    buyLabel4.fontColor           = SKColor3(61, 70, 42);
    if (iPhone3) { buyLabel4.scale = 0.50f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel4.scale = 1.6;
    }
    [self addChildToTopZ:buyLabel4];
}

-(void) addBoostSelectButtons
{
    buyBSelect1                   = [SKSpriteNode spriteNodeWithTexture:NOTselectedBoost2x];
    buyBSelect1.anchorPoint       = ccp(0.5f, 0.5f);
    buyBSelect1.position          = ccp(brownBG1.position.x, brownBG1.position.y + brownBG1.size.height/2 + buyBSelect1.size.height/2 + kHeightScreen*0.025f);
    [self addChildToTopZ:buyBSelect1];
    
    buyBSelect2                   = [SKSpriteNode spriteNodeWithTexture:NOTselectedBoost3x];
    buyBSelect2.anchorPoint       = ccp(0.5f, 0.5f);
    buyBSelect2.position          = ccp(brownBG2.position.x, brownBG2.position.y + brownBG2.size.height/2 + buyBSelect2.size.height/2 + kHeightScreen*0.025f);
    [self addChildToTopZ:buyBSelect2];
    
    buyBSelect3                   = [SKSpriteNode spriteNodeWithTexture:NOTselectedBoost4x];
    buyBSelect3.anchorPoint       = ccp(0.5f, 0.5f);
    buyBSelect3.position          = ccp(brownBG3.position.x, brownBG3.position.y + brownBG3.size.height/2 + buyBSelect3.size.height/2 + kHeightScreen*0.025f);
    [self addChildToTopZ:buyBSelect3];
    
    buyBSelect4                   = [SKSpriteNode spriteNodeWithTexture:NOTselectedBoost5x];
    buyBSelect4.anchorPoint       = ccp(0.5f, 0.5f);
    buyBSelect4.position          = ccp(brownBG4.position.x, brownBG4.position.y + brownBG4.size.height/2 + buyBSelect4.size.height/2 + kHeightScreen*0.025f);
    [self addChildToTopZ:buyBSelect4];
}

-(void) addSelectedBG
{
    selectedBG                   = [SKSpriteNode spriteNodeWithImageNamed:@"boost_activeBG"];
    selectedBG.anchorPoint       = ccp(0.5f, 0.5f);
    selectedBG.position          = ccp(buyBSelect1.position.x, buyBSelect1.position.y);
    [self addChildToTopZ:selectedBG];
}

-(void) changeSelectedBGposition
{
    if      (BOOSTx2)
    {
        selectedBG.position = ccp(buyBSelect1.position.x, buyBSelect1.position.y);
        
        [buyBSelect1 setTexture:selectedBoost2x];
        [buyBSelect2 setTexture:NOTselectedBoost3x];
        [buyBSelect3 setTexture:NOTselectedBoost4x];
        [buyBSelect4 setTexture:NOTselectedBoost5x];
    }
    
    else if (BOOSTx3)
    {
        selectedBG.position = ccp(buyBSelect2.position.x, buyBSelect2.position.y);
        
        [buyBSelect1 setTexture:NOTselectedBoost2x];
        [buyBSelect2 setTexture:selectedBoost3x];
        [buyBSelect3 setTexture:NOTselectedBoost4x];
        [buyBSelect4 setTexture:NOTselectedBoost5x];
    }
    
    else if (BOOSTx4)
    {
        selectedBG.position = ccp(buyBSelect3.position.x, buyBSelect3.position.y);
        
        [buyBSelect1 setTexture:NOTselectedBoost2x];
        [buyBSelect2 setTexture:NOTselectedBoost3x];
        [buyBSelect3 setTexture:selectedBoost4x];
        [buyBSelect4 setTexture:NOTselectedBoost5x];
    }
    
    else if (BOOSTx5)
    {
        selectedBG.position = ccp(buyBSelect4.position.x, buyBSelect4.position.y);
        
        [buyBSelect1 setTexture:NOTselectedBoost2x];
        [buyBSelect2 setTexture:NOTselectedBoost3x];
        [buyBSelect3 setTexture:NOTselectedBoost4x];
        [buyBSelect4 setTexture:selectedBoost5x];
    }
}

-(void) addCoinsButton
{
    coinsBtn                   = [SKSpriteNode spriteNodeWithImageNamed:@"tab"];
    coinsBtn.position          = ccp(background.position.x - background.size.width/2 + coinsBtn.size.width*0.55f, background.position.y + background.size.height/2 + coinsBtn.size.height*0.35f);
    [self addChildToTopZ:coinsBtn];
    
    coinsLabel                 = [SKLabelNode labelNodeWithText:@"COINS"];
    coinsLabel.fontName = kFONT_BUY_TXT;
    coinsLabel.position        = ccp(coinsBtn.position.x, coinsBtn.position.y);
    coinsLabel.fontColor           = SKColor3(80, 65, 45);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        coinsLabel.scale = 1.6;
    }
    [self addChildToTopZ:coinsLabel];
}

-(void) addBoostButton
{
    boostBtn                   = [SKSpriteNode spriteNodeWithImageNamed:@"tab_active"];
    boostBtn.position          = ccp(coinsBtn.position.x + coinsBtn.size.width/2 + boostBtn.size.width*0.55f, background.position.y + background.size.height/2 + boostBtn.size.height*0.35f);
    
    [self addChildToTopZ:boostBtn];
    
    boostsLabel                = [SKLabelNode labelNodeWithText:@"BOOSTS"];
    boostsLabel.fontName = kFONT_BUY_TXT;
    boostsLabel.position       = ccp(boostBtn.position.x, boostBtn.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostsLabel.scale = 1.6;
    }
    [self addChildToTopZ:boostsLabel];
}

-(void) addCloseButton
{
    closeBtn                   = [SKSpriteNode spriteNodeWithImageNamed:@"menuBTN_close"];
    closeBtn.position          = ccp(background.position.x + background.size.width/2, background.position.y + background.size.height/2);
    [self addChildToTopZ:closeBtn];
}
///////////////////////////////////////////////////////////////////////////////////
#warning  EF
//-(void) onEnter
//{
//    //int priority = kCCMenuTouchPriority - 2;
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


-(void) addBoostLabels
{
    
    //--------------------------------
    SKLabelNode* boostTxt1    = [SKLabelNode labelNodeWithText:@"BOOSTS"];
    boostTxt1.fontName = kFONT_MENU;
    boostTxt1.fontColor             = SKColor3(233, 192, 0);
    if (iPhone3) { boostTxt1.scale = 0.50f; }
    if (IS_IPAD) { boostTxt1.position = ccpAdd(brownBG1.position, ccp(boostTxt1.frame.size.width*0.50f, brownBG1.frame.size.height*0.30f)); }
    else         { boostTxt1.position = ccpAdd(brownBG1.position, ccp(boostTxt1.frame.size.width*0.40f, brownBG1.frame.size.height*0.30f)); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostTxt1.scale = 1.0;
    }
    [self addChildToTopZ:boostTxt1];
    //--------------------------------
    SKLabelNode* boostTxt2    = [SKLabelNode labelNodeWithText:@"BOOSTS"];
    boostTxt2.fontName = kFONT_MENU;
    boostTxt2.fontColor             = SKColor3(233, 192, 0);
    if (iPhone3) { boostTxt2.scale = 0.50f; }
    if (IS_IPAD) { boostTxt2.position = ccpAdd(brownBG2.position, ccp(boostTxt2.frame.size.width*0.50f, brownBG2.frame.size.height*0.30f)); }
    else         { boostTxt2.position = ccpAdd(brownBG2.position, ccp(boostTxt2.frame.size.width*0.40f, brownBG2.frame.size.height*0.30f)); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostTxt2.scale = 1.0;
    }
    [self addChildToTopZ:boostTxt2];
    //--------------------------------
    SKLabelNode* boostTxt3    = [SKLabelNode labelNodeWithText:@"BOOSTS"];
    boostTxt3.fontName = kFONT_MENU;
    boostTxt3.fontColor             = SKColor3(233, 192, 0);
    if (iPhone3) { boostTxt3.scale = 0.50f; }
    if (IS_IPAD) { boostTxt3.position = ccpAdd(brownBG3.position, ccp(boostTxt3.frame.size.width*0.50f, brownBG3.frame.size.height*0.30f)); }
    else         { boostTxt3.position = ccpAdd(brownBG3.position, ccp(boostTxt3.frame.size.width*0.40f, brownBG3.frame.size.height*0.30f)); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostTxt3.scale = 1.0;
    }
    [self addChildToTopZ:boostTxt3];
    //--------------------------------
    SKLabelNode* boostTxt4    = [SKLabelNode labelNodeWithText:@"BOOSTS"];
    boostTxt4.fontName = kFONT_MENU;
    boostTxt4.fontColor             = SKColor3(233, 192, 0);
    if (iPhone3) { boostTxt4.scale = 0.50f; }
    if (IS_IPAD) { boostTxt4.position = ccpAdd(brownBG4.position, ccp(boostTxt4.frame.size.width*0.50f, brownBG4.frame.size.height*0.30f)); }
    else         { boostTxt4.position = ccpAdd(brownBG4.position, ccp(boostTxt4.frame.size.width*0.40f, brownBG4.frame.size.height*0.30f)); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostTxt4.scale = 1.0;
    }
    [self addChildToTopZ:boostTxt4];
    //--------------------------------
    
    /////// ADD BOOST AMOUNT //////
    
    //--------------------------------
    boostNumber  = [SKLabelNode labelNodeWithText:@""];
    boostNumber.fontName = kFONT_BUY_TXT;
    boostNumber.fontColor           = SKColor3(233, 192, 0);
    if (iPhone3) { boostNumber.scale = 0.70f; }
    if (IS_IPAD) { boostNumber.position = ccp(boostTxt1.position.x - boostTxt1.frame.size.width*0.80f, boostTxt1.position.y - boostTxt1.frame.size.height*0.4f); }
    else         { boostNumber.position = ccp(boostTxt1.position.x - boostTxt1.frame.size.width*0.70f, boostTxt1.position.y - boostTxt1.frame.size.height*0.1f); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostNumber.scale = 1.50;
    }
    [self addChildToTopZ:boostNumber];
    //--------------------------------
    boostNumber2 = [SKLabelNode labelNodeWithText:@""];
    boostNumber2.fontName = kFONT_BUY_TXT;
    boostNumber2.fontColor          = SKColor3(233, 192, 0);
    if (iPhone3) { boostNumber2.scale = 0.70f; }
    if (IS_IPAD) { boostNumber2.position = ccp(boostTxt2.position.x - boostTxt2.frame.size.width*0.80f, boostTxt2.position.y - boostTxt1.frame.size.height*0.4f); }
    else         { boostNumber2.position = ccp(boostTxt2.position.x - boostTxt2.frame.size.width*0.70f, boostTxt2.position.y - boostTxt1.frame.size.height*0.1f); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostNumber2.scale = 1.5;
    }
    [self addChildToTopZ:boostNumber2];
    //--------------------------------
    boostNumber3 = [SKLabelNode labelNodeWithText:@""];
    boostNumber3.fontName = kFONT_BUY_TXT;
    boostNumber3.fontColor          = SKColor3(233, 192, 0);
    if (iPhone3) { boostNumber3.scale = 0.70f; }
    if (IS_IPAD) { boostNumber3.position = ccp(boostTxt3.position.x - boostTxt3.frame.size.width*0.80f, boostTxt3.position.y - boostTxt1.frame.size.height*0.4f); }
    else         { boostNumber3.position = ccp(boostTxt3.position.x - boostTxt3.frame.size.width*0.70f, boostTxt3.position.y - boostTxt1.frame.size.height*0.1f); }
    if (boostNumber3) {
        boostNumber3.scale = 1.5;
    }
    [self addChildToTopZ:boostNumber3];
    //--------------------------------
    boostNumber4 = [SKLabelNode labelNodeWithText:@""];
    boostNumber4.fontName = kFONT_BUY_TXT;
    boostNumber4.fontColor          = SKColor3(233, 192, 0);
    if (iPhone3) { boostNumber4.scale = 0.70f; }
    if (IS_IPAD) { boostNumber4.position = ccp(boostTxt4.position.x - boostTxt4.frame.size.width*0.80f, boostTxt4.position.y - boostTxt1.frame.size.height*0.4f); }
    else         { boostNumber4.position = ccp(boostTxt4.position.x - boostTxt4.frame.size.width*0.70f, boostTxt4.position.y - boostTxt1.frame.size.height*0.1f); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostNumber4.scale = 1.5;
    }
    [self addChildToTopZ:boostNumber4];
    //--------------------------------
}

-(void) addBoostPrices
{
    priceLabel1  = [SKLabelNode labelNodeWithText:@""];
    priceLabel1.fontName = kFONT_BUY_TXT;
    priceLabel1.fontColor           = SKColor3(255, 255, 255);
    if (iPhone3) { priceLabel1.scale = 0.80f; }
    priceLabel1.position        = ccp(buyButton1.position.x, brownBG1.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel1.scale = 1.5;
    }
    [self addChildToTopZ:priceLabel1];
    
    priceLabel2  = [SKLabelNode labelNodeWithText:@""];
    priceLabel2.fontName = kFONT_BUY_TXT;
    priceLabel2.fontColor           = SKColor3(255, 255, 255);
    if (iPhone3) { priceLabel2.scale = 0.80f; }
    priceLabel2.position        = ccp(buyButton2.position.x, brownBG2.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel2.scale = 1.5;
    }
    [self addChildToTopZ:priceLabel2];
    
    priceLabel3  = [SKLabelNode labelNodeWithText:@""];
    priceLabel3.fontName = kFONT_BUY_TXT;
    priceLabel3.fontColor           = SKColor3(255, 255, 255);
    if (iPhone3) { priceLabel3.scale = 0.80f; }
    priceLabel3.position        = ccp(buyButton3.position.x, brownBG3.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel3.scale = 1.5;
    }
    [self addChildToTopZ:priceLabel3];
    
    priceLabel4  = [SKLabelNode labelNodeWithText:@""];
    priceLabel4.fontName = kFONT_BUY_TXT;
    priceLabel4.fontColor           = SKColor3(255, 255, 255);
    if (iPhone3) { priceLabel4.scale = 0.80f; }
    priceLabel4.position        = ccp(buyButton4.position.x, brownBG4.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel4.scale = 1.5;
    }
    [self addChildToTopZ:priceLabel4];
}

-(void) changeBoostsPrices
{
    ////////////////////////// CHANGE PRICES //////////////////////////
    if      (BOOSTx2) { [priceLabel1 setText:@"$1.99"];  [priceLabel2 setText:@"$2.99"];  [priceLabel3 setText:@"$3.99"];   [priceLabel4 setText:@"$4.99"];  }
    else if (BOOSTx3) { [priceLabel1 setText:@"$2.99"];  [priceLabel2 setText:@"$4.99"];  [priceLabel3 setText:@"$6.99"];   [priceLabel4 setText:@"$8.99"];  }
    else if (BOOSTx4) { [priceLabel1 setText:@"$6.99"];  [priceLabel2 setText:@"$8.99"];  [priceLabel3 setText:@"$14.99"];  [priceLabel4 setText:@"$19.99"]; }
    else if (BOOSTx5) { [priceLabel1 setText:@"$14.99"]; [priceLabel2 setText:@"$24.99"]; [priceLabel3 setText:@"$34.99"];  [priceLabel4 setText:@"$49.99"]; }
    
    ////////////////////////// CHANGE AMOUNT //////////////////////////
    if      (BOOSTx2) { [boostNumber setText:@"20"];  [boostNumber2 setText:@"40"];  [boostNumber3 setText:@"60"];   [boostNumber4 setText:@"80"];  }
    else if (BOOSTx3) { [boostNumber setText:@"20"];  [boostNumber2 setText:@"40"];  [boostNumber3 setText:@"80"];   [boostNumber4 setText:@"100"]; }
    else if (BOOSTx4) { [boostNumber setText:@"40"];  [boostNumber2 setText:@"80"];  [boostNumber3 setText:@"100"];  [boostNumber4 setText:@"120"]; }
    else if (BOOSTx5) { [boostNumber setText:@"80"];  [boostNumber2 setText:@"100"]; [boostNumber3 setText:@"150"];  [boostNumber4 setText:@"250"]; }
}

///////////////////////////////////////////////////////////////////////////////////


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    framePressed    = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"boost_buy_active"]];
    closeFrame      = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"menuBTN_close_active"]];
    
    
    SKNode* touchedNode = [self nodeFromTouches:touches];
    
    
    if ([touchedNode isEqualToNode: closeBtn])
    {
        [AUDIO playEffect:s_click1];
        [closeBtn setTexture:closeFrame];
    }
    
    else if ([touchedNode isEqualToNode: coinsBtn])
    {
        [AUDIO playEffect:s_click1];
    }
    
    else if ([touchedNode isEqualToNode: boostBtn])
    {
        [AUDIO playEffect:s_click1];
    }
    /////////////////////////////////////////////////////////////////
    else if ([touchedNode isEqualToNode: buyBSelect1])
    {
        [AUDIO playEffect:s_click1];
    }
    
    else if ([touchedNode isEqualToNode: buyBSelect2])
    {
        [AUDIO playEffect:s_click1];
    }
    
    else if ([touchedNode isEqualToNode: buyBSelect3])
    {
        [AUDIO playEffect:s_click1];
    }
    
    else if ([touchedNode isEqualToNode: buyBSelect4])
    {
        [AUDIO playEffect:s_click1];
    }
    /////////////////////////////////////////////////////////////////
    else if ([touchedNode isEqualToNode: buyButton1])
    {
        [AUDIO playEffect:s_click1];
        [buyButton1 setTexture:framePressed];
        [self purchase:1];
    }
    
    else if ([touchedNode isEqualToNode: buyButton2])
    {
        [AUDIO playEffect:s_click1];
        [buyButton2 setTexture:framePressed];
        [self purchase:2];
    }
    
    else if ([touchedNode isEqualToNode: buyButton3])
    {
        [AUDIO playEffect:s_click1];
        [buyButton3 setTexture:framePressed];
        [self purchase:3];
    }
    
    else if ([touchedNode isEqualToNode: buyButton4])
    {
        [AUDIO playEffect:s_click1];
        [buyButton4 setTexture:framePressed];
        [self purchase:4];
    }
}

-(void)purchase:(int)boostNR
{
    if (BOOSTx2) {
        if(boostNR == 1)        {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST2X_1_99 parent:self];}
        else if (boostNR == 2)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST2X_2_99 parent:self];}
        else if (boostNR == 3)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST2X_3_99 parent:self];}
        else if (boostNR == 4)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST2X_4_99 parent:self];}
    }
    else if (BOOSTx3)
    {
        if(boostNR == 1)        {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST3X_2_99 parent:self];}
        else if (boostNR == 2)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST3X_4_99 parent:self];}
        else if (boostNR == 3)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST3X_6_99 parent:self];}
        else if (boostNR == 4)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST3X_8_99 parent:self];}
    }
    else if (BOOSTx4)
    {
        if(boostNR == 1)        {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST4X_6_99 parent:self];}
        else if (boostNR == 2)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST4X_8_99 parent:self];}
        else if (boostNR == 3)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST4X_14_99 parent:self];}
        else if (boostNR == 4)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST4X_19_99 parent:self];}
    }
    else if (BOOSTx5)
    {
        if(boostNR == 1)        {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST5X_14_99 parent:self];}
        else if (boostNR == 2)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST5X_24_99 parent:self];}
        else if (boostNR == 3)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST5X_34_99 parent:self];}
        else if (boostNR == 4)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST5X_49_99 parent:self];}
    }
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    closeFrame = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"menuBTN_close"]];
    [closeBtn setTexture:closeFrame];
    
    frameNotPressed    = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"boost_buy"]];
    [buyButton1 setTexture:frameNotPressed];
    [buyButton2 setTexture:frameNotPressed];
    [buyButton3 setTexture:frameNotPressed];
    [buyButton4 setTexture:frameNotPressed];
    
    SKNode* touchedNode = [self nodeFromTouches:touches];
    
    if ([touchedNode isEqualToNode: closeBtn])
    {
        [self closeWindow];
         //[AUDIO playEffect:s_click1];
       // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    else if ([touchedNode isEqualToNode: coinsBtn] || [touchedNode isEqualToNode:coinsLabel])
    {
       //  [AUDIO playEffect:s_click1];
     //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        boostBtn.hidden = YES;
        coinsBtn.hidden = YES;
        [self changeWindow];
    }
    
    else if ([touchedNode isEqualToNode: boostBtn])
    {
        
    }
    
    else if ([touchedNode isEqualToNode: buyBSelect1])
    { 
        BOOSTx2 = true; BOOSTx3 = false; BOOSTx4 = false; BOOSTx5 = false;
        [self changeSelectedBGposition];
        [self changeBoostsPrices];
        
    }
    
    else if ([touchedNode isEqualToNode: buyBSelect2])
    {
        BOOSTx2 = false; BOOSTx3 = true; BOOSTx4 = false; BOOSTx5 = false;
        [self changeSelectedBGposition];
        [self changeBoostsPrices];
    }
    
    else if ([touchedNode isEqualToNode: buyBSelect3])
    {
        BOOSTx2 = false; BOOSTx3 = false; BOOSTx4 = true; BOOSTx5 = false;
        [self changeSelectedBGposition];
        [self changeBoostsPrices];
    }
    
    else if ([touchedNode isEqualToNode: buyBSelect4])
    {
        BOOSTx2 = false; BOOSTx3 = false; BOOSTx4 = false; BOOSTx5 = true;
        [self changeSelectedBGposition];
        [self changeBoostsPrices];
    }
    
}


-(void) changeWindow
{
    
#warning EF check parent
    if ([self.parent isKindOfClass:[BuyCoinsWindow class]])
    {
        [self.parent performSelector:@selector(closeBoostsWindow) withObject:nil];
    }
}

-(void) closeWindow
{
    SKAction* scale = [SKAction scaleTo:0.1 duration:0.2];
    SKAction* removeFromParent = [SKAction removeFromParent];
#warning EF check parent
    if ([self.parent isKindOfClass:[PopupManager class]])
    {
        [(PopupManager *)self.parent removeBlackBG];
    }
    else if ([self.parent isKindOfClass:[BuyCoinsWindow class]])
    {
        [(BuyCoinsWindow *)self.parent closeWindow];
        [self runAction:[SKAction sequence:@[scale, removeFromParent]]];
    }

}

@end

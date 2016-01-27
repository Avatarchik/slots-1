#import "PopupManager.h"
#import "cfg.h"
#import "Constants.h"
#import "SettingsWindows.h"
#import "PayTableWindow.h"
#import "BuyCoinsWindow.h"
#import "BottomMenu.h"
#import "TopMenu.h"
#import "BuyBoostsWindow.h"
#import "WinsWindow.h"
#import "NewLevelWindow.h"
#import "SlotMachine.h"
#import "Menu.h"
#import "AppDelegate.h"
#import "SKNode+SKNode_Extensions.h"

@interface PopupManager()

@property (nonatomic, strong) SKShapeNode* blackBG;

@end

@implementation PopupManager

-(id)initWithRect:(CGRect)rect
{
    if((self = [super init]))
    {
        self.name = kNodePopupManager;
        self.position       = rect.origin;
        self.size    = rect.size;
    }
    return self;
}

-(void)setUp:(int) PopWindowNR someValue:(int)value_
{
    switch (PopWindowNR)
    {
        case kWindowSettings:       [self openSettingsWindow];
            break;
            
        case kWindowPayTable:       [self openPayTableWindow];
            break;
            
        case kWindowBuyCoins:       [self openBuyWindow_from:1];
            break;
            
        case kWindowBigWin:  
            break;
            
        case kWindowNewMachine:  
            break;
            
        case kWindowSpecialBonus:   [self openSBonusWindow];
            break;
            
        case kWindowNotEnoughCoins: 
            break;
            
        case kWindowBuyBoosts:      [self openBuyWindow_from:2];
            break;
            
        case kWindowWin:            [self openWinWindow_withWin:value_];
            break;
            
        case kWindowNewLevel:       [self openNewLvlWindow_withLVL:value_];
            break;
            
        default:
            break;
    }
}

-(void) addBlackBackground
{
    self.blackBG = [SKShapeNode shapeNodeWithRect:CGRectMake(0,0,kWidthScreen,kHeightScreen)];
    self.blackBG.fillColor = [SKColor blackColor];
    self.blackBG.alpha = 0.0;
    [self addChildToTopZ:self.blackBG];
    [self.blackBG runAction:[SKAction fadeAlphaTo:0.2 duration:0.2]];
}

//////////////////////////////////////// OPEN WINDOWS ///////////////////////////////////////////
-(void) openSettingsWindow
{
    self.name = kNodeSettings;
    if (btnPressed == false)
    {
         [AUDIO playEffect:s_click1];
        [self addBlackBackground];
        btnPressed = true;
        SettingsWindows *SWindow = [[SettingsWindows alloc] init];
        SWindow.anchorPoint = ccp(0.5f, 0.5f);
        SWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChildToTopZ:SWindow];
        
#warning EF make sure this works the self.parent.parent crap
        if ([self.parent.parent isKindOfClass:[Menu class]]) {
            [SWindow setUp:2];
        }
        else if ([self.parent.parent isKindOfClass:[SlotMachine class]])
        {
            [SWindow setUp:1];
        }
        
    }
    else { }
}

-(void) openPayTableWindow
{
    self.name = kNodePayTable;
    if (btnPressed == false)
    {
        // [AUDIO playEffect:s_click1];
        [self addBlackBackground];
        btnPressed = true;
        //NSLog(@"%@",_parent.parent);
        #warning EF
//        int machineNum = [(SlotMachine *)_parent.parent resumeMachineNum];
//        PayTableWindow *PWindow = [[[PayTableWindow alloc] init_withMachineNR:machineNum] autorelease];
//        PWindow.anchorPoint = ccp(0.5f, 0.5f);
//        PWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
//        [self addChild:PWindow z:14 tag:kPayWindowTAG];
    }
    else { }
}

-(void) openBuyWindow_from:(int)nr_
{
    self.name = kNodeBuyWindow;
    if (btnPressed == false)
    {
         //[AUDIO playEffect:s_click1];
        [self addBlackBackground];
        btnPressed = true;
         BuyCoinsWindow *BWindow = [[BuyCoinsWindow alloc] init_WithNumber:nr_];
        BWindow.anchorPoint = ccp(0.5f, 0.5f);
        BWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
#warning EF
//        if (nr_ == 1) { [self addChild:BWindow z:16 tag:kBuyWindowTAG]; }
//        if (nr_ == 2) { [self addChild:BWindow z:16 tag:kBooWindowTAG]; }
    }
    else { }
}


-(void) openWinWindow_withWin:(int)win_
{
    if (btnPressed == false)
    {
         //[AUDIO playEffect:s_click1];
        btnPressed = true;
        WinsWindow *WWindow = [[WinsWindow alloc] init_with_WIN:win_ type:1];
        WWindow.anchorPoint = ccp(0.5f, 0.5f);
        WWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
#warning EF
//        [self addChild:WWindow z:14 tag:kWinWindowTAG];
    }
    else { }
}

-(void) openNewLvlWindow_withLVL:(int)level_
{
    if (btnPressed == false)
    {
         //[AUDIO playEffect:s_click1];
        btnPressed = true;
        NewLevelWindow *NWindow = [[NewLevelWindow alloc] init_with_LVL:level_];
        NWindow.anchorPoint = ccp(0.5f, 0.5f);
        NWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
#warning EF
//        [self addChild:NWindow z:14 tag:kNewWindowTAG];
    }
    else { }
}


/////////////////////////// SPECIAL BONUS ////////////////////////
-(void) openSBonusWindow
{
    if (btnPressed == false)
    {
        btnPressed = true;
        
        BonusMenu               = [[SpecialBonus alloc] initWithRect:CGRectMake(0, kHeightScreen * 0.2f, kWidthScreen, kHeightScreen * 0.2f) kProgress:kProgress1 bonusValue:500];
        BonusMenu.anchorPoint   = ccp(0,0);
        BonusMenu.position      = ccp(BonusMenu.position.x, kHeightScreen - kHeightScreen*1.3f);
        [self addChildToTopZ:BonusMenu];
        
        [(AppDelegate *)[[UIApplication sharedApplication] delegate]setSPECIALBONUS:BonusMenu];
        
#warning EF Spring animated this up from the bottom of the screen
            BonusMenu.position = CGPointMake(BonusMenu.position.x, 0);
//        [BonusMenu runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.15f],[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.1f position:ccp(BonusMenu.position.x, IS_IPAD ? 30    :   15)] rate:1.5f],[CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:0.07f position:ccp(0, IS_IPAD ? -44    :   -22)] rate:1.0f],[CCEaseInOut actionWithAction:[CCMoveBy actionWithDuration:0.1f position:ccp(0, IS_IPAD ? 14    :   7)] rate:1.5f], nil]];
        
        
    }
    else { }
}


-(SpecialBonus*)GET_SPECIALBONUS{
    
    if (BonusMenu!=nil)
    {
        return BonusMenu;
    }
    NSLog(@"Warinign ! No bonus alloced");
    return nil;
    
}

-(void) hideSBonusWindow
{
    [BonusMenu runAction:[CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.5f position:ccp(BonusMenu.position.x, kHeightScreen - kHeightScreen*1.3f)] rate:1]];
}

-(void)removeBlackBG
{
    #warning EF
//    [[self getChildByTag:kBlackBackgroundTAG] runAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.2f opacity:0],[CCCallBlock actionWithBlock:^{
//        [[self getChildByTag:kBlackBackgroundTAG] removeFromParentAndCleanup:YES];
//    }], nil]];
}
///////////////////////////////////////////////////////////////////

//////////////////////////////////////// CLOSe WINDOWS ///////////////////////////////////////////
-(void) closeSettingsWindow
{
    //[self removeBlackBG];
    #warning EF
//    [self removeChild:(SettingsWindows *)[self getChildByTag:kSetWindowTAG] cleanup:YES];
//    [_parent performSelector:@selector(closeWindowSet) withObject:nil];
//    btnPressed = false;
}

-(void) closePayTableWindow
{
    #warning EF
//    [self removeChild:(SettingsWindows *)[self getChildByTag:kBlackBackgroundTAG] cleanup:YES];
//    [self removeChild:(PayTableWindow *)[self getChildByTag:kPayWindowTAG] cleanup:YES];
//    [_parent performSelector:@selector(closeWindowPay) withObject:nil];
    btnPressed = false;
}

-(void) closeBuyWindow
{
    #warning EF
    //[self removeChild:(SettingsWindows *)[self getChildByTag:kBlackBackgroundTAG] cleanup:YES];
//    [self removeChild:(BuyCoinsWindow *)[self getChildByTag:kBuyWindowTAG] cleanup:YES];
//    [(TopMenu *) _parent closeWindowBuy]; 

    btnPressed = false;
}

-(void) closeWinWindow
{
    #warning EF
//    [self removeChild:(PayTableWindow *)[self getChildByTag:kWinWindowTAG] cleanup:YES];
//    [(TopMenu *) _parent closeWindowWin];
    btnPressed = false;
}

-(void) closeLvlWindow
{
    #warning EF
//    [self removeChild:(PayTableWindow *)[self getChildByTag:kNewWindowTAG] cleanup:YES];
//    [(TopMenu *) _parent closeWindowLvl];
    btnPressed = false;
}

-(void) closeUseBoostWindow
{
    #warning EF
//    [_parent performSelector:@selector(closeBUseWindow) withObject:nil];
}








@end

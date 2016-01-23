#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LevelHelperLoader.h"
#import <SpriteKit/SpriteKit.h>
#import "PopupManager.h"

@interface TopMenu : SKSpriteNode
{
    
    int sizee; //just for testing
    
    float coins_;
    float win_;
    int level_;
    float exp_;
    float final_coins;
    
    float counter;
    int soundloop;
    
    CGRect buyButton_Rect;
    CGRect settingsButton_Rect;
    CGRect paytableButton_Rect;
    
    int menuType;
    
    float progress_value;
    float next_level_value;
    float percent_to_scale;
    float scaleXsize;
    
    int   fSize;
    float lHeight;
    
    CCLabelBMFont *levelLabel;
    CCLabelBMFont *expLabel;
    CCLabelBMFont *coinsLabel;
    CCLabelBMFont *winLabel;
    
    CCProgressTimer *_progress;

    BOOL openSett;
    BOOL openPay;
    BOOL gamePlay;
    BOOL bgMusic;
    BOOL openWind;
    
    PopupManager *BWindow;
    bool buttonActive;
    bool coinDropAnim;
    BOOL iPhone3;
}

-(id)   initWithRect:(CGRect)rect type:(int)TYPE experience:(int)EXP coins:(float)COINS;
-(void) progressNumber:(float)progress_number scale:(bool)bool_;
-(void) closeSettingsWindow;

-(void) closeWindowSet;
-(void) closeWindowPay;
-(void) closeWindowBuy;

-(void) openBuyWindow;
-(void) closeWheelGame;
-(void) closeCardGame;
-(void) closeWindowWin;
-(void) closeWindowLvl;
-(void) Pause_Play_BackgroundMusic;
-(void) musicStatus:(int)mSTATUS soundsStatus:(int)sSTATUS;


-(void) activeButtons:(bool)bool_;
-(void) addCoins:(float)coinsValue;
-(void) minusCoins:(float)coins;
-(void) addLastWin:(float)winValue;
-(void) addLevelNr:(int)levelValue;
-(void) addExpValue:(float)expValue scale:(bool)bool_;
-(void) openBuyWindow_withNR:(NSNumber *)nr_;
@end

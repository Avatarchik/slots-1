#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TopMenu.h"
#import <SpriteKit/SpriteKit.h>

@interface SettingsWindows : SKSpriteNode
{
    CCSpriteBatchNode *SETTINGS_MENU_;
    
    BOOL B1on;
    BOOL B2on;
    BOOL B3on;
    BOOL onAbout;
    
    int state__;
    
    BOOL b1;
    BOOL b2;
    BOOL b3;
    BOOL b4;
    BOOL b5;
    BOOL b6;
    BOOL b7;
    
    BOOL iPhone3;

}

-(void)setUp:(int)state;
-(void)closeSettingsWindow2;
-(void)saveSoundInfo;


@end


#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "cfg.h"
#import "Constants.h"
#import <SpriteKit/SpriteKit.h>

@interface BuyCoinsWindow : SKSpriteNode
{
    int fSizeBUY;
    int fSizeBUTTONS;
    
    int coinsAmount1;
    int coinsAmount2;
    int coinsAmount3;
    int coinsAmount4;
    int coinsAmount5;
    int coinsAmount6;
    
    int bonusP1;
    int bonusP2;
    int bonusP3;
    int bonusP4;
    int bonusP5;
    int bonusP6;
    
    int fCoinsAmount1;
    int fCoinsAmount2;
    int fCoinsAmount3;
    int fCoinsAmount4;
    int fCoinsAmount5;
    int fCoinsAmount6;

    float dis_;
    

    
    BOOL iPhone3;
}

-(void) closeWindow;
-(void) closeBoostsWindow;

-(id)init_WithNumber:(int) nr_;


@end

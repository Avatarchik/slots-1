#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <SpriteKit/SpriteKit.h>

enum states_{
    
    state_connected         = 1,
    state_notconnected      = 2,
    state_canTakeBonus      = 3,
    state_waitingForbonus   = 4,
    state_connectionError   = 5,
    state_connecting        = 6,
    
};

@interface SpecialBonus : SKSpriteNode <UIAlertViewDelegate>
{
 
    CCSpriteBatchNode   *SPEC_BONUS;
    
    int coins;
    

    
    BOOL b1;
}

-(id)initWithRect:(CGRect)rect kProgress:(int)progress_ bonusValue:(int)bonus_;

-(void) reedemCoinReward;
//custom

-(void)UPDATE_ME;
-(void) updateBonusLabel;

@end

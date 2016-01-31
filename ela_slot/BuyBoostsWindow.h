#import "cfg.h"
#import "Constants.h"

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <SpriteKit/SpriteKit.h>

@interface BuyBoostsWindow : SKSpriteNode
{
    
    int fSizeBUY;
    int fSizeBUTTONS;
    
    BOOL    BOOSTx2;
    BOOL    BOOSTx3;
    BOOL    BOOSTx4;
    BOOL    BOOSTx5;
    
    BOOL    iPhone3;
    
}
-(id)initWithBool:(bool)bool_;
-(void)purchase:(int)boostNR;
@end

//
//  Reel.m
//  EarlyLearningAcademy
//
//  Created by Eddy Fan on 2/1/16.
//  Copyright © 2016 Fantapstic Studio. All rights reserved.
//

#import "Reel.h"
#import "cfg.h"
#import "SKNode+SKNode_Extensions.h"
#import "ReelSymbolNode.h"
#import "Slots_Animation.h"

#define kIconRect_iPad CGRectMake(0,0,120,120)
#define kIconRect_iPhone CGRectMake(0,0,55,40)
//#define REEL_SYMBOLS [NSArray arrayWithObjects: kA,kK,kQ,kJ,k10,kICON1,kICON2,kICON3,kICON4,kWILD,kSCATER,kBONUS, nil]



typedef NS_ENUM (NSInteger, ReelLayer)
{
    ReelLayerReel,
    ReelLayerSymbol
};

static NSString* const kActionReelName = @"kActionReelName";

@implementation Reel

-(BOOL)isReelRunning{
    return NO;
}

- (instancetype)initWithSpriteSize:(CGSize) size
{
    self = [super init];
    if (self) {
        // Create sprite container
        _reelSprite= [SKSpriteNode new];
        _reelSprite.size = size;
        
        //TODO: parameterize this if needed
        [self addSymbols:12];
        
    }
    return self;
}

-(void)resetWinSymbols{
    
}



-(void) addSymbols:(NSUInteger) count
{
    #warning EF move this into a constant or define
    NSArray* reelSymbols = [NSArray arrayWithObjects: kA,kK,kQ,kJ,k10,kICON1,kICON2,kICON3,kICON4,kWILD,kSCATER,kBONUS, nil];
    
    //for the reel, add 'count' random icons
    for (NSInteger i = 0; i<count; i++) {
        
        // Create a random reel name.
        NSUInteger randomSymbolIndex = [self INT_MyRandomIntegerBetween:0 max: 11];
        NSString* reelImageName = [NSString stringWithFormat:@"%@.png",[reelSymbols objectAtIndex: randomSymbolIndex]];
        
        #warning EF change this to use textures, cached textures.
        // Create a symbol.
        ReelSymbolNode* sprite = [ReelSymbolNode spriteNodeWithImageNamed:reelImageName];
        sprite.symbolIndex = i;
        
        #warning EF wtf is this??
        sprite.position = CGPointMake(_reelSprite.size.width/2,((_reelSprite.size.height/3 - sprite.size.height))/2 + (_reelSprite.size.height/3 * i));

        // Add symbol to reel.
        [_reelSprite addChildToTopZ:sprite];
    }
}



-(void) addWinReel{
    _winReelSprite = [SKSpriteNode new];
    _winReelSprite.size = _reelSprite.size;
    _winReelSprite.anchorPoint = CGPointZero;
    _winReelSprite.position = CGPointMake(_reelSprite.position.x, _reelSprite.position.y + _reelSprite.size.height);
    
    
#warning EF
    NSArray* randome = nil;
    
    // slots are 5 x 3;
    for (NSInteger i = 0; i<3; i++) {
        
        
        
          Slots_Animation *sAnim = [[Slots_Animation alloc]initWithFrame:CGRectMake(0, 0, 0, 0) node: self.reelSprite machineNr:1 iconNr:l elements:randome];
          sAnim.position = ccp(_reelSprite.size.width/2,((_reelSprite.size.height/3 - sAnim.size.height))/2 + (kHEIGHT_OF_LITTLE_BG.size.height/3 * i));
          [_winReelSprite addChild:sAnim z:5 tag:slotAnimationTag];
          
          
          slotAnimationTag -= 1;
      }
}




    
#error EF port this to SK
//    // set size of the slotAnimationHolder to the width of the first reel, and heigh to the little bg.
//    slotAnimationHolder.contentSize = CGSizeMake([self getChildByTag:kTAG_OF_REEL].contentSize.width, kHEIGHT_OF_LITTLE_BG.size.height);
//    slotAnimationHolder.anchorPoint = ccp(0, 0);
//    slotAnimationHolder.position = ccp(reel.position.x, reel.position.y + kHEIGHT_OF_REEL);
////    [self addChild:slotAnimationHolder z:10 tag:(kTAG_OF_WIN_REELS+j) -1];
//    
//    for (int i = 0; i<3; i++) {
//        
//        Slots_Animation *sAnim = [[[Slots_Animation alloc]initWithFrame:CGRectMake(0, 0, 0, 0) node:self machineNr:1 iconNr:l elements:randome];
//                                  sAnim.anchorPoint = ccp(0.5f, 0.5f);
//                                  sAnim.position = ccp(reel.contentSize.width/2,((kHEIGHT_OF_LITTLE_BG.size.height/3 - sAnim.contentSize.height))/2 + (kHEIGHT_OF_LITTLE_BG.size.height/3 * i));
//                                  [slotAnimationHolder addChild:sAnim z:5 tag:slotAnimationTag];
//                                  
//                                  
//                                  slotAnimationTag -= 1;
//                                  }
//    
    
}


// Returns reel action if it exists.
-(SKAction*) getReelAction{
    SKAction* reelAction = [self.reelSprite actionForKey:kActionReelName];
    return reelAction;
}

-(void) stopReel{
    
    SKAction* reelAction = [self getReelAction];
#warning EF do the win reel action as well.
//    SKAction* winReelAction = [self getWinReelAction];
    
    if(reelAction)
    {
        [reelAction setSpeed:5.0];
    }
    
//    CCSprite *reel_ = (CCSprite *)[self getChildByTag:kTAG_OF_REEL+k];
//    CCSpeed *sp = (CCSpeed *)[reel_ getActionByTag:kTAG_OF_REEL+k];
//    CCSpeed *sp2 = (CCSpeed *)[[self getChildByTag:(kTAG_OF_WIN_REELS + reel_.tag) - 50] getActionByTag:kTAG_OF_WIN_REEL_ACTION + (kTAG_OF_REEL+k)];
//    
//    if (sp) {
//        [sp setSpeed:5.f];
//        [sp2 setSpeed:5.f];
//    }
}


-(void)stopAllAnimations
{
//    for (int j = 1; j<=5; j++) {
//        
//        int l = 3 * j;
//        
//        //get win reel reference
//        CCSprite *s = (CCSprite *)[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1];
//        
//        
//        // stop its slot animation;
//        for (int i = 0; i<3; i++) {
//            Slots_Animation *sAnim = (Slots_Animation *)[s getChildByTag:l];
//            [sAnim stopAllAnimation];
//            l -= 1;
//        }
//    }
}

-(void)reelRun
{
    if (!self.isReelRunning)
    {
        CGFloat randomActionDuration = [self randomYStop];
        SKAction* reelSwipeDownAnimation = [self reelSwipeDownAnimation:self.reelSprite duration:randomActionDuration];
        [self.reelSprite runAction:reelSwipeDownAnimation withKey:kActionReelName];
        
//        [self reelSwipeDownAnimation:nod e_ name:node_.name duration:randomYStop];
//        [node_ runAction:reelSwipeDownAnimation withKey:node_.name];
        // Run action on symbols as well as reels.
        
    #warning EF get win reel and run action
        // Create reel run aciton
//        [[self getChildByTag:(kTAG_OF_WIN_REELS + node_.tag) - 50] runAction:[self reelSwipeDownAnimation:node_ tag:kTAG_OF_WIN_REEL_ACTION + node_.tag duration:i]].tag = kTAG_OF_WIN_REEL_ACTION + node_.tag;
    }
}



-(SKAction *)reelSwipeDownAnimation:(SKNode *)node_ duration:(CGFloat)dur_
{
    CGFloat distance = (-_reelSprite.size.height *20);
    
    if (node_.position.y > _reelSprite.position.y) {
        distance = -(_reelSprite.size.height *20 + _reelSprite.size.height);
    }
    
    SKAction* firstDelay        = [SKAction waitForDuration:0.0];
    SKAction* firstMove         = [SKAction moveByX:0 y:distance -(IS_IPHONE ? 40 : 60) duration:dur_];
    SKAction* secondMove        = [SKAction moveByX:0 y:(IS_IPHONE ? 40 : 60) duration:1.0];
    SKAction* delegateFinish    = [SKAction performSelector:@selector(delegateFinish) onTarget:self];
    SKAction* sequence          = [SKAction sequence:@[firstDelay, firstMove, secondMove, delegateFinish]];
    
    return sequence;
}


-(void) delegateFinish{
    if([self.delegate respondsToSelector:@selector(reelDidFinishAnimation:)])
    {
        [self.delegate reelDidFinishAnimation:self];
    }
}

-(CGFloat) randomYStop{
    CGFloat i;
    CGFloat j = [self MyRandomIntegerBetween:2 max:6];
    i =  2.0f + j;
    return i;
}

-(void)update:(NSTimeInterval)dt{
    
}

-(float)MyRandomIntegerBetween:(int)min max:(int)max {
    return (float)( (arc4random() % (max-min+1)) + min )/10;
}

-(int)INT_MyRandomIntegerBetween:(int)min max:(int)max {
    return (float)( (arc4random() % (max-min+1)) + min );
}

-(void)dealloc{
    if(_reelSprite.parent){
        [_reelSprite removeFromParent];
    }
    _reelSprite = nil;
}


@end

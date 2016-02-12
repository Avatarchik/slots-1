//
//  Reel.h
//  EarlyLearningAcademy
//
//  Created by Eddy Fan on 2/1/16.
//  Copyright © 2016 Fantapstic Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@class Reel;
@protocol ReelDelegate <NSObject>
@optional
    -(void) reelDidFinishAnimation:(Reel*) reel;
@end

@interface Reel : NSObject
#warning EF put reel and win reel in 1 sprite?
@property (nonatomic, readonly) SKSpriteNode*    reelSprite;
@property (nonatomic, readonly) SKSpriteNode*    winReelSprite;
@property (nonatomic, weak)     id<ReelDelegate> delegate;

// Reel
-(instancetype)initWithSpriteSize:(CGSize) size;
-(void) resetWinSymbols;
-(void) stopReel;
-(void) reelRun;
-(BOOL) isReelRunning;
-(void) update:(NSTimeInterval) dt;


@end

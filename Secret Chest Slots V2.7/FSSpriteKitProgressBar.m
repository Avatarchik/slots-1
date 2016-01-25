//
//  FSSpriteKitProgressBar.m
//  Secret Chest Slots V2.7
//
//  Created by Eddy Fan on 1/24/16.
//  Copyright © 2016 outlandishappsllc. All rights reserved.
//

#import "FSSpriteKitProgressBar.h"


@implementation FSSpriteKitProgressBar

-(id) initWithSpriteNode:(SKSpriteNode*) spriteNode{
    if (self = [super init]) {
        self.maskNode = [SKSpriteNode spriteNodeWithColor:[SKColor whiteColor] size:spriteNode.size];
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"progressBarImage"];
        [self addChild:spriteNode];
    }
    return self;
}

- (void) setProgress:(CGFloat) progress {
    self.maskNode.xScale = progress;
}

@end
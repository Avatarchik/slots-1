//
//  SKNode+SKNode_Extensions.m
//  Secret Chest Slots V2.7
//
//  Created by Eddy Fan on 1/20/16.
//  Copyright © 2016 outlandishappsllc. All rights reserved.
//

#import "SKNode+SKNode_Extensions.h"

@implementation SKNode (SKNode_Extensions)

-(instancetype) nodeFromTouches:(NSSet<UITouch *> *) touches inParentNode:(SKNode*) parentNode{
    UITouch* touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInNode:parentNode];
    SKNode* node = [self nodeAtPoint:touchPoint];
    return node;
}

-(void) addChild:(SKNode*) child atZPosition:(CGFloat) zPosition{
    child.zPosition = zPosition;
    [self addChild:child];
}

-(void) addChildToTopZ:(SKNode*) child{
    NSInteger count = self.children ? self.children.count : 0;
    CGFloat topZ = count;
    NSLog(@"adding child:%@ to %@  z:%f", child.name, self.name, topZ);
    [self addChild:child atZPosition:topZ];
}
@end

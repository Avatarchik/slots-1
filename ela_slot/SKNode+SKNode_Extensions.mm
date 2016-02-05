//
//  SKNode+SKNode_Extensions.m
//  Secret Chest Slots V2.7
//
//  Created by Eddy Fan on 1/20/16.
//  Copyright © 2016 Fantapstic Studio. All rights reserved.
//

#import "SKNode+SKNode_Extensions.h"

@implementation SKNode (SKNode_Extensions)

-(instancetype) nodeFromTouches:(NSSet<UITouch *> *) touches{
    SKNode* node = [SKNode nodeFromTouches:touches inParentNode:self];
    return node;
}

+(instancetype) nodeFromTouches:(NSSet<UITouch *> *) touches inParentNode:(SKNode*) parentNode{
    UITouch* touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInNode:parentNode];
    SKNode* node = [parentNode nodeAtPoint:touchPoint];
    return node;
    
}

-(void) addChild:(SKNode*) child atZPosition:(CGFloat) zPosition{
    child.zPosition = zPosition;
    [self addChild:child];
}

-(void) addChildToTopZ:(SKNode*) child{
    if(child.parent)
    {
        NSLog(@"child already has parent! - %@  parent: %@", child, child.parent);
        return;
    }
    NSInteger count = self.children ? self.children.count : 0;
    CGFloat topZ = count;
    NSLog(@"adding child:%@ to %@  z:%f", child.name, self.name, topZ);
    [self addChild:child atZPosition:topZ];
}

-(CGFloat) right
{
    return self.position.x + self.frame.size.width * 2;
}

-(CGFloat) top
{
    return self.position.y + self.frame.size.height * 2;
}

-(CGFloat) left
{
    return self.position.x - self.frame.size.width * 2;
}

-(CGFloat) bottom
{
    return self.position.y - self.frame.size.height * 2;
}

@end

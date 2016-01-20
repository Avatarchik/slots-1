//
//  SKNode+SKNode_Extensions.h
//  Secret Chest Slots V2.7
//
//  Created by Eddy Fan on 1/20/16.
//  Copyright © 2016 outlandishappsllc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKNode (SKNode_Extensions)

-(instancetype) nodeFromTouches:(NSSet<UITouch *> *) touches inParentNode:(SKNode*) parentNode;

@end

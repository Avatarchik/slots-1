//
//  Lobby.h
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "GameDevHelper.h"
#import "LevelHelperLoader.h"
#import "SpecialBonus.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

// Lobby
@interface Lobby : SKNode
{
	CCTexture2D *spriteTexture_;	// weak ref
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    
     
    GHSkeleton* skeleton;
    
    CCSpriteBatchNode *BG_;
}

// returns a SKScene that contains the Lobby as the only child
+(SKScene *) scene;

//-(void)closeTopMenu1;

//custom

-(void)UPDATE_SPECIAL_BONUS;

@end
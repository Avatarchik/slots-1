//
//  Lobby.h
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "SpecialBonus.h"

// Lobby
@interface Lobby : SKNode

// returns a SKScene that contains the Lobby as the only child
+(SKScene *) scene;

-(void)UPDATE_SPECIAL_BONUS;

@end

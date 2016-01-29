//
//  Lobby.mm
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//

// Import the interfaces
#import "Lobby.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "Constants.h"
#import "cfg.h"

#import "Menu.h"
#import "b6luxLoadingView.h"
#import "TopMenu.h"


enum {
	kTagParentNode = 1
};


#pragma mark - Lobby

@interface Lobby()
@property (nonatomic, strong) Menu* runMenu;
@end

@implementation Lobby

+(SKScene *) scene
{
    // Create an SKScene with the LobbyNode as a child.
    CGRect window = [[UIScreen mainScreen] bounds];
    SKScene* scene = [SKScene sceneWithSize:window.size];
    
    //Create Lobby node.
    Lobby *lobbyNode = [Lobby node];
    [scene addChild:lobbyNode];
    
	return scene;
}

-(id) init
{
	if( (self=[super init]))
    {
        // Set the name of the node so it can be tracked.
        self.name = kNodeLobby;
        
        // Set ZPosition
        self.zPosition = ZDepthLobby;
        
        // Show loading view.
        [b6luxLoadingView loadingViewWithLoadingType:kLOADING_MACHINE];
        
        /// Add a background Layer
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"sp_background.png"];
        background.position  = CGPointMake(kWidthScreen / 2, kHeightScreen / 2);
#warning EF for test only
//        [self addChild:background];
        [self showRunMenu];
    }
	return self;
}


-(void)UPDATE_SPECIAL_BONUS{
    SpecialBonus *SB = [self.runMenu GET_SPECIAL_BONUS];
    [SB UPDATE_ME];
}

-(void)showRunMenu
{
    /// Create Menu and display.
    self.runMenu = [[Menu alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen) type:1 level:kLEVEL] ;
    self.runMenu.anchorPoint = ccp(0, 0);
    self.runMenu.position    = ccp(0, 0);
    [self addChild:self.runMenu];
}


@end

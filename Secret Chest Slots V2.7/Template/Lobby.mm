//
//  Lobby.mm
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//

// Import the interfaces
#import "Lobby.h"

// Not included in "cocos2d.h"
#import "CCPhysicsSprite.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "Constants.h"
#import "cfg.h"

#import "Menu.h"
#import "b6luxLoadingView.h"
#import "TopMenu.h"


//#define PTM_RATIO_LH [LevelHelperLoader pointsToMeterRatio]

#define kTopMMenuTAG 10

enum {
	kTagParentNode = 1,
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
        
#warning EF -  Create a loading view
        
//        UIView *view__ = [[b6luxLoadingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) loading:kLOADING_MACHINE];
//        view__.tag = kLOADINGTAG;
//        
//        /// present that loading view if one isnt already on screen.
//        if (![[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
//            [[[CCDirector sharedDirector] openGLView]addSubview:view__];
//        }
        
//        BG_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_background.png"]];
//        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_background.plist"]];
//        [self addChild:BG_];
        
        
        
        
        /// Add a background Layer
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"sp_background.png"];
        
        [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"sp_background.png"]];
        background.position  = CGPointMake(kWidthScreen / 2, kHeightScreen / 2);
        [self addChild:background];
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
    #warning EF
    return;
    /// Create Menu and display.
    self.runMenu = [[[Menu alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen) type:1 level:kLEVEL] autorelease];
    self.runMenu.anchorPoint = ccp(0, 0);
    self.runMenu.position    = ccp(0, 0);
//    [self addChild:self.runMenu];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
        
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        if(skeleton){
            
            location.x -= 60;//i substract this so the snake head will not be hidden by the finger when testing on device
            
            [skeleton setPosition:location forBoneNamed:@"UntitledNode_3"];
        }
	}
}

#warning EF
//-(void) onEnter
//{
//    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
//    [super onEnter];
//}

-(void) dealloc
{
	delete world;
	world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}


@end

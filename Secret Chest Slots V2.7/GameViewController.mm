//
//  GameViewController.m
//  SpriteKitSlot
//
//  Created by Eddy Fan on 1/18/16.
//  Copyright (c) 2016 Fantapstic Studio. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "Constants.h"
#import "Lobby.h"
#import "NodeNames.h"
#import "b6luxLoadingView.h"
#import "cfg.h"

@interface GameViewController()
@property (nonatomic, readonly) SKScene* scene;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addDidBecomeActiveNotification];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    SKScene* lobbyScene = [Lobby scene];
    lobbyScene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:lobbyScene];
}

-(SKScene*) scene
{
    SKView* skView = (SKView*)self.view;
    SKScene* scene = skView.scene;
    return scene;
}

-(void)animationLoadingCheck{
    
    BOOL wasRunning = [b6luxLoadingView removeLoadingView];
    // If it was running, create a loading view and display it.
    wasRunning = YES;
    if (wasRunning) {
        [b6luxLoadingView loadingViewWithLoadingType:kLOADING_PURCHASE];
    }
}


/******************************************************
 */
#pragma mark - UIApplicationDidBecomeActiveNotification
/*
 ********************************************************/

-(void) addDidBecomeActiveNotification{
    [self removeDidBecomeActiveNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notif_applicationDidBecomeActive:)     name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void) removeDidBecomeActiveNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void) notif_applicationDidBecomeActive:(NSNotification*) notification{
    [self animationLoadingCheck];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


-(void)dealloc{
    [self removeDidBecomeActiveNotification];
}

@end

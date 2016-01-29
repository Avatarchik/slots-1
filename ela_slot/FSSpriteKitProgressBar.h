//
//  FSSpriteKitProgressBar.h
//  Secret Chest Slots V2.7
//
//  Created by Eddy Fan on 1/24/16.
//  Copyright © 2016 outlandishappsllc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FSSpriteKitProgressBar : SKCropNode

//Usage
/*
FSSpriteKitProgressBar * progressBar = [FSSpriteKitProgressBar new];
[self addChild:progressBar];
// ...

[progressBar setProgress:0.3];
// ...
[progressBar setProgress:0.7];
*/


-(id) initWithSpriteNode:(SKSpriteNode*) spriteNode;
/// Set to a value between 0.0 and 1.0.
- (void) setProgress:(CGFloat) progress;

@end

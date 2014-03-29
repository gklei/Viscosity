//
//  VISCLevelOneScene.m
//  Viscosity
//
//  Created by Gregory Klein on 3/29/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCLevelOneScene.h"

@interface VISCLevelOneScene ()
@property (strong, nonatomic) SKLabelNode* levelOneLabel;
@end

@implementation VISCLevelOneScene

- (id)initWithSize:(CGSize)size
{
   if (self = [super initWithSize:size])
   {
      self.backgroundColor = [SKColor colorWithRed:.3 green:.3 blue:.5 alpha:1];
      [self setupLabel];
   }
   return self;
}

- (void)setupLabel
{
   self.levelOneLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
   CGFloat xPosition = CGRectGetMidX(self.frame);
   CGFloat yPosition = CGRectGetMidY(self.frame);
   self.levelOneLabel.position = CGPointMake(xPosition, yPosition);
   self.levelOneLabel.text = @"Level 1";

   [self addChild:self.levelOneLabel];
}

- (void)didMoveToView:(SKView *)view
{
   SKAction* wait = [SKAction waitForDuration:.5];
   SKAction* fade = [SKAction fadeAlphaTo:0 duration:.5];
   SKAction* waitAndFade = [SKAction sequence:@[wait, fade]];

   [self.levelOneLabel runAction:waitAndFade completion:^
   {
      [self.levelOneLabel removeFromParent];
   }];
}

- (void)update:(NSTimeInterval)currentTime
{
}

@end

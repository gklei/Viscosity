//
//  VISCAnimatingDirectionalNode.m
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCAnimatingDirectionalNode.h"

@implementation VISCAnimatingDirectionalNode

+ (instancetype)directionalNode
{
   VISCAnimatingDirectionalNode* directionalNode = [super directionalNode];
   directionalNode.maskNode = [SKSpriteNode spriteNodeWithImageNamed:@"CircleMask"];
   directionalNode.color = [UIColor blackColor];
   directionalNode.animationDuration = 4;

   return directionalNode;
}

- (void)startFillAnimation
{
   [self.maskNode removeActionForKey:@"scaleUp"];
   [self.maskNode setScale:0];
   SKAction* scaleUp = [SKAction scaleTo:5 duration:self.animationDuration];
   SKAction* wait = [SKAction waitForDuration:.2];
   [self.maskNode runAction:[SKAction sequence:@[wait, scaleUp]] withKey:@"scaleUp"];
}

@end

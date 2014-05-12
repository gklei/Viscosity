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
   directionalNode.maskNode = [SKSpriteNode spriteNodeWithImageNamed:@"circle"];

   return directionalNode;
}

- (void)startFillAnimation
{
   [self.maskNode removeActionForKey:@"scaleUp"];
   [self.maskNode setScale:0];
   SKAction* scaleUp = [SKAction scaleTo:10 duration:2];
   [self.maskNode runAction:scaleUp withKey:@"scaleUp"];
}

@end

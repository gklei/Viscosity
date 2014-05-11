//
//  VISCGoalNode.m
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCGoalNode.h"

@implementation VISCGoalNode

#pragma mark - Class Init Methods
+ (instancetype)goalNodeWithLength:(CGFloat)length angle:(CGFloat)angle
{
   VISCGoalNode* goalNode = [self node];

   CGMutablePathRef pathToDraw = CGPathCreateMutable();
   CGPathMoveToPoint(pathToDraw, NULL, goalNode.position.x, goalNode.position.y);
   CGPathAddLineToPoint(pathToDraw, NULL, goalNode.position.x + length, goalNode.position.y);

   goalNode.path = pathToDraw;
   CGPathRelease(pathToDraw);

   return goalNode;
}

- (void)setPosition:(CGPoint)position
{
   [super setPosition:position];
   self.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:self.path];
}

@end

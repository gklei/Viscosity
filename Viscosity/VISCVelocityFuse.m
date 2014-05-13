//
//  VISCVelocityTrigger.m
//  Viscosity
//
//  Created by Gregory Klein on 5/12/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCVelocityFuse.h"
#import "VISCAnimatingDirectionalNode.h"
#import "VISCVelocityFuse.h"

@interface VISCVelocityFuse ()
@property (nonatomic, strong) VISCDirectionalNode* visibleDirectionalNode;
@property (nonatomic, strong) VISCAnimatingDirectionalNode* animatingDirectionalNode;
@end

@implementation VISCVelocityFuse

#pragma mark - Class Methods
+ (instancetype)velocityFuse
{
   VISCVelocityFuse* velocityTrigger = [self node];

   velocityTrigger.visibleDirectionalNode = [VISCDirectionalNode directionalNode];
   velocityTrigger.visibleDirectionalNode.startPosition = velocityTrigger.position;

   velocityTrigger.animatingDirectionalNode = [VISCAnimatingDirectionalNode directionalNode];
   velocityTrigger.animatingDirectionalNode.startPosition = velocityTrigger.position;

   [velocityTrigger addChild:velocityTrigger.visibleDirectionalNode];
   [velocityTrigger addChild:velocityTrigger.animatingDirectionalNode];

   return velocityTrigger;
}

#pragma mark - Propery Overrides
- (void)setEndPoint:(CGPoint)endPoint
{
   _endPoint = endPoint;
   self.visibleDirectionalNode.endPosition = endPoint;
   self.animatingDirectionalNode.endPosition = endPoint;
}

#pragma mark - Public Instance Methods
- (void)ignite
{
   [self.animatingDirectionalNode startFillAnimation];
}

- (void)reset
{
   [self.visibleDirectionalNode resetPath];
   [self.animatingDirectionalNode resetPath];
}

@end

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
@property (nonatomic, strong) NSArray* directionalNodes;
@end

@implementation VISCVelocityFuse

#pragma mark - Class Methods
+ (instancetype)velocityFuse
{
   VISCVelocityFuse* velocityTrigger = [self node];
   [velocityTrigger setupDirectionalNodes];

   return velocityTrigger;
}

#pragma mark - Setup Methods
- (void)setupDirectionalNodes
{
   self.visibleDirectionalNode = [VISCDirectionalNode directionalNode];
   self.animatingDirectionalNode = [VISCAnimatingDirectionalNode directionalNode];

   self.directionalNodes = @[self.visibleDirectionalNode, self.animatingDirectionalNode];

   [self addChild:self.visibleDirectionalNode];
   [self addChild:self.animatingDirectionalNode];
}

#pragma mark - Propery Overrides
- (void)setEndPoint:(CGPoint)endPoint
{
   _endPoint = endPoint;
   [self.directionalNodes enumerateObjectsUsingBlock:^(VISCDirectionalNode* directionalNode, NSUInteger idx, BOOL *stop) {
      directionalNode.endPosition = endPoint;
   }];
}

#pragma mark - Public Instance Methods
- (void)ignite
{
   [self.animatingDirectionalNode startFillAnimation];
}

- (void)reset
{
   self.endPoint = CGPointZero;
   [self.directionalNodes enumerateObjectsUsingBlock:^(VISCDirectionalNode* directionalNode, NSUInteger idx, BOOL *stop) {
      [directionalNode resetPath];
   }];
}

@end

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

@interface VISCVelocityFuse () <VISCFillAnimationDelegate>
@property (nonatomic, strong) VISCDirectionalNode* visibleDirectionalNode;
@property (nonatomic, strong) VISCAnimatingDirectionalNode* animatingDirectionalNode;
@property (nonatomic, strong) NSArray* directionalNodes;
@property (nonatomic, assign) BOOL preparedForIgnition;
@property (nonatomic, assign) BOOL ignited;
@property (nonatomic, readonly) BOOL canIgnite;
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
   self.animatingDirectionalNode.animationDelegate = self;

   self.directionalNodes = @[self.visibleDirectionalNode, self.animatingDirectionalNode];

   [self addChild:self.visibleDirectionalNode];
   [self addChild:self.animatingDirectionalNode];
}

#pragma mark - Propery Overrides
- (BOOL)canIgnite
{
   return self.preparedForIgnition && !self.ignited;
}

- (void)setEndPoint:(CGPoint)endPoint
{
   if (self.ignited)
   {
      _endPoint = endPoint;
      [self.directionalNodes enumerateObjectsUsingBlock:^(VISCDirectionalNode* directionalNode, NSUInteger idx, BOOL *stop) {
         directionalNode.endPosition = endPoint;
      }];
   }
}

#pragma mark - Public Instance Methods
- (void)prepareForIgnition
{
   self.preparedForIgnition = YES;
   [self.animatingDirectionalNode prepareFillAnimation];
}

- (void)igniteIfNotIgnited
{
   if (self.canIgnite)
   {
      self.ignited = YES;
      [self.animatingDirectionalNode startFillAnimation];
   }
}

- (void)resetIgnition
{
   [self cancelFillAnimationIfNecessary];
   
   self.preparedForIgnition = NO;
   self.ignited = NO;
   self.endPoint = CGPointZero;
   [self.directionalNodes enumerateObjectsUsingBlock:^(VISCDirectionalNode* directionalNode, NSUInteger idx, BOOL *stop) {
      [directionalNode resetPath];
   }];
}

#pragma mark - Helper Methods
- (void)cancelFillAnimationIfNecessary
{
   if (!self.animatingDirectionalNode.animationFinished)
   {
      [self.animatingDirectionalNode cancelFillAnimation];
      if (self.fuseCanceledHandler)
      {
         self.fuseCanceledHandler();
      }
   }
}

#pragma mark - VISCFillAnimationDelegate Methods
- (void)fillAnimationComplete
{
   if (self.fuseCompletionHandler)
   {
      self.fuseCompletionHandler();
      [self resetIgnition];
   }
}

@end

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
   self.visibleDirectionalNode.color = [UIColor blackColor];
   self.visibleDirectionalNode.alpha = .15;

   self.animatingDirectionalNode = [VISCAnimatingDirectionalNode directionalNode];
   self.animatingDirectionalNode.color = [UIColor colorWithRed:1 green:.1 blue:.3 alpha:1];
   self.animatingDirectionalNode.alpha = .7;
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

- (void)setEndPosition:(CGPoint)endPoint
{
   if (self.ignited)
   {
      _endPosition = endPoint;
      [self.directionalNodes enumerateObjectsUsingBlock:^(VISCDirectionalNode* directionalNode, NSUInteger idx, BOOL *stop) {
         [directionalNode updateStartPosition:self.position endPosition:endPoint];
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
   self.endPosition = CGPointZero;
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

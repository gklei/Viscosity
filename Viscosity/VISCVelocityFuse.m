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
@property (nonatomic, assign) CGPoint endPosition;
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
- (CGPoint)startPosition
{  
   CGFloat magnitude = sqrtf(self.endPosition.x*self.endPosition.x + self.endPosition.y*self.endPosition.y);
   CGFloat normalizedX = self.endPosition.x / magnitude;
   CGFloat normalizedY = self.endPosition.y / magnitude;
   
   return CGPointMake(normalizedX*self.startPositionOffsetFromCenter, normalizedY*self.startPositionOffsetFromCenter);
}

- (BOOL)canIgnite
{
   return self.preparedForIgnition && !self.ignited;
}

#pragma mark - Public Instance Methods
- (void)updateEndPosition:(CGPoint)endPosition
{
   if (self.ignited)
   {
      self.endPosition = endPosition;
      [self.directionalNodes enumerateObjectsUsingBlock:^(VISCDirectionalNode* directionalNode, NSUInteger idx, BOOL *stop) {
         [directionalNode updateStartPosition:self.startPosition endPosition:endPosition];
      }];
   }
   else
   {
      [self.visibleDirectionalNode updateStartPosition:self.startPosition endPosition:endPosition];
   }
}

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

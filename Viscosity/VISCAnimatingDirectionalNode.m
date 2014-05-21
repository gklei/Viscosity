//
//  VISCAnimatingDirectionalNode.m
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCAnimatingDirectionalNode.h"

static NSString* const VISCScaleMaskAnimationKey = @"VISCScaleMaskAnimationKey";
static CGFloat const VISCDelayBeforeScaleMaskAniamtion = .25f;

@interface VISCAnimatingDirectionalNode ()
@property (strong, nonatomic) SKAction* scaleMaskAnimationSequence;
@property (nonatomic, assign) BOOL animationFinished;
@end

@implementation VISCAnimatingDirectionalNode

#pragma mark - Overridden DirectionalNode Class Methods
+ (instancetype)directionalNode
{
   VISCAnimatingDirectionalNode* animatingDirectionalNode = [super directionalNode];
   [animatingDirectionalNode setupProperties];

   return animatingDirectionalNode;
}

#pragma mark - Setup Methods
- (void)setupProperties
{
   self.maskNode = [SKSpriteNode spriteNodeWithImageNamed:@"CircleMask"];
   self.color = [UIColor blackColor];
   self.animationDuration = 2;

   SKAction* wait = [SKAction waitForDuration:VISCDelayBeforeScaleMaskAniamtion];
   SKAction* scaleUp = [SKAction scaleTo:5 duration:self.animationDuration];

   __weak typeof(self) weakSelf = self;
   SKAction* fillCompleteCheck = [SKAction customActionWithDuration:scaleUp.duration
                                                   actionBlock:^(SKNode *node, CGFloat elapsedTime)
   {
      CGFloat lineLength = sqrtf((powf(weakSelf.endPosition.x, 2) + powf(weakSelf.endPosition.y, 2)));
      CGFloat scaleRadius = CGRectGetWidth(weakSelf.maskNode.frame)*.5;

      if (scaleRadius > lineLength + 15)
      {
         weakSelf.animationFinished = YES;
         if (weakSelf.fillCompletionHandler)
         {
            weakSelf.fillCompletionHandler();
         }
         [weakSelf resetMaskNode];
      }
   }];

   SKAction* scaleAndCheckCompletion = [SKAction group:@[scaleUp, fillCompleteCheck]];
   self.scaleMaskAnimationSequence = [SKAction sequence:@[wait, scaleAndCheckCompletion]];
}

#pragma mark - Helper Methods
- (void)resetMaskNode
{
   [self.maskNode removeActionForKey:VISCScaleMaskAnimationKey];
   [self.maskNode setScale:0];
}

#pragma mark - Public Instance Methods
- (void)prepareFillAnimation
{
   self.animationFinished = NO;
}

- (void)startFillAnimation
{
   [self resetMaskNode];
   [self.maskNode runAction:self.scaleMaskAnimationSequence withKey:VISCScaleMaskAnimationKey];
}

- (void)cancelFillAnimation
{
   self.animationFinished = YES;
   [self resetMaskNode];
}

@end

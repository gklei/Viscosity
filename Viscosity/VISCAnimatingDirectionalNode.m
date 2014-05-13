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
   self.animationDuration = 5;
   self.dashed = YES;

   SKAction* scaleUp = [SKAction scaleTo:5 duration:self.animationDuration];
   SKAction* wait = [SKAction waitForDuration:VISCDelayBeforeScaleMaskAniamtion];
   self.scaleMaskAnimationSequence = [SKAction sequence:@[wait, scaleUp]];
}

#pragma mark - Helper Methods
- (void)resetMaskNode
{
   [self.maskNode removeActionForKey:VISCScaleMaskAnimationKey];
   [self.maskNode setScale:0];
}

#pragma mark - Public Instance Methods
- (void)startFillAnimation
{
   [self resetMaskNode];
   [self.maskNode runAction:self.scaleMaskAnimationSequence withKey:VISCScaleMaskAnimationKey];
}

@end

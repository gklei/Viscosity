//
//  VISCVelocityNode.m
//  Viscosity
//
//  Created by Klein, Greg on 5/9/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCVelocityNode.h"
#import "VISCDirectionalNode.h"
#import "VISCAnimatingDirectionalNode.h"
#import "VISCVelocityFuse.h"

static CGFloat VISCVelocityNodeSelectedScaleFactor = 1.333;
static CGFloat VISCVelocityNodeUnselectedScale = 1.5;

@interface VISCVelocityNode ()
@property (nonatomic, strong) VISCVelocityFuse* velocityFuse;
@property (nonatomic, strong) SKSpriteNode* velocityBall;
@property (nonatomic, strong) SKAction* scalingAnimation;
@end

@implementation VISCVelocityNode

#pragma mark - Class Methods
+ (instancetype)velocityNode
{
   VISCVelocityNode* velocityNode = [self node];

   [velocityNode setupScale];
   [velocityNode setupVelocityBall];
   [velocityNode setupScalingAnimation];
   [velocityNode setupPhysicsBody];
   [velocityNode setupVelocityFuse];
   velocityNode.userInteractionEnabled = YES;

   return velocityNode;
}

#pragma mark - Setup Methods
- (void)setupVelocityBall
{
   self.velocityBall = [SKSpriteNode spriteNodeWithImageNamed:@"cd"];
   [self addChild:self.velocityBall];
}

- (void)setupPhysicsBody
{
   self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:CGRectGetWidth(self.velocityBall.frame)*.5];
   self.physicsBody.linearDamping = .5;
   self.physicsBody.restitution = .8;
   self.physicsBody.friction = .5;
   self.physicsBody.allowsRotation = NO;
}

- (void)setupScale
{
   [self setScale:VISCVelocityNodeUnselectedScale];
}

- (void)setupScalingAnimation
{
   self.scalingAnimation = [SKAction scaleBy:VISCVelocityNodeSelectedScaleFactor duration:.3];
}

- (void)setupVelocityFuse
{
   self.velocityFuse = [VISCVelocityFuse velocityFuse];

   __weak typeof(self) weakSelf = self;
   self.velocityFuse.fuseCompletionHandler = ^{
      [weakSelf scaleDown];
      [weakSelf fire];
   };

   self.velocityFuse.fuseCanceledHandler = ^{
      [weakSelf scaleDown];
   };

   [self addChild:self.velocityFuse];
}

#pragma mark - Helper Methods
- (void)stop
{
   self.physicsBody.velocity = CGVectorMake(0, 0);
}

- (void)scaleUp
{
   [self runAction:self.scalingAnimation];
}

- (void)scaleDown
{
   [self runAction:[self.scalingAnimation reversedAction]];
}

- (void)fire
{
   self.physicsBody.velocity = CGVectorMake(self.velocityFuse.endPoint.x*4, self.velocityFuse.endPoint.y*4);
}

#pragma mark - Overridden UIResponder Methods
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
   [super touchesBegan:touches withEvent:event];

   [self stop];
   [self scaleUp];
   [self.velocityFuse prepareForIgnition];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
   [super touchesMoved:touches withEvent:event];

   [self.velocityFuse igniteIfNotIgnited];
   self.velocityFuse.endPoint = [[touches anyObject] locationInNode:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   [super touchesEnded:touches withEvent:event];
   [self.velocityFuse resetIgnition];
}

@end

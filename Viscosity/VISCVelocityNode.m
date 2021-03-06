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
static CGFloat VISCVelocityNodeUnselectedScale = 1.3;

@interface VISCVelocityNode ()
@property (nonatomic, strong) VISCVelocityFuse* velocityFuse;
@property (nonatomic, strong) SKSpriteNode* velocityBall;
@property (nonatomic, strong) SKAction* scalingAnimation;
@property (nonatomic, strong) SKSpriteNode* hitBox;
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
   [velocityNode setupHitbox];

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
   self.velocityFuse.startPositionOffsetFromCenter = 20;

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

- (void)setupHitbox
{
   CGSize hitboxSize = CGSizeApplyAffineTransform(self.velocityBall.size, CGAffineTransformMakeScale(1.5, 1.5));
   self.hitBox = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:hitboxSize];
   [self addChild:self.hitBox];
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
   self.physicsBody.velocity = CGVectorMake(self.velocityFuse.endPosition.x*4, self.velocityFuse.endPosition.y*4);
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
   CGPoint touchPosition = [[touches anyObject] locationInNode:self];

   [self.velocityFuse updateEndPosition:touchPosition];
   if (![self.velocityBall containsPoint:touchPosition])
   {
      [self.velocityFuse igniteIfNotIgnited];
   }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   [super touchesEnded:touches withEvent:event];
   [self.velocityFuse resetIgnition];
}

@end

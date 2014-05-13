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
@property (nonatomic, strong) SKAction* scalingAnimation;
@end

@implementation VISCVelocityNode

#pragma mark - Init Methods
+ (instancetype)velocityNode
{
   VISCVelocityNode* velocityNode = [self spriteNodeWithImageNamed:@"cd"];

   [velocityNode setupScale];
   [velocityNode setupScalingAnimation];
   [velocityNode setupPhysicsBody];
   [velocityNode setupVelocityFuse];

   return velocityNode;
}

#pragma mark - Setup Methods
- (void)setupPhysicsBody
{
   self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:CGRectGetWidth(self.frame)*.5];
   self.physicsBody.linearDamping = .5;
   self.physicsBody.restitution = .8;
   self.physicsBody.friction = .5;
   self.physicsBody.allowsRotation = NO;
   self.userInteractionEnabled = YES;
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
   [self addChild:self.velocityFuse];
}

#pragma mark - Helper Methods
- (void)stop
{
   self.physicsBody.velocity = CGVectorMake(0, 0);
}

#pragma mark - Overriden UIResponder Methods
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
   [super touchesBegan:touches withEvent:event];

   [self runAction:self.scalingAnimation];
   [self stop];
   [self.velocityFuse ignite];

}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
   [super touchesMoved:touches withEvent:event];

   CGPoint touchPosition = [[touches anyObject] locationInNode:self];
   self.velocityFuse.endPoint = touchPosition;
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
   [super touchesEnded:touches withEvent:event];

   [self runAction:[self.scalingAnimation reversedAction]];

   self.physicsBody.velocity = CGVectorMake(self.velocityFuse.endPoint.x*4, self.velocityFuse.endPoint.y*4);
   self.velocityFuse.endPoint = [self.parent convertPoint:self.position toNode:self];
   [self.velocityFuse reset];
}

@end

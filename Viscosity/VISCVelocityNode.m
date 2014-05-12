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

static CGFloat VISCVelocityNodeSelectedScale = 2.0;
static CGFloat VISCVelocityNodeUnselectedScale = 1.5;

@interface VISCVelocityNode ()
@property (nonatomic, strong) VISCDirectionalNode* visibleDirectionalNode;
@property (nonatomic, strong) VISCAnimatingDirectionalNode* animatingDirectionalNode;
@end

@implementation VISCVelocityNode

#pragma mark - Init Methods
+ (instancetype)velocityNode
{
   VISCVelocityNode* velocityNode = [self spriteNodeWithImageNamed:@"cd"];
   velocityNode.xScale = VISCVelocityNodeUnselectedScale;
   velocityNode.yScale = VISCVelocityNodeUnselectedScale;

   velocityNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:CGRectGetWidth(velocityNode.frame)*.5];
   velocityNode.physicsBody.linearDamping = .5;
   velocityNode.physicsBody.restitution = .8;
   velocityNode.physicsBody.friction = .5;
   velocityNode.userInteractionEnabled = YES;

   VISCDirectionalNode* visibleDirectionalNode = [VISCDirectionalNode directionalNode];
   visibleDirectionalNode.startPosition = velocityNode.position;

   VISCAnimatingDirectionalNode* animatingDirectionalNode = [VISCAnimatingDirectionalNode directionalNode];
   animatingDirectionalNode.startPosition = velocityNode.position;
   animatingDirectionalNode.color = [UIColor blackColor];

   velocityNode.visibleDirectionalNode = visibleDirectionalNode;
   velocityNode.animatingDirectionalNode = animatingDirectionalNode;

   [velocityNode addChild:visibleDirectionalNode];
   [velocityNode addChild:animatingDirectionalNode];

   return velocityNode;
}

#pragma mark - Helper Methods
- (void)resetPhysicsBody
{
   self.zRotation = 0;
   self.physicsBody.velocity = CGVectorMake(0, 0);
   self.physicsBody.angularVelocity = 0;
}

#pragma mark - Overriden UIResponder Methods
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
   [super touchesBegan:touches withEvent:event];

   SKAction* scaleUp = [SKAction scaleTo:VISCVelocityNodeSelectedScale duration:.3];
   [self runAction:scaleUp];
   [self resetPhysicsBody];
   [self.animatingDirectionalNode startFillAnimation];

}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
   [super touchesMoved:touches withEvent:event];

   UITouch* touch = [touches anyObject];
   CGPoint touchPosition = [touch locationInNode:self];
   self.animatingDirectionalNode.endPosition = touchPosition;
   self.visibleDirectionalNode.endPosition = touchPosition;
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
   [super touchesEnded:touches withEvent:event];

   SKAction* scaleDown = [SKAction scaleTo:VISCVelocityNodeUnselectedScale duration:.3];
   [self runAction:scaleDown];

   self.physicsBody.velocity = CGVectorMake(self.visibleDirectionalNode.endPosition.x*4, self.visibleDirectionalNode.endPosition.y*4);
   self.visibleDirectionalNode.endPosition = [self.parent convertPoint:self.position toNode:self];
   
   [self.visibleDirectionalNode resetPath];
   [self.animatingDirectionalNode resetPath];
}

@end

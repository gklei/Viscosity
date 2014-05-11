//
//  VISCVelocityNode.m
//  Viscosity
//
//  Created by Klein, Greg on 5/9/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCVelocityNode.h"
#import "VISCDirectionalNode.h"

@interface VISCVelocityNode ()
@property (nonatomic, strong) VISCDirectionalNode* directionalNode;
@end

@implementation VISCVelocityNode

#pragma mark - Init Methods
+ (instancetype)velocityNode
{
   VISCVelocityNode* velocityNode = [self spriteNodeWithImageNamed:@"cd"];

   velocityNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:CGRectGetWidth(velocityNode.frame)*.5];
   velocityNode.physicsBody.linearDamping = .5;
   velocityNode.physicsBody.restitution = .8;
   velocityNode.physicsBody.friction = .5;
   velocityNode.userInteractionEnabled = YES;

   VISCDirectionalNode* directionalNode = [VISCDirectionalNode directionalNode];
   directionalNode.startPosition = velocityNode.position;

   velocityNode.directionalNode = directionalNode;
   [velocityNode addChild:directionalNode];

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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   [self resetPhysicsBody];
   [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   UITouch* touch = [touches anyObject];
   CGPoint touchPosition = [touch locationInNode:self];

   self.directionalNode.endPosition = touchPosition;
   [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   self.physicsBody.velocity = CGVectorMake(self.directionalNode.endPosition.x*3, self.directionalNode.endPosition.y*3);
   self.directionalNode.endPosition = [self.parent convertPoint:self.position toNode:self];
   [super touchesEnded:touches withEvent:event];
}

@end

//
//  VISCLevelOneScene.m
//  Viscosity
//
//  Created by Gregory Klein on 3/29/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCLevelOneScene.h"
#import "VISCVelocityNode.h"

@interface VISCLevelOneScene ()
@property (strong, nonatomic) SKLabelNode* levelOneLabel;
@end

@implementation VISCLevelOneScene

#pragma mark - Init Methods
- (id)initWithSize:(CGSize)size
{
   if (self = [super initWithSize:size])
   {
      self.backgroundColor = [SKColor whiteColor];
      self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
      self.physicsWorld.gravity = CGVectorMake(0, 0);
   }
   return self;
}

#pragma mark - Setup Methods
- (void)setupVelocityNode
{
   VISCVelocityNode* velocityNode = [VISCVelocityNode velocityNode];
   velocityNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
   
   [self addChild:velocityNode];
}

#pragma SKScene Overrides
- (void)didMoveToView:(SKView *)view
{
   [super didMoveToView:view];
   [self setupVelocityNode];
}

- (void)update:(NSTimeInterval)currentTime
{
}

@end
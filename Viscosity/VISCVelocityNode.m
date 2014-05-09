//
//  VISCVelocityNode.m
//  Viscosity
//
//  Created by Klein, Greg on 5/9/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCVelocityNode.h"

@implementation VISCVelocityNode

+ (instancetype)velocityNode
{
   VISCVelocityNode* velocityNode = [self spriteNodeWithImageNamed:@"expand_left"];
   velocityNode.xScale = .5f;
   velocityNode.yScale = .5f;
   return velocityNode;
}

@end

//
//  VISCDirectionalNode.m
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCDirectionalNode.h"

static const CGFloat VISCDirectionalNodeDashPattern[] = {3.5, 2};

@interface VISCDirectionalNode ()
@property (strong, nonatomic) SKShapeNode* shapeNode;
@end

@implementation VISCDirectionalNode

+ (instancetype)node
{
   VISCDirectionalNode* directionalNode = [super node];

   directionalNode.shapeNode = [SKShapeNode node];
   directionalNode.shapeNode.strokeColor = [UIColor lightGrayColor];
   directionalNode.shapeNode.lineWidth = 1.5;
   directionalNode.shapeNode.antialiased = NO;

   [directionalNode addChild:directionalNode.shapeNode];
   return directionalNode;
}

#pragma mark - Init Methods
+ (instancetype)directionalNode
{
   return [self node];
}

#pragma mark - Overridden Methods
- (void)setEndPosition:(CGPoint)endPosition
{
   _endPosition = endPosition;
   
   CGMutablePathRef pathToDraw = CGPathCreateMutable();
   CGPathMoveToPoint(pathToDraw, NULL, self.startPosition.x, self.startPosition.y);
   CGPathAddLineToPoint(pathToDraw, NULL, endPosition.x, endPosition.y);

//   self.path = CGPathCreateCopyByDashingPath(pathToDraw, NULL, 0, VISCDirectionalNodeDashPattern, 2);
   self.shapeNode.path = pathToDraw;
}

#pragma mark - Property Overrides
- (void)setColor:(SKColor*)color
{
   self.shapeNode.strokeColor = color;
}

#pragma mark - Public Class Methods
- (void)resetPath
{
   self.shapeNode.path = nil;
}

@end

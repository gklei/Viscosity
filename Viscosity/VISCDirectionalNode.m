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

#pragma mark - Overridden Class Methods
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

#pragma mark - Class Methods
+ (instancetype)directionalNode
{
   return [self node];
}

#pragma mark - Property Overrides
- (void)setEndPosition:(CGPoint)endPosition
{
   _endPosition = endPosition;
   [self setShapeNodePathWithStartPosition:self.startPosition endPosition:endPosition];
}

- (void)setColor:(SKColor*)color
{
   self.shapeNode.strokeColor = color;
}

#pragma mark - Public Instance Methods
- (void)resetPath
{
   self.shapeNode.path = nil;
}

#pragma mark - Helper Methods
- (void)setShapeNodePathWithStartPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition
{
   CGMutablePathRef path = CGPathCreateMutable();
   CGPathMoveToPoint(path, NULL, startPosition.x, startPosition.y);
   CGPathAddLineToPoint(path, NULL, endPosition.x, endPosition.y);

   self.shapeNode.path = self.dashed ? CGPathCreateCopyByDashingPath(path, NULL, 0, VISCDirectionalNodeDashPattern, 2) : path;
}

@end

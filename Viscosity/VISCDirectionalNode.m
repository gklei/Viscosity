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
@property (nonatomic, assign) CGPoint startPosition;
@property (nonatomic, assign) CGPoint endPosition;
@property (nonatomic, strong) SKShapeNode* shapeNode;
@end

@implementation VISCDirectionalNode

#pragma mark - Overridden Class Methods
+ (instancetype)node
{
   VISCDirectionalNode* directionalNode = [super node];
   [directionalNode setupShapeNode];

   return directionalNode;
}

#pragma mark - Setup Methods
- (void)setupShapeNode
{
   self.shapeNode = [SKShapeNode node];
   self.shapeNode.strokeColor = [UIColor lightGrayColor];
   self.shapeNode.lineWidth = 1.5;
   self.shapeNode.antialiased = NO;
   [self addChild:self.shapeNode];
}

#pragma mark - Class Methods
+ (instancetype)directionalNode
{
   return [self node];
}

#pragma mark - Property Overrides
- (void)setColor:(SKColor*)color
{
   _color = color;
   self.shapeNode.strokeColor = color;
}

#pragma mark - Helper Methods
- (void)updateShapeNodePathWithStartPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition
{
   CGMutablePathRef path = CGPathCreateMutable();
   CGPathMoveToPoint(path, NULL, startPosition.x, startPosition.y);
   CGPathAddLineToPoint(path, NULL, endPosition.x, endPosition.y);

   self.shapeNode.path = self.dashed ? CGPathCreateCopyByDashingPath(path, NULL, 0, VISCDirectionalNodeDashPattern, 2) : path;
}

#pragma mark - Public Instance Methods
- (void)updateStartPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition
{
   self.startPosition = startPosition;
   self.endPosition = endPosition;
   [self updateShapeNodePathWithStartPosition:self.startPosition endPosition:self.endPosition];
}

- (void)resetPath
{
   self.shapeNode.path = nil;
}

@end

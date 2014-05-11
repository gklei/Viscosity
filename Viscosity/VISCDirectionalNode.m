//
//  VISCDirectionalNode.m
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCDirectionalNode.h"

static const CGFloat VISCDirectionalNodeDashPattern[] = {3, 3};

@implementation VISCDirectionalNode

#pragma mark - Init Methods
+ (instancetype)directionalNode
{
   VISCDirectionalNode* directionalNode = [self node];
   directionalNode.strokeColor = [UIColor blackColor];
   directionalNode.lineWidth = 1.5;
   directionalNode.antialiased = NO;

   return directionalNode;
}

#pragma mark - Overridden Methods
- (void)setEndPosition:(CGPoint)endPosition
{
   _endPosition = endPosition;
   
   CGMutablePathRef pathToDraw = CGPathCreateMutable();
   CGPathMoveToPoint(pathToDraw, NULL, self.startPosition.x, self.startPosition.y);
   CGPathAddLineToPoint(pathToDraw, NULL, endPosition.x, endPosition.y);

   self.path = CGPathCreateCopyByDashingPath(pathToDraw, NULL, 0, VISCDirectionalNodeDashPattern, 2);
}

@end

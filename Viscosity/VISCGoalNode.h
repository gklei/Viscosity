//
//  VISCGoalNode.h
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "VISCDirectionalNode.h"

@interface VISCGoalNode : VISCDirectionalNode

+ (instancetype)goalNodeWithLength:(CGFloat)length angle:(CGFloat)angle;

@end

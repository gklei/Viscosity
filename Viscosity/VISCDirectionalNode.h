//
//  VISCDirectionalNode.h
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface VISCDirectionalNode : SKShapeNode

@property (nonatomic, assign) CGPoint startPosition;
@property (nonatomic, assign) CGPoint endPosition;

+ (instancetype)directionalNode;

@end

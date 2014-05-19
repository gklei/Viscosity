//
//  VISCDirectionalNode.h
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface VISCDirectionalNode : SKCropNode

@property (nonatomic, assign, readonly) CGPoint startPosition;
@property (nonatomic, assign, readonly) CGPoint endPosition;
@property (nonatomic, assign) BOOL dashed;
@property (nonatomic, strong) SKColor* color;

+ (instancetype)directionalNode;

- (void)updateStartPosition:(CGPoint)startPosition endPosition:(CGPoint)endPosition;
- (void)resetPath;

@end

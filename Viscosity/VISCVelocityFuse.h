//
//  VISCVelocityTrigger.h
//  Viscosity
//
//  Created by Gregory Klein on 5/12/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface VISCVelocityFuse : SKNode

@property (nonatomic, assign) CGPoint endPoint;

+ (instancetype)velocityFuse;
- (void)ignite;
- (void)reset;

@end

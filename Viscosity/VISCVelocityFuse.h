//
//  VISCVelocityTrigger.h
//  Viscosity
//
//  Created by Gregory Klein on 5/12/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface VISCVelocityFuse : SKNode

@property (nonatomic, assign) CGPoint endPosition;
@property (nonatomic, copy) dispatch_block_t fuseCompletionHandler;
@property (nonatomic, copy) dispatch_block_t fuseCanceledHandler;

+ (instancetype)velocityFuse;

- (void)prepareForIgnition;
- (void)igniteIfNotIgnited;
- (void)resetIgnition;

@end

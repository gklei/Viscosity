//
//  VISCAnimatingDirectionalNode.h
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCDirectionalNode.h"

@interface VISCAnimatingDirectionalNode : VISCDirectionalNode

@property (nonatomic, assign) CGFloat animationDuration;

- (void)startFillAnimation;

@end

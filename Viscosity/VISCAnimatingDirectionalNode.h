//
//  VISCAnimatingDirectionalNode.h
//  Viscosity
//
//  Created by Gregory Klein on 5/11/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCDirectionalNode.h"

@protocol VISCFillAnimationDelegate <NSObject>
- (void)fillAnimationComplete;
- (void)fillAnimationCancelled;
@end

@interface VISCAnimatingDirectionalNode : VISCDirectionalNode

@property (nonatomic, assign) CGFloat animationDuration;
@property (nonatomic, weak) id<VISCFillAnimationDelegate> animationDelegate;
@property (nonatomic, readonly) BOOL animationFinished;

- (void)prepareFillAnimation;
- (void)startFillAnimation;
- (void)cancelFillAnimation;

@end

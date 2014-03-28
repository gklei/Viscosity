//
//  VISCMyScene.m
//  Viscosity
//
//  Created by Klein, Greg on 3/28/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCLevelSelectScene.h"

@implementation VISCLevelSelectScene

-(id)initWithSize:(CGSize)size
{
   if (self = [super initWithSize:size])
   {
      self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
      [self setupTitleLabel];
   }
   return self;
}

- (void)setupTitleLabel
{
   SKLabelNode* viscosityTitle = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
   viscosityTitle.text = @"VISCOSITY";
   CGFloat xPosition = CGRectGetMidX(self.frame);
   CGFloat yPosition = CGRectGetMidY(self.frame) + CGRectGetHeight(self.frame)*.25;
   viscosityTitle.position = CGPointMake(xPosition, yPosition);
   
   [self addChild:viscosityTitle];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void)update:(CFTimeInterval)currentTime
{
   /* Called before each frame is rendered */
}

@end

//
//  VISCMyScene.m
//  Viscosity
//
//  Created by Klein, Greg on 3/28/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCLevelSelectScene.h"
#import "VISCLevelOneScene.h"

@interface VISCLevelSelectScene ()
@property (strong, nonatomic) SKLabelNode* levelLabel;
@property (assign, nonatomic) BOOL levelLabelTouched;
@end

@implementation VISCLevelSelectScene

- (id)initWithSize:(CGSize)size
{
   if (self = [super initWithSize:size])
   {
      self.backgroundColor = [SKColor whiteColor];
      
      [self setupTitleLabel];
      [self setupLevelLabelForLevelNumber:1];
   }
   return self;
}

- (void)setupTitleLabel
{
   SKLabelNode* viscosityTitle = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
   viscosityTitle.text = @"VISCOSITY";
   viscosityTitle.fontColor = [SKColor blackColor];
   CGFloat xPosition = CGRectGetMidX(self.frame);
   CGFloat yPosition = CGRectGetMidY(self.frame) + CGRectGetHeight(self.frame)*.25;
   viscosityTitle.position = CGPointMake(xPosition, yPosition);
   
   [self addChild:viscosityTitle];
}

- (void)setupLevelLabelForLevelNumber:(NSUInteger)levelNumber
{
   self.levelLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-Medium"];
   CGFloat xPosition = CGRectGetMidX(self.frame);
   CGFloat yPosition = CGRectGetMidY(self.frame) - CGRectGetHeight(self.frame)*.25;
   self.levelLabel.position = CGPointMake(xPosition, yPosition);
   self.levelLabel.fontSize = 24;
   self.levelLabel.fontColor = [SKColor blackColor];
//   self.levelLabel.text = [NSString stringWithFormat:@"Level %d", levelNumber];
   self.levelLabel.text = @"p l a y";

   [self addChild:self.levelLabel];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   UITouch* touch = [touches anyObject];
   CGPoint touchPosition = [touch locationInNode:self];
   if ([self.levelLabel containsPoint:touchPosition])
   {
      self.levelLabelTouched = YES;
      self.levelLabel.fontColor = [SKColor lightGrayColor];
   }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   UITouch* touch = [touches anyObject];
   CGPoint touchPosition = [touch locationInNode:self];
   if (self.levelLabelTouched && [self.levelLabel containsPoint:touchPosition])
   {
      SKTransition *reveal = [SKTransition fadeWithDuration:.5];
      VISCLevelOneScene *levelOneScene = [[VISCLevelOneScene alloc] initWithSize:self.size];
      [self.scene.view presentScene:levelOneScene transition:reveal];
   }

   self.levelLabel.fontColor = [SKColor blackColor];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   UITouch* touch = [touches anyObject];
   CGPoint touchPosition = [touch locationInNode:self];
   if (![self.levelLabel containsPoint:touchPosition])
   {
      self.levelLabel.fontColor = [SKColor blackColor];
   }
}

- (void)update:(CFTimeInterval)currentTime
{
}

@end

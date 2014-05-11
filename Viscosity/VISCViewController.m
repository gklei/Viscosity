//
//  VISCViewController.m
//  Viscosity
//
//  Created by Klein, Greg on 3/28/14.
//  Copyright (c) 2014 HardFlip, LLC. All rights reserved.
//

#import "VISCViewController.h"
#import "VISCLevelSelectScene.h"

@implementation VISCViewController

- (void)viewWillLayoutSubviews
{
   [super viewWillLayoutSubviews];
   
   SKView * skView = (SKView *)self.view;
   SKScene * scene = [VISCLevelSelectScene sceneWithSize:skView.bounds.size];
   scene.scaleMode = SKSceneScaleModeAspectFill;
   
   [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
   return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
   {
      return UIInterfaceOrientationMaskAllButUpsideDown;
   }
   else
   {
      return UIInterfaceOrientationMaskAll;
   }
}

- (BOOL)prefersStatusBarHidden
{
   return YES;
}

@end

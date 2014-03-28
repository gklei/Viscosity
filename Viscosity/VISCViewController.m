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

- (void)viewDidLoad
{
   [super viewDidLoad];
}

- (void)viewWillLayoutSubviews
{
   [super viewWillLayoutSubviews];
   
   SKView * skView = (SKView *)self.view;
   SKScene * scene = [VISCLevelSelectScene sceneWithSize:skView.bounds.size];
   scene.scaleMode = SKSceneScaleModeAspectFill;
   
   // Present the scene.
   [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
   return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return UIInterfaceOrientationMaskAllButUpsideDown;
   } else {
      return UIInterfaceOrientationMaskAll;
   }
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Release any cached data, images, etc that aren't in use.
}

@end

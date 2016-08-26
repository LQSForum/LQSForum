//
//  rootViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "rootViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)loadData{


}
- (void)setUpViews{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];



}

- (BOOL)shouldAutorotate
{

    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{

    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;


}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
    
}

#pragma mark -m StatusBar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;



}

- (BOOL)prefersStatusBarHidden
{

    return NO;

}
@end

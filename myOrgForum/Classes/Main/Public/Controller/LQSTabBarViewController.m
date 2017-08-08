//
//  LQSTabBarViewControllerTableViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSTabBarViewController.h"
#import "LQSUserManager.h"
@interface LQSTabBarViewController ()<LQSTabBarDelegate>

@end

@implementation LQSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化子控制器
    LQSIntroduceViewController *introduceVc = [[LQSIntroduceViewController alloc] init];
    [self addChileVc:introduceVc title:@"首页" image:@"tab_introduce_common" selectedImage:@"tab_introduce_hilighted"];
    
    LQSForumViewController *forumVc = [[LQSForumViewController alloc] init];
    [self addChileVc:forumVc title:@"版块" image:@"tab_forum_common" selectedImage:@"tab_forum_hilighted"];
    
//    LQSDiscoverViewController *discoverVc = [[LQSDiscoverViewController alloc] init];
//    [self addChileVc:discoverVc title:@"发现" image:@"tab_discover_common" selectedImage:@"tab_discover_hilighted"];
    LQSNewDiscoverViewController *newDiscoverVC = [[LQSNewDiscoverViewController alloc]init];
    [self addChileVc:newDiscoverVC title:@"发现" image:@"tab_discover_common" selectedImage:@"tab_discover_hilighted"];
    LQSSettingViewController *settingVc = [[LQSSettingViewController alloc] init];
    [self addChileVc:settingVc title:@"我的" image:@"tab_setting_hilighted" selectedImage:@"tab_setting_common"];
//更换系统自带的tabbar
    LQSTabBar *tabBar = [[LQSTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

- (void)addChileVc:(UIViewController *)chileVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
//设置子控制器的文字
    chileVc.title = title;
//    设置子控制器的图片
    chileVc.tabBarItem.image = [UIImage imageNamed:image];
    chileVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
//    设置文字样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = LQSColor(123, 123, 123,1);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [chileVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [chileVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    LQSNavigationController *navVc = [[LQSNavigationController alloc] initWithRootViewController:chileVc];
    [self addChildViewController:navVc];

}

#pragma mark -m LQSTabBarDelegate
// 弹出发微博控制器
//HMComposeViewController *compose = [[HMComposeViewController alloc] init];
//HMNavigationController *nav = [[HMNavigationController alloc] initWithRootViewController:compose];
//[self presentViewController:nav animated:YES completion:nil];

- (void)tabBarDidClickPlusButton:(LQSTabBar *)tabBar
{

    UIViewController *vc = [UIViewController new];
    if (LQSUserManager.isLoging) {
        vc =[[LQSComposeViewController alloc] init];
    }else{
        vc = [[LQLoginViewController alloc] init];
    }
    LQSNavigationController *navVc = [[LQSNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navVc animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

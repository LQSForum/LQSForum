//
//  LQSTabBarViewControllerTableViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSTabBarViewController.h"
@interface LQSTabBarViewController ()<LQSTabBarDelegate>

@end

@implementation LQSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化子控制器
    LQSIntroduceViewController *introduceVc = [[LQSIntroduceViewController alloc] init];
    [self addChileVc:introduceVc title:@"推荐" image:@"tab_introduce_common" selectedImage:@"tab_introduce_hilighted"];
    
    LQSForumViewController *forumVc = [[LQSForumViewController alloc] init];
    [self addChileVc:forumVc title:@"论坛" image:@"tab_forum_common" selectedImage:@"tab_forum_hilighted"];
    
    LQSDiscoverViewController *discoverVc = [[LQSDiscoverViewController alloc] init];
    [self addChileVc:discoverVc title:@"发现" image:@"tab_discover_common" selectedImage:@"tab_discover_hilighted"];
    
    LQSSettingViewController *settingVc = [[LQSSettingViewController alloc] init];
    [self addChileVc:settingVc title:@"设置" image:@"tab_setting_hilighted" selectedImage:@"tab_setting_common"];
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
    textAttrs[NSForegroundColorAttributeName] = LQSColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [chileVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [chileVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    LQSNavigationController *navVc = [[LQSNavigationController alloc] initWithRootViewController:chileVc];
    [self addChildViewController:navVc];

}

#pragma mark -m LQSTabBarDelegate

- (void)tabBarDidClickPlusButton:(LQSTabBar *)tabBar
{

    UIViewController *vc = [[UIViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

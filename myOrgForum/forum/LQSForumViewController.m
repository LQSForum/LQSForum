//
//  LQSForumViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumViewController.h"
#import "LQSForumView.h"
#import <QuartzCore/QuartzCore.h>
@interface LQSForumViewController ()

@property (nonatomic, strong) LQSForumView *forumView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;


@end

@implementation LQSForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.flowLayout.itemSize = CGSizeMake(LQSScreenW / 2, 80);
    self.flowLayout.minimumInteritemSpacing = 0;
    self.flowLayout.minimumLineSpacing = 0;
//    self.flowLayout.sectionHeadersPinToVisibleBounds = YES;

    self.forumView = [[LQSForumView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
    [self.view addSubview:self.forumView];

}


@end

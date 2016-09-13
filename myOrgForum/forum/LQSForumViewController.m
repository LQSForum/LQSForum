//
//  ViewController.m
//  ForumDemo
//
//  Created by 昱含 on 16/8/5.
//  Copyright © 2016年 YuHan. All rights reserved.
//
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define kScreenSize  [UIScreen mainScreen].bounds.size
#import "LQSForumViewController.h"
#import "LQSMainView.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "LQSSectionModel.h"
#import "LQSCellModel.h"
#import "YYModel.h"
#import "LQSLatestMarrowTableView.h"

@interface LQSForumViewController ()<LQSMainViewDelegate,LQSLatestMarrowTableViewDelegate>

@property (nonatomic, strong) UIView *bgView;//三个主题导航条背景
@property (nonatomic, weak) UIView *sliderbarView;//滑动条
@property (nonatomic, strong) LQSMainView *mainView;//主视图
@property (nonatomic, strong) UIButton *btn;//三个主题按钮

@end

@implementation LQSForumViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout1.minimumLineSpacing = 0;
    layout1.itemSize = CGSizeMake(kScreenWidth, kScreenHeight-149);
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, 36)];
    [self.view addSubview:self.bgView];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    LQSMainView *mainView = [[LQSMainView alloc]initWithFrame:CGRectMake(0, 100, kWIDTH, kHEIGHT-149) collectionViewLayout:layout1];
    mainView.pagingEnabled = YES;
    mainView.idelegate = self;
    [self.view addSubview:mainView];
    self.mainView = mainView;
    self.mainView.latestView.idelegate = self;
    self.mainView.marrowView.idelegate = self;
    [self loadTopView];
    
}

- (void)latestMarrowTableView:(LQSLatestMarrowTableView *)latestMarrowTableView detailVc:(LQSBBSDetailViewController *)dvc{
    [self.navigationController pushViewController:dvc animated:NO];
}



- (void)loadTopView{
    CGFloat w = 120;
    CGFloat h = 40;
    CGFloat padding = (self.view.bounds.size.width - 3*w)/4;
    CGFloat y = 0;
    
    //添加主题按钮
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        CGFloat x = padding + (w + padding) *i;
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:LQSColor(1, 183, 237, 1.0) forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.bgView addSubview:btn];
        [self setButtonTitle:btn];
    }
    
    //滑动条
    UIView *sliderV = [[UIView alloc] initWithFrame:CGRectMake(padding, 31, 120, 3)];
    sliderV.backgroundColor = LQSColor(1, 183, 237, 1.0);
    self.sliderbarView = sliderV;
    [self.bgView addSubview:sliderV];
    
}

- (void)setButtonTitle:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 0:
        {
            [sender setTitle:@"版块" forState:(UIControlStateNormal)];
        }
            break;
        case 1:
        {
            [sender setTitle:@"最新" forState:(UIControlStateNormal)];
        }
            break;
            
        case 2:
        {
            [sender setTitle:@"精华" forState:(UIControlStateNormal)];
        }
            break;
            
        default:
            break;
    }
}

//主题按钮的点击
- (void)btnClick:(UIButton *)sender{
    
    self.btn.selected = NO;
    sender.selected = YES;
    self.btn = sender;
    
    CGPoint center = self.sliderbarView.center;
    center.x = sender.center.x;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LQSPartClickIndexpath" object:indexPath];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.sliderbarView.center = center;
    }];
    
}


//三个页面的滚动
- (void)mainViewScroll:(LQSMainView *)mainView index:(int)index{
    
    self.btn.selected = NO;
    UIButton *btn = self.bgView.subviews[index];
    btn.selected = YES;
    self.btn = btn;
    
    CGPoint center = self.sliderbarView.center;
    center.x = btn.center.x;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.sliderbarView.center = center;
    }];
    
}


@end

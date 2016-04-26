//
//  LQSNewfeatureViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//
#define LQSNewFeatureImageCount 4

#import "LQSNewfeatureViewController.h"
#import "LQSTabBarViewController.h"
#import "UIView+Extension.h"
#import "LQSAppDelegate.h"
#define HWNewfeatureCount 4

@interface LQSNewfeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;

@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation LQSNewfeatureViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    //添加UIScrollview
    [self setupScrollView];
//    添加pageControl
    [self setupPageControl];
    
    
    
    
}

- (void)setupScrollView{

    //  创建scrollView显示新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //   添加图片到scrollView中
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (NSUInteger i = 0; i < LQSNewFeatureImageCount; i++) {
        //创建UIImageView
        UIImageView *iamgeView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"newFeature%lu",i + 1];
        iamgeView.image = [UIImage imageNamed:name];
        [scrollView addSubview:iamgeView];
//        设置frame
        iamgeView.y = 0;
        iamgeView.width = imageW;
        iamgeView.height = imageH;
        iamgeView.x = i * imageW;
//        给最后一个imageView添加按钮
        if (i == LQSNewFeatureImageCount - 1) {
            [self setupLastImageView:iamgeView];
        }
    }

    //scrollView 的其他属性
    scrollView.contentSize = CGSizeMake(LQSNewFeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = LQSGlobalBg;
    scrollView.delegate = self;
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    [self setupStartButton:imageView];



}

- (void)setupStartButton:(UIImageView *)iamgeView
{
//添加开始按钮
    UIButton *button = [[UIButton alloc] init];
    [iamgeView addSubview:button];
//    设置背景图片
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
//    设置frame
    button.size = button.currentBackgroundImage.size;
    button.centerX = self.view.width * 0.5;
    button.centerY = self.view.height * 0.8;

//设置文字
    [button setTitle:@"开始论坛" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

- (void)start{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [UIApplication sharedApplication].keyWindow.rootViewController = [LQSTabBarViewController new];



}

- (void)setupPageControl
{
//添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = LQSNewFeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 30;
    [self.view addSubview:pageControl];
//    设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = LQSColor(253, 98, 42);
//圆点颜色
    pageControl.pageIndicatorTintColor = LQSColor(189, 189, 189);
//    颜色
    self.pageControl = pageControl;

}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//获取页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    NSUInteger intPage = (NSUInteger)(doublePage + 0.5);
//    设置页面
    self.pageControl.currentPage = intPage;

}

- (void)dealloc
{
    LQSLog(@"%s",__func__);


}
@end

//
//  LQSIntroduceViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSIntroduceViewController.h"

@interface LQSIntroduceViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, weak) UIView *titleIndicatorView;
@property (nonatomic, weak) UIButton *selectedTitleButton;


@end

@implementation LQSIntroduceViewController

- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
//    添加自控制器
    [self setUpChildVc];
//添加ScrollView
    [self setupScrollView];
//    添加标题栏
    [self setupTitleView];
//    根据scrollView的偏移量添加自控制器的View
    [self addChildView];
    
}

//添加标题VIew
- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, LQSNavBarBottom, self.view.width, LQSTitleViewH);
    titleView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:titleView];
    
//    添加标题
    NSUInteger count = self.childViewControllers.count;
    CGFloat titleButtonW = titleView.width / count;
    CGFloat titleButtonH = titleView.height;
    for (NSUInteger i = 0; i < count; i++) {
        LQSTitleButton *titleButton = [LQSTitleButton new];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        titleButton.frame = CGRectMake(i *titleButtonW, 0, titleButtonW, titleButtonH);
        
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
    }
//添加底部的指示器
    UIView *titleIndicatorView = [UIView new];
    [titleView addSubview:titleIndicatorView];
//    设置指示器的背景颜色为按钮的选中文字颜色
    LQSTitleButton *firstTitleButton = titleView.subviews.firstObject;
    titleIndicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    titleIndicatorView.height = 1;
    titleIndicatorView.bottom = titleView.height;
    self.titleIndicatorView = titleIndicatorView;
    firstTitleButton.selected = YES;// 被点击的标题按钮变成选中状态
    self.selectedTitleButton = firstTitleButton;//被点击的标题按钮－ 被选中的标题按钮
    [firstTitleButton.titleLabel sizeToFit];//自动根据当前内容计算尺寸
    
    titleIndicatorView.width = firstTitleButton.titleLabel.width;
    titleIndicatorView.centerX = firstTitleButton.centerX;



}


- (void)titleButtonClick:(LQSTitleButton *)titleButton
{
//当前选中的标题按钮便成以前的状态
    self.selectedTitleButton.selected = NO;

//当前被点击的按钮便成选中状态
    titleButton.selected  = YES;
//    获得当前被选中的按钮
    self.selectedTitleButton = titleButton;
//    移动指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.titleIndicatorView.width = titleButton.titleLabel.width;
        self.titleIndicatorView.centerX = titleButton.centerX;
        
        
    }];

//    滚动scrollView
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x = titleButton.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offSet animated:YES];
}

- (void)addChildView
{
    UIScrollView *scrollView = self.scrollView;
//    计算按钮索引
    int index = scrollView.contentOffset.x / scrollView.width;
//    添加对应的自控制器View
    UIViewController *willShowVc = self.childViewControllers[index];
    if (willShowVc.isViewLoaded) return;
    [scrollView addSubview:willShowVc.view];
//    设置自控制器View的frame
    willShowVc.view.frame = scrollView.bounds;


}

- (void)setupScrollView
{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
//    禁止掉［自动设置scrollView的内边距］
    self.automaticallyAdjustsScrollViewInsets = NO;
//    设置内容大小
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);


}

- (void)setUpChildVc
{

    LQSHotViewController *hotVc = [LQSHotViewController new];
    hotVc.title = @"热点";
    [self addChildViewController:hotVc];

    LQSLatestViewController *lastVc = [LQSLatestViewController new];
    lastVc.title = @"最新";
    [self addChildViewController:lastVc];
    
    LQSJingHuaViewController *jingHuaVc = [LQSJingHuaViewController new];
    jingHuaVc.title =@"精华";
    [self addChildViewController:jingHuaVc];
    
    LQSTopViewController *topVc = [LQSTopViewController new];
    topVc.title = @"置顶";
    [self addChildViewController:topVc];

}

#pragma  mark - scrollVIewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//根据scrollVIew的偏移量添加自控制器的VIew
    [self addChildView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

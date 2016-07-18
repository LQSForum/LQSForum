//
//  LQSDiscoverViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/26.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSDiscoverViewController.h"

@interface LQSDiscoverViewController ()<LQSWaterFlowViewDelegate,LQSWaterFlowViewDataSource>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, weak) UIView *titleIndicatorView;
@property (nonatomic, weak) UIButton *selectedTitleButton;

//tiezi
@property (nonatomic, strong) NSMutableArray *discoriesArr;
@property (nonatomic, weak) LQSWaterFlowView *waterFlowView;



@end

@implementation LQSDiscoverViewController

- (NSMutableArray *)titleButtons
{
    if (!_titleButtons) {
        _titleButtons = [NSMutableArray array];
    }
    return _titleButtons;
}


- (NSMutableArray *)discoriesArr
{
    if (_discoriesArr == nil) {
        self.discoriesArr = [NSMutableArray array];

    }
    return _discoriesArr;
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
    
    
//    discovery
//    初始化数据
    
    
//    瀑布流控件
    LQSWaterFlowView *waterFlowView = [[LQSWaterFlowView alloc] init];
    waterFlowView.backgroundColor = [UIColor cyanColor];
//    跟谁父控件的尺寸而自动伸缩
    waterFlowView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    waterFlowView.frame = self.view.bounds;
    waterFlowView.dataSource = self;
    waterFlowView.delegate = self;
    [self.view addSubview:waterFlowView];
    self.waterFlowView = waterFlowView;
    
//    集成刷新控件下拉刷新
    waterFlowView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [waterFlowView.mj_header endRefreshing];
        
        [self loadNewDiscoveries];
        
    }];
    
//    waterFlowView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDiscoveries)];
    
    
//    在导航栏下 main自动隐藏
    waterFlowView.mj_header.automaticallyChangeAlpha = YES;
//上拉加载
    waterFlowView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [self loadMoreShops];
        [waterFlowView.mj_footer endRefreshing];
    }];
}

- (void)loadNewDiscoveries
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 加载1.plist
        NSArray *newShops = [LQSDiscover objectArrayWithFilename:@"1.plist"];
        [self.discoriesArr insertObjects:newShops atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newShops.count)]];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新瀑布流控件
        [self.waterFlowView reloadData];
        
        // 停止刷新
        [self.waterFlowView.mj_header endRefreshing];
    });


}

- (void)loadMoreShops
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 加载3.plist
        NSArray *newShops = [LQSDiscover objectArrayWithFilename:@"3.plist"];
        [self.discoriesArr addObjectsFromArray:newShops];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 刷新瀑布流控件
        [self.waterFlowView reloadData];
        
        // 停止刷新
        [self.waterFlowView.mj_footer endRefreshing];
    });


}


#pragma mark - dataSource&delegate
- (NSUInteger)numberOfCellsInWaterflowView:(LQSWaterFlowView *)waterflowView
{
    return self.discoriesArr.count;
}

- (LQSWaterFlowViewCell *)waterflowView:(LQSWaterFlowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    LQSDiscoverCell *cell = [LQSDiscoverCell cellWithWaterflowView:waterflowView];
    cell.discover = self.discoriesArr[index];
    return cell;

}

- (NSUInteger)numberOfColumnsInWaterflowView:(LQSWaterFlowView *)waterflowView
{
        return 2;

}

- (CGFloat)waterflowView:(LQSWaterFlowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    LQSDiscover *discover  = self.discoriesArr[index];
    return waterflowView.cellWidth * discover.h / discover.w;

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
    hotVc.title = @"视界";
    [self addChildViewController:hotVc];
    
    LQSLatestViewController *lastVc = [LQSLatestViewController new];
    lastVc.title = @"慈善";
    [self addChildViewController:lastVc];
    
    LQSJingHuaViewController *jingHuaVc = [LQSJingHuaViewController new];
    jingHuaVc.title =@"动漫";
    [self addChildViewController:jingHuaVc];
    
    LQSTopViewController *topVc = [LQSTopViewController new];
    topVc.title = @"共修";
    [self addChildViewController:topVc];
    
}

#pragma  mark - scrollVIewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
////根据scrollVIew的偏移量添加自控制器的VIew
//    [self addChildView];
//
//}

//通过setContentOffset:animated:让scrollView(进行了滚动动画),那么最后会在停止滚动时调用这个方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //根据scrollView的偏移量添加子控制器的view
    [self addChildView];
    
}

//scrollView 停止滚动的时候会调用一次(人为拖拽导致的停止滚动才会触发这个方法)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //计算按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    LQSTitleButton *titleButton = self.titleButtons[index];
    //   点击按钮
    [self titleButtonClick:titleButton];
    //    根据scrollView的偏移量添加自控制器的view
    [self addChildView];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

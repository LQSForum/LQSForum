//
//  LQSNewDiscoverViewController.m
//  myOrgForum
//
//  Created by g x on 2017/7/3.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSNewDiscoverViewController.h"
#import "LQSDiscoverHeadView.h"
#import "LQSDiscDownloadViewController.h"
#import "LQSDiscLifeViewController.h"
#import "LQSDiscStoryViewController.h"
#import "LQSDiscJieYuanViewController.h"



@interface LQSNewDiscoverViewController ()<LQSDiscoverBaseTableViewDelegate>
@property (nonatomic,strong)LQSDiscoverHeadView *headView;// 顶部按钮view
@property (nonatomic,strong)UIView *headBottomView;// headView底部的view
@property (nonatomic,strong)UIView *indicatorView;// 底部的指示器
@property (nonatomic,assign)NSInteger selectedIndex;// 标记选中的栏目
@property (nonatomic,weak)UIView *longView;// 长条view
@property (nonatomic,strong)NSMutableArray *offsetArr;// 记录偏移量
@property (nonatomic,strong)NSMutableArray *btnArr;
@property (nonatomic,strong)NSArray *boardIdArr;// 保存boardId的熟组
@end

@implementation LQSNewDiscoverViewController
static const CGFloat fourBtnViewHeight = 30.0;// 定义4个按钮view的高度
static const CGFloat fourBtnTopDistance = 5.0;// 定义4个按钮view与上面8个按钮view的距离
- (void)viewDidLoad {
    [super viewDidLoad];
   // self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupTopView];
    self.selectedIndex = 2;// 给一个不是第一个按钮的选中状态，为了一开始进入页面时第一个按钮为选中状态
    [self addchildVCs];
    [self oneClick:self.btnArr[0]];
}

#pragma mark - 自定义方法
- (void)setupTopView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    CGFloat topTotalHeight = kScreenWidth/2+fourBtnTopDistance;
    _offsetArr = [NSMutableArray array];
    _offsetArr = @[@(topTotalHeight),@(topTotalHeight),@(topTotalHeight),@(topTotalHeight)].mutableCopy;
    CGFloat headViewHeight = kScreenWidth / 2;// 顶部的按钮是按正方形做的，每个的宽度为屏幕宽度／4
    _headBottomView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, headViewHeight + fourBtnViewHeight +fourBtnTopDistance)];
    [self.view addSubview:_headBottomView];
    _headBottomView.backgroundColor = [UIColor lightGrayColor];
    _headView = [[LQSDiscoverHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, headViewHeight)];
    _headView.backgroundColor = [UIColor brownColor];
    [_headBottomView addSubview:_headView];
    UIView *longView = [[UIView alloc]initWithFrame:CGRectMake(0, headViewHeight+5, kScreenWidth,fourBtnViewHeight)];
    [_headBottomView addSubview:longView];
    longView.backgroundColor = [UIColor greenColor];
    for (NSInteger i = 0; i < 4; i ++) {
        UIButton *btn = [self addBtnWithFrame:CGRectMake(kScreenWidth/4*i, 0, kScreenWidth/4, fourBtnViewHeight) Title:@[@"资料下载",@"因果故事",@"素食人生",@"惜福结缘"][i] selector:@selector(oneClick:) target:self color:[UIColor whiteColor] tag:1001+i superView:longView];
        [self.btnArr addObject:btn];
    }
    _longView = longView;
    self.indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, fourBtnViewHeight -2, kScreenWidth/4, 2)];
    self.indicatorView.backgroundColor = [UIColor blueColor];
    [longView addSubview:_indicatorView];
    // 底部的横线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, fourBtnViewHeight-0.5, kScreenWidth, 0.5)];
    [longView addSubview:lineView];
    lineView.backgroundColor = [UIColor blackColor];
}
- (void)oneClick:(UIButton *)sender{
    NSInteger index = sender.tag - 1001;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.indicatorView.frame;
        frame.origin.x = sender.frame.origin.x;
        self.indicatorView.frame = frame;
    }];
    if (self.selectedIndex != index) {
        UIButton *preBtn = self.btnArr[self.selectedIndex];
        [preBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self switchChildViewsWithIndex:index];
        //self.selectedIndex = index;
    }
}
- (void)addchildVCs{
    LQSDiscDownloadViewController *downloadVC = [[LQSDiscDownloadViewController alloc]init];
    [self addChildViewController:downloadVC];
    LQSDiscStoryViewController *storyVC = [[LQSDiscStoryViewController alloc]init];
    [self addChildViewController:storyVC];
    LQSDiscLifeViewController *lifeVC = [[LQSDiscLifeViewController alloc]init];
    [self addChildViewController:lifeVC];
    LQSDiscJieYuanViewController *jieYuanVC = [[LQSDiscJieYuanViewController alloc]init];
    [self addChildViewController:jieYuanVC];
    downloadVC.delegate = self;
    storyVC.delegate = self;
    lifeVC.delegate = self;
    jieYuanVC.delegate = self;
    self.selectedIndex = 0;
    [self switchChildViewsWithIndex:0];
    
}
- (void)switchChildViewsWithIndex:(NSInteger )index{
    // 记录切换时longView的位置
    CGFloat topTotalHeight = kScreenWidth/2+fourBtnTopDistance;
 __block   CGPoint  point = CGPointZero;
    LQSDiscoverBaseTableViewController *newVC = self.childViewControllers[index];
    NSString *boardId = self.boardIdArr[index];
    [newVC prepareNetDataForBorderId:boardId success:^{
        if (self.selectedIndex != index) {
            [self.headBottomView removeFromSuperview];
            UITableViewController *oldVC = self.childViewControllers[self.selectedIndex];
            UITableView *tableView = oldVC.tableView;
            point = tableView.contentOffset;
           // NSLog(@"切换时的offsety:%f)",point.y);
            [tableView removeFromSuperview];
            if (point.y > topTotalHeight) {
                self.offsetArr[self.selectedIndex] = @(point.y);
            }
        }
        newVC.tableView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-55);
        [self.view addSubview:newVC.tableView];
        if (point.y < topTotalHeight) {
            newVC.tableView.contentOffset = point;
            self.offsetArr = @[@(topTotalHeight),@(topTotalHeight),@(topTotalHeight),@(topTotalHeight)].mutableCopy;
        }else{
            CGFloat offset = [self.offsetArr[index] floatValue];
            newVC.tableView.contentOffset =CGPointMake(0, offset);
            
        }
        [newVC.tableView.tableHeaderView addSubview:self.headBottomView];
        [self judgeLongViewWithTableView:newVC.tableView];
        self.selectedIndex = index;

    } failure:^{
        
    }];
    
}
- (void)judgeLongViewWithTableView:(UITableView *)sender{
    CGFloat topTotalHeight = kScreenWidth/2+fourBtnTopDistance;

    CGFloat offsetY = sender.contentOffset.y;
    if (offsetY >= topTotalHeight) {
        self.longView.frame = CGRectMake(0, 64, kScreenWidth, fourBtnViewHeight);
        [self.view addSubview:self.longView];
    }else{
        self.longView.frame = CGRectMake(0, topTotalHeight, kScreenWidth, fourBtnViewHeight);
        [self.headBottomView addSubview:self.longView];
    }
}
- (UIButton *)addBtnWithFrame:(CGRect )frame Title:(NSString *)title selector:(SEL)sel target:(id)target color:(UIColor *)color tag:(NSInteger)tag superView:(UIView *)superView{
    UIButton *btn = [[UIButton alloc]initWithFrame:frame];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:btn];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:color];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    btn.tag = tag;
    return btn;
}
#pragma mark - tableViewScrollDelegate
- (void)tableViewScroll:(UITableView *)tableView offsetY:(CGFloat)offsetY{
    [self judgeLongViewWithTableView:tableView];
}
#pragma mark - 懒加载
-(NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
-(NSArray *)boardIdArr{
    if (!_boardIdArr) {
        _boardIdArr = [NSArray array];
        _boardIdArr = @[@"512",@"539",@"536",@"513"];
    }
    return _boardIdArr;
}
@end

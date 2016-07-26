//
//  LQSIntroduceViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSIntroduceViewController.h"
#define KTITLEBTNTAGBEGAN 20160716

typedef enum {
    EHotVC = 0,
    ELastVC,
    EJingHuaVC,
    ETopVC
}EVCTYPE;

@interface LQSIntroduceViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *titleButtons;
@property (nonatomic, weak) UIView *titleIndicatorView;
@property (nonatomic, weak) UIButton *selectedTitleButton;
@property (nonatomic) EVCTYPE currentVCType;

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
    
    self.view.backgroundColor = [UIColor whiteColor];
//    添加子控制器
    self.currentVCType = EHotVC;
    [self setUpChildVc];
//    添加标题栏
    [self setupTitleView];
    
    
}

//添加标题VIew
- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, LQSNavBarBottom, self.view.width, LQSTitleViewH);
    titleView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:titleView];
    
//    添加标题
    NSUInteger count = self.childViewControllers.count;
    CGFloat titleButtonW = titleView.width / count;
    CGFloat titleButtonH = titleView.height;
    for (NSUInteger i = 0; i < count; i++) {
        LQSTitleButton *titleButton = [LQSTitleButton new];
        titleButton.tag = KTITLEBTNTAGBEGAN + i;
        [titleButton addTarget:self action:@selector(changeVCButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        [self.titleButtons addObject:titleButton];
        
        titleButton.frame = CGRectMake(i *titleButtonW, 0, titleButtonW, titleButtonH);
        
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
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


- (void)changeVCButtonClick:(LQSTitleButton *)sender
{
//当前选中的标题按钮便成以前的状态
    self.selectedTitleButton.selected = NO;

//当前被点击的按钮便成选中状态
    sender.selected  = YES;
//    获得当前被选中的按钮
    self.selectedTitleButton = sender;
//    移动指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.titleIndicatorView.width = sender.titleLabel.width;
        self.titleIndicatorView.centerX = sender.centerX;
    }];

//    滚动scrollView
    CGPoint offSet = self.scrollView.contentOffset;
    offSet.x = sender.tag * self.scrollView.width;
//切换vc
    NSInteger VCindex = sender.tag - KTITLEBTNTAGBEGAN;
    if (VCindex != self.currentVCType) {
        UIViewController *currentVC = self.childViewControllers[_currentVCType];
        UIViewController *nextVC = self.childViewControllers[VCindex];
        [self transitionFromViewController:currentVC toViewController:nextVC duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
            
        } completion:^(BOOL finished) {
           //切换完成
            switch (VCindex) {
                case 0:{
                    self.currentVCType = EHotVC;
                    break;
                }case 1:{
                    self.currentVCType = ELastVC;
                    break;
                }case 2:{
                    self.currentVCType = EJingHuaVC;
                    break;
                }case 3:{
                    self.currentVCType = ETopVC;
                    break;
                }
                    
                    
                default:
                    break;
            }
        }];
    }
    
    
    
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
    
    UIViewController *vc = self.childViewControllers[self.currentVCType];
    UIView *contentView = [[UIView alloc] initWithFrame:self.view.frame];
    [contentView addSubview:vc.view];
    [self.view addSubview:contentView];

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

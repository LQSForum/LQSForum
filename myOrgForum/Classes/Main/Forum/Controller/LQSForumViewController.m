//
//  ViewController.m
//  ForumDemo
//
//  Created by 昱含 on 16/8/5.
//  Copyright © 2016年 YuHan. All rights reserved.
//

#import "LQSForumViewController.h"
#import "LQSMainView.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "LQSSectionModel.h"
#import "LQSCellModel.h"
#import "YYModel.h"
#import "LQSLatestMarrowTableView.h"

@interface LQSForumViewController ()<LQSMainViewDelegate,LQSLatestMarrowTableViewDelegate>

/** 主题导航条背景 */
@property (nonatomic, strong) UIView *bgView;
/** 主题按钮背景 */
@property (nonatomic, strong) UIView *btnView;
/** 滑动条 */
@property (nonatomic, strong) UIView *sliderbarView;
/** 主视图 */
@property (nonatomic, strong) LQSMainView *mainView;
/** 主题按钮 */
@property (nonatomic, strong) UIButton *btn;
/** 横线 */
@property (nonatomic, strong) UIView *horizontalLine;

@end

@implementation LQSForumViewController

#pragma mark - LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UIExtendedEdge的属性，指定边缘要延伸的方向，默认值是UIRectEdgeAll,一般为了不让tableView不延伸到navigationBar下面，属性设置为UIRectEdgeNone
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 让导航栏不透明且占空间位置，所以UI坐标就会从导航栏下面开始算起。
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.horizontalLine];
    [self.bgView addSubview:self.sliderbarView];
    [self.bgView addSubview:self.btnView];
    [self.view addSubview:self.mainView];
    
    [self loadTopView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(skipLoginVC:) name:@"loginVC" object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - PrivateMethods

- (void)loadTopView
{
    
    CGFloat w = LQSScreenW/2;
    CGFloat h = 35;
    CGFloat y = 0;
    
    //添加主题按钮
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i+10;
        CGFloat x = w *i;
        btn.frame = CGRectMake(x, y, w, h);
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:LQSColor(1, 183, 237, 1.0) forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.btnView addSubview:btn];
        [self setButtonTitle:btn];
    }
    
    [self.horizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(LQSScreenW);
    }];
    
}


- (void)setButtonTitle:(UIButton *)sender
{
    
    switch (sender.tag) {
        case 10:
        {
            [sender setTitle:@"版块" forState:(UIControlStateNormal)];
        }
            break;
        case 11:
        {
            [sender setTitle:@"关注" forState:(UIControlStateNormal)];
        }
            break;
            
            
            default:
            break;
    }
}


- (void)skipLoginVC:(NSNotification *)notification
{
    [self presentViewController:notification.object animated:YES completion:nil];
}

#pragma mark - CustomDelegate
- (void)latestMarrowTableView:(LQSLatestMarrowTableView *)latestMarrowTableView detailVc:(LQSBBSDetailViewController *)dvc
{
    [self.navigationController pushViewController:dvc animated:NO];
}

- (void)pushToDetailVc:(LQSForumAttentionModel *)model
{
    LQSBBSDetailViewController *detailVc = [[LQSBBSDetailViewController alloc]init];
    detailVc.boardID = [NSString stringWithFormat:@"%zd",model.attentionBoardID];
    detailVc.topicID = [NSString stringWithFormat:@"%zd",model.attentionTopicID];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}

#pragma mark - EventResponse
//主题按钮的点击
- (void)btnClick:(UIButton *)sender
{
    
    self.btn.selected = NO;
    sender.selected = YES;
    self.btn = sender;
    
    CGPoint center = self.sliderbarView.center;
    center.x = sender.center.x;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(sender.tag-10) inSection:0];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LQSPartClickIndexpath" object:indexPath];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.sliderbarView.center = center;
    }];
    
}

#pragma mark - LQSMainViewDelegate
//页面的滚动
- (void)mainViewScroll:(LQSMainView *)mainView index:(int)index
{
    
    self.btn.selected = NO;
    UIButton *btn = self.btnView.subviews[index];
    btn.selected = YES;
    self.btn = btn;
    
    CGPoint center = self.sliderbarView.center;
    center.x = btn.center.x;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.sliderbarView.center = center;
    }];
    
}




#pragma mark - SetterAndGetter
- (UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LQSScreenW, 36)];
        
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}


- (UIView *)sliderbarView
{
    if (_sliderbarView == nil) {
        _sliderbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 33, (LQSScreenW/2), 3)];
        _sliderbarView.backgroundColor = LQSColor(1, 183, 237, 1.0);
        
    }
    return _sliderbarView;
}

- (LQSMainView *)mainView
{
    if (_mainView == nil) {
        UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
        layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout1.minimumLineSpacing = 0;
        layout1.itemSize = CGSizeMake(LQSScreenW, LQSScreenH-148);
        _mainView = [[LQSMainView alloc]initWithFrame:CGRectMake(0, 36.5, LQSScreenW, LQSScreenH-148) collectionViewLayout:layout1];
        _mainView.pagingEnabled = YES;
        _mainView.idelegate = self;
        
        
    }
    return _mainView;
}


- (UIView *)btnView
{
    if (_btnView == nil) {
        _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LQSScreenW, 36)];
    }
    return _btnView;
}

- (UIView *)horizontalLine
{
    if (_horizontalLine == nil) {
        _horizontalLine = [[UIView alloc] init];
        _horizontalLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _horizontalLine;
}

@end

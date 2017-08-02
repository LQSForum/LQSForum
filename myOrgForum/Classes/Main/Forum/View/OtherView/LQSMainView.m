//
//  LQSMainView.m
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSMainView.h"
#import "LQSMainViewCell.h"
#import "Masonry.h"
#import "LQSLeftTableView.h"
#import "LQSRightTableView.h"
#import "LQSCellModel.h"

#define LQSMainCell @"LQSMainViewCell"

@interface LQSMainView ()<UICollectionViewDataSource,UICollectionViewDelegate,LQSLeftTableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) LQSLeftTableView *leftView;//我的关注左侧页面
@property (nonatomic,strong) LQSRightTableView *rightView;//我的关注右侧页面
@property (nonatomic, strong) NSMutableArray *focusData;//默认显示的右侧视图数据
@property (nonatomic, strong) NSMutableArray *allData;

/** 左侧页面右侧竖线 */
@property (nonatomic, strong) UIView *verticalLine;
/** 关注页面 */
@property (nonatomic, strong) LQSForumAttentionView *attentionView;

@end

@implementation LQSMainView



-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.dataSource = self;
        self.delegate = self;
        
        // 注册 cell
        [self registerClass:[LQSMainViewCell class] forCellWithReuseIdentifier:LQSMainCell];
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        
        //给左右两个tableView设置Frame(默认情况下：leftView宽度为屏幕的1/3，rightView宽度为屏幕的2/3，高度都为全屏)
        [self addSubview:self.verticalLine];
        [self addSubview:self.rightView];
        [self addSubview:self.leftView];
        //关注页面
        [self addSubview:self.attentionView];
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(focusDataWithNotify:) name:@"focus" object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allDataWithNotify:) name:@"allData" object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(subViewScrollWithNotify:) name:@"LQSPartClickIndexpath" object:nil];
        
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

//默认选中右侧视图的数据
-(void)focusDataWithNotify:(NSNotification *)notify{
    self.focusData = notify.object;
}

//右侧视图的所有数据
-(void)allDataWithNotify:(NSNotification *)notify{
    self.allData = notify.object;
}

//页面切换
- (void)subViewScrollWithNotify:(NSNotification *)notify{
    
    NSIndexPath *indexPath = notify.object;
    
    //    if (indexPath.row == 1) {
    //        self.latestView.sortby = @"new";
    //    }else if(indexPath.row == 2){
    //        self.marrowView.sortby = @"marrow";
    //    }
    
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
}



-(void)setupUI{
    
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(LQSScreenW/3);
        make.width.mas_equalTo(0.3);
        make.height.mas_equalTo(LQSScreenH);
    }];
    //默认显示右侧视图数据
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.leftView selectRowAtIndexPath:idxPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.rightView.sectionNum = 2;
}



#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LQSMainViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LQSMainCell forIndexPath:indexPath];
    //    cell.backgroundColor = [self arndomColor];
    
    
    return cell;
}

//页面切换
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int idx = scrollView.contentOffset.x / LQSScreenW;
    if ([self.idelegate respondsToSelector:@selector(mainViewScroll:index:)]) {
        [self.idelegate mainViewScroll:self index:idx];
    }
    
}

#pragma mark-我的关注左侧视图的代理方法
//除了我的关注其他四个板块的数据
- (void)leftTableView:(LQSLeftTableView *)leftTableView rightViewArray:(NSMutableArray *)rightViewArray allDataArray:(NSMutableArray *)allDataArray{
    self.rightView.sectionNum = 1;
    self.rightView.rightDataArray = rightViewArray;
    self.rightView.allFocusArray = allDataArray;
}

//我的关注页面的数据
- (void)leftTableView:(LQSLeftTableView *)leftTableView rightViewFocusArray:(NSMutableArray *)rightViewFocusArray allDataArray:(NSMutableArray *)allDataArray{
    self.rightView.sectionNum = 2;
    self.rightView.notFocusArray = rightViewFocusArray;
    self.rightView.allFocusArray = allDataArray;
}



#pragma mark - SetterAndGetter

- (void)setFocusData:(NSMutableArray *)focusData{
    _focusData = focusData;
    self.rightView.notFocusArray = focusData;
    [self reloadData];
}

- (void)setAllData:(NSMutableArray *)allData{
    _allData = allData;
    self.rightView.allFocusArray = allData;
    [self reloadData];
}


-(UIColor *)arndomColor{
    
    CGFloat red = arc4random_uniform(256)/ 255.0;
    CGFloat green = arc4random_uniform(256)/ 255.0;
    CGFloat blue = arc4random_uniform(256)/ 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    
    return color;
}

- (UIView *)verticalLine
{
    if (_verticalLine == nil) {
        _verticalLine = [[UIView alloc] init];
        _verticalLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _verticalLine;
}

- (LQSLeftTableView *)leftView
{
    if (_leftView == nil) {
        _leftView = [[LQSLeftTableView alloc] initWithFrame:CGRectMake(0, 0, LQSScreenW/3, LQSScreenH-148)];
        _leftView.leftViewDelegate = self;
        _leftView.backgroundColor = LQSColor(250, 248, 251, 1.0);
    }
    return _leftView;
}


- (LQSRightTableView *)rightView
{
    if (_rightView == nil) {
        _rightView = [[LQSRightTableView alloc] initWithFrame:CGRectMake(LQSScreenW/3+2, 0, LQSScreenW/3 * 2, LQSScreenH-148)];
        _rightView.backgroundColor = [UIColor whiteColor];
        
    }
    return _rightView;
}

- (LQSForumAttentionView *)attentionView
{
    if (_attentionView == nil) {
        _attentionView = [[LQSForumAttentionView alloc] initWithFrame:CGRectMake(LQSScreenW, 0, LQSScreenW, LQSScreenH-148)];
    }
    return _attentionView;
}

@end

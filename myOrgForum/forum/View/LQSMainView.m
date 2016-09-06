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
#import "LQSLatestMarrowTableView.h"
#import "LQSCellModel.h"
#define LQSMainCell @"LQSMainViewCell"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize  [UIScreen mainScreen].bounds.size
@interface LQSMainView ()<UICollectionViewDataSource,UICollectionViewDelegate,LQSLeftTableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) LQSLeftTableView *leftView;//我的关注左侧页面
@property (nonatomic,strong) LQSRightTableView *rightView;//我的关注右侧页面
@property (nonatomic, strong) LQSLatestMarrowTableView *latestView;//最新页面
@property (nonatomic, strong) LQSLatestMarrowTableView *marrowView;//精华页面
@property (nonatomic, strong) NSMutableArray *focusData;//默认显示的右侧视图数据
@property (nonatomic, strong) NSMutableArray *allData;

@end

@implementation LQSMainView


-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        //        self.backgroundColor = [UIColor orangeColor];
        
        self.dataSource = self;
        self.delegate = self;
        
        // 注册 cell
        [self registerClass:[LQSMainViewCell class] forCellWithReuseIdentifier:LQSMainCell];

        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(focusDataWithNotify:) name:@"focus" object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allDataWithNotify:) name:@"allData" object:nil];
        
        [self setupUI];
        
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(latestMarrowViewScrollWithNotify:) name:@"LQSPartClickIndexpath" object:nil];
        
    }
    return self;
}

//默认选中右侧视图的数据
-(void)focusDataWithNotify:(NSNotification *)notify{
    self.focusData = notify.object;
}

//右侧视图的所有数据
-(void)allDataWithNotify:(NSNotification *)notify{
    self.allData = notify.object;
}

//最新和精华页面切换
- (void)latestMarrowViewScrollWithNotify:(NSNotification *)notify{
    
    NSIndexPath *indexPath = notify.object;
    
    if (indexPath.row == 1) {
        self.latestView.sortby = @"new";
    }else if(indexPath.row == 2){
        self.marrowView.sortby = @"marrow";
    }
    
    [self scrollToItemAtIndexPath:notify.object atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
}



-(void)setupUI{
    
    //给左右两个tableView设置Frame(默认情况下：leftView宽度为屏幕的1/3，rightView宽度为屏幕的2/3，高度都为全屏)
    
    self.leftView = [[LQSLeftTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/3, self.height)];
    self.leftView.leftViewDelegate = self;
    self.leftView.backgroundColor = LQSColor(250, 248, 251, 1.0);
    [self addSubview:self.leftView];
    
    self.rightView = [[LQSRightTableView alloc] initWithFrame:CGRectMake(kScreenWidth/3, 0, kScreenWidth/3 * 2, self.height)];
    self.rightView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.rightView];
    
    //最新和精华页面
    self.latestView = [[LQSLatestMarrowTableView alloc]init];
    self.marrowView = [[LQSLatestMarrowTableView alloc]init];
    self.latestView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, self.frame.size.height);
    self.marrowView.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, self.frame.size.height);
//        self.latestView.backgroundColor = [UIColor blueColor];
//        self.marrowView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.latestView];
    [self addSubview:self.marrowView];
    
    //默认显示右侧视图数据
    NSIndexPath *idxPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.leftView selectRowAtIndexPath:idxPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    self.rightView.sectionNum = 2;
}



#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
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
    int idx = scrollView.contentOffset.x / kScreenSize.width;
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


-(UIColor *)arndomColor{
    
    CGFloat red = arc4random_uniform(256)/ 255.0;
    CGFloat green = arc4random_uniform(256)/ 255.0;
    CGFloat blue = arc4random_uniform(256)/ 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    
    return color;
}

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

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end

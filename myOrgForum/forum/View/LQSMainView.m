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
#define LQSMainCell @"LQSMainViewCell"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize  [UIScreen mainScreen].bounds.size
@interface LQSMainView ()<UICollectionViewDataSource,UICollectionViewDelegate,LQSLeftTableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) LQSLeftTableView *leftView;
@property (nonatomic,strong) LQSRightTableView *rightView;
@property (nonatomic, strong) LQSLatestMarrowTableView *latestView;
@property (nonatomic, strong) LQSLatestMarrowTableView *marrowView;

@end

@implementation LQSMainView


-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        
        //        self.backgroundColor = [UIColor orangeColor];
        
        // 设置数据源和代理
        self.dataSource = self;
        
        self.delegate = self;
        
        // 注册 cell
        [self registerClass:[LQSMainViewCell class] forCellWithReuseIdentifier:LQSMainCell];
        
        
        // 隐藏滚动条
        self.showsHorizontalScrollIndicator = NO;
        
        // 设置分页,取消弹簧效果
        self.pagingEnabled = YES;
        
        self.bounces = NO;
        
        [self setupUI];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(latestMarrowViewScrollWithNotify:) name:@"LQSPartClickIndexpath" object:nil];
        
    }
    return self;
}

- (void)latestMarrowViewScrollWithNotify:(NSNotification *)notify{
    
    NSIndexPath *indexPath = notify.object;
    
    if (indexPath.row == 1) {
        self.latestView.sortby = @{@"sortby":@"new"};
    }else if(indexPath.row == 2){
        self.marrowView.sortby = @{@"sortby":@"marrow"};
    }
    
    [self scrollToItemAtIndexPath:notify.object atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
    
}



-(void)setupUI{
    
    //给左右两个tableView设置Frame(默认情况下：leftView宽度为屏幕的1/3，rightView宽度为屏幕的2/3，高度都为全屏)
    
    self.leftView = [[LQSLeftTableView alloc] init];
    self.leftView.leftViewDelegate = self;
    self.leftView.frame = CGRectMake(0, 64, kScreenWidth/3, self.frame.size.height);
    self.leftView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.leftView];
    
    self.rightView = [[LQSRightTableView alloc] init];
    self.rightView.frame = CGRectMake(kScreenWidth/3, 64, kScreenWidth/3 * 2, self.frame.size.height);
    self.rightView.backgroundColor = [UIColor blueColor];
    [self addSubview:self.rightView];
    
    self.latestView = [[LQSLatestMarrowTableView alloc]init];
    self.marrowView = [[LQSLatestMarrowTableView alloc]init];
    self.latestView.frame = CGRectMake(kScreenWidth, 64, kScreenWidth, self.frame.size.height);
    self.marrowView.frame = CGRectMake(kScreenWidth * 2, 64, kScreenWidth, self.frame.size.height);
    //    self.latestView.backgroundColor = [UIColor blueColor];
    //    self.marrowView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.latestView];
    [self addSubview:self.marrowView];
    
    
    //    self.leftView.dataArray = self.leftDataArray;
    
    //leftTableView默认选中第一行
    //    [self.leftView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    //rightTableView默认展示第一组数据
    //    self.rightView.dataArray = self.rightDataArray[0];
    
    
    
    
    
}



#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LQSMainViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LQSMainCell forIndexPath:indexPath];
    cell.backgroundColor = [self arndomColor];
    
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int idx = scrollView.contentOffset.x / kScreenSize.width;
    if ([self.idelegate respondsToSelector:@selector(mainViewScroll:index:)]) {
        [self.idelegate mainViewScroll:self index:idx];
    }
    
    if (idx == 1) {
        self.latestView.sortby = @{@"sortby":@"new"};
    }else if(idx == 2){
        self.marrowView.sortby = @{@"sortby":@"marrow"};
    }
    
    
}

- (void)leftTableView:(LQSLeftTableView *)leftTableView rightViewArray:(NSMutableArray *)rightViewArray{
    self.rightView.rightDataArray = rightViewArray;
}

-(UIColor *)arndomColor{
    
    CGFloat red = arc4random_uniform(256)/ 255.0;
    CGFloat green = arc4random_uniform(256)/ 255.0;
    CGFloat blue = arc4random_uniform(256)/ 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.8];
    
    return color;
}

@end

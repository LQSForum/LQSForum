//
//  LQSPickViewSelectViewController.m
//  myOrgForum
//
//  Created by 宋小宇Mac pro on 16/8/11.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPickViewSelectViewController.h"
#import "LQSPickerSelectCollectionViewCell.h"

@interface LQSPickViewSelectViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>


@end

@implementation LQSPickViewSelectViewController

static NSString * const reuseIdentifier = @"imgCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat margin = 3;
    
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    CGFloat itemW = (LQSScreenW - margin *4)/3;
    CGFloat itemH = itemW;
    
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(itemW, itemH);
    //cell之间的水平间距
    layout.minimumInteritemSpacing = 3 ;
    
    //cell之间的垂直间距
    layout.minimumLineSpacing = 3;
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    [collect setBackgroundColor:[UIColor whiteColor]];
    //代理设置
    collect.delegate=self;
    collect.dataSource=self;
    
    //注册item类型 这里使用系统的类型
    [collect registerClass:[LQSPickerSelectCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.view addSubview:collect];
    
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    LQSPickerSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    LQSPickerSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end

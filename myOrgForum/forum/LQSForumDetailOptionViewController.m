//
//  LQSForumDetailOptionViewController.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailOptionViewController.h"
#import "LQSForumDetailOptionCell.h"
@interface LQSForumDetailOptionViewController (){
    NSMutableArray     *_mainArray;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;

@end

@implementation LQSForumDetailOptionViewController

- (CGFloat)contentHeight{
    return 0;
}
- (void)setContentArray:(NSArray*)array{
    if (array.count == 0) {
        return;
    }
    [_mainArray removeAllObjects];
    [_mainArray addObjectsFromArray:array];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _mainArray = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mainArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LQSForumDetailOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LQSForumDetailOptionCell" forIndexPath:indexPath];
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

@end

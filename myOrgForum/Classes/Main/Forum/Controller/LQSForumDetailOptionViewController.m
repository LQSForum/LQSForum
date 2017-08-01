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
    CGFloat             _height;
}
@property (strong, nonatomic) IBOutlet UICollectionView *mainCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *mainFlowLayout;
@end

@implementation LQSForumDetailOptionViewController

- (CGFloat)contentHeight{
//    return 160;
    return _height;
}
- (void)setContentArray:(NSArray*)array{
    if (array.count == 0) {
        return;
    }
    [_mainArray removeAllObjects];
    [_mainArray addObject:@{@"classificationType_id":@"-1",@"classificationType_name":@"全部"}];
    [_mainArray addObjectsFromArray:array];
    [_mainCollectionView reloadData];
    _height = ceil(array.count/3.0f)*50;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _mainArray = [NSMutableArray new];
    _mainFlowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-1)/3.0f, 50.0f);
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
    [cell setHiddenRightLine:(indexPath.row%3==2)];
    NSDictionary* dict = _mainArray[indexPath.row];
    cell.titleLabel.text = dict[@"classificationType_name"];
    NSLog(@"dict = %@",dict);
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    NSDictionary* item = _mainArray[indexPath.row];
    if ([item[@"classificationType_id"] integerValue] != -1) {
        dict[@"filterType"] = @"typeid";
        dict[@"filterId"] = item[@"classificationType_id"];
    }
    if ([self.delegate respondsToSelector:@selector(selectOption:)]) {
        [self.delegate selectOption:[dict copy]];
    }
}

@end

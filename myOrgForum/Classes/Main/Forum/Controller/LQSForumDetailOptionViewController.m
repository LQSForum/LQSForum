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
/** 底部重置按钮 */
@property (nonatomic, strong) UIButton *resetBtn;
/** 底部确定按钮 */
@property (nonatomic, strong) UIButton *confirmBtn;
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
    NSArray *allArr = @[@{@"classificationType_id":@"-1",@"classificationType_name":@"全部"}];
    [_mainArray addObject:allArr];
    [_mainArray addObject:array];
    [_mainCollectionView reloadData];
    //    _height = ceil(array.count/3.0f)*50;
    _height = kScreenHeight - 64;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _mainArray = [NSMutableArray new];
    _mainFlowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-1)/3.0f, 50.0f);
    _mainFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableViewHeader"];
    _mainFlowLayout.headerReferenceSize = CGSizeMake(300.0f, 50.0f);  //设置head大小
    [self.view addSubview:self.resetBtn];
    [self.view addSubview:self.confirmBtn];
    [self setupFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFrame
{
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _mainArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_mainArray[section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LQSForumDetailOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LQSForumDetailOptionCell" forIndexPath:indexPath];
    //    [cell setHiddenRightLine:(indexPath.row%3==2)];
    NSDictionary* dict = _mainArray[indexPath.section][indexPath.row];
    cell.titleLabel.text = dict[@"classificationType_name"];
    //    NSLog(@"dict = %@",dict);
    return cell;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// 此方法是返回collectionView得头部或尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"reusableViewHeader";
    
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ID forIndexPath:indexPath];
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 50)];
    titleLbl.font = kSystemFont(24.0);
    [reusableView addSubview:titleLbl];
    if (indexPath.section == 0) {
        titleLbl.text = @"分类";
    }else{
        titleLbl.text = @"主题分类";
    }
    return reusableView;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* dict = [NSMutableDictionary new];
    NSDictionary* item = _mainArray[indexPath.section][indexPath.row];
    if ([item[@"classificationType_id"] integerValue] != -1) {
        dict[@"filterType"] = @"typeid";
        dict[@"filterId"] = item[@"classificationType_id"];
    }
    if ([self.delegate respondsToSelector:@selector(selectOption:)]) {
        [self.delegate selectOption:[dict copy]];
    }
}


#pragma mark - Getter
- (UIButton *)resetBtn
{
    if (_resetBtn == nil) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = kSystemFont(33.0);
        _resetBtn.backgroundColor = [UIColor lightGrayColor];
        [_resetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //TODO-点击事件
    }
    return _resetBtn;
}

- (UIButton *)confirmBtn
{
    if (_confirmBtn == nil) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = kSystemFont(33.0);
        _confirmBtn.backgroundColor = LQSColor(1, 183, 237, 1.0);
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //TODO-点击事件
    }
    return _confirmBtn;
}

@end

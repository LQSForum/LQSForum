//
//  LQSForumView.m
//  myOrgForum
//
//  Created by 昱含 on 16/7/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumView.h"
#import "LQSForumCell.h"
#import "LQSHeaderView.h"
#import "LQSSectionModel.h"
#import "LQSCellModel.h"
#import "YYModel.h"
@interface LQSForumView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation LQSForumView

static NSString *cellID = @"cell";
static NSString *headerID = @"headerId";

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
//        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
//        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSSet *set = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
    }
    return _sessionManager;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
     
        self.backgroundColor = LQSColor(250, 248, 251);
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[LQSForumCell class] forCellWithReuseIdentifier:cellID];
        [self registerClass:[LQSHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self loadServerData];
        });

    }
    
    return self;
}

//MARK: - 加载网络数据
- (void)loadServerData{
    
    NSString *urlString = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=forum/forumlist";
    NSDictionary *dict = @{@"name":@"forumKey",@"value":@"BW0L5ISVRsOTVLCTJx"};
    
    [self.sessionManager POST:urlString parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSString *p = @"/Users/yuhan/Desktop/plist";
        NSString *path = [p stringByAppendingPathComponent:@"forum.plist"];
        [dict writeToFile:path atomically:YES];
//        LQSLog(@"%@",dict);
        
        NSArray *listArr = dict[@"list"];
        for (NSDictionary *sectionDict in listArr) {
            LQSSectionModel *model = [LQSSectionModel yy_modelWithDictionary:sectionDict];
            [self.sections addObject:model];
            NSArray *cellListArr = sectionDict[@"board_list"];
            for (NSDictionary *itemDict in cellListArr) {
                LQSCellModel *cellModel = [LQSCellModel yy_modelWithDictionary:itemDict];
                [model.items addObject:cellModel];
            }

        }

            [self reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        LQSLog(@"error%@",error);

    }];
    
}

//MARK: - 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.sections.count;

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [self.sections[section] board_list].count;
  
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LQSForumCell *cell = [self dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.borderColor = LQSColor(233, 231, 233).CGColor;
    cell.layer.borderWidth = 0.25;
    LQSSectionModel *sectionModel = self.sections[indexPath.section];
    LQSCellModel *cellModel = sectionModel.items[indexPath.item];
    cell.cellModel = cellModel;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    LQSHeaderView *headerView = [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerID forIndexPath:indexPath];
    headerView.backgroundColor = LQSColor(235, 235, 235);
    LQSSectionModel *model = self.sections[indexPath.section];
    headerView.titleLabel.text = model.board_category_name;
    
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(LQSScreenW, 35);
}

- (NSMutableArray *)sections{
    if (_sections == nil) {
        _sections = [NSMutableArray array];
    }
    
    return _sections;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}


@end

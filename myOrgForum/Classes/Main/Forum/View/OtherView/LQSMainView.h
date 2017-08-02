//
//  LQSMainView.h
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSLatestMarrowTableView.h"
#import "LQSForumAttentionView.h"
@class LQSMainView;
@protocol LQSMainViewDelegate <NSObject>

- (void)mainViewScroll:(LQSMainView *)mainView index:(int)index;

@end

@interface LQSMainView : UICollectionView
@property (nonatomic, weak) id<LQSMainViewDelegate> idelegate;
////leftView的数据数组
//@property (nonatomic,strong)NSMutableArray *leftDataArray;
////rightView的数据数组
//@property (nonatomic,strong)NSMutableArray *rightDataArray;
@property (nonatomic, strong) LQSLatestMarrowTableView *latestView;//最新页面
@property (nonatomic, strong) LQSLatestMarrowTableView *marrowView;//精华页面

@end


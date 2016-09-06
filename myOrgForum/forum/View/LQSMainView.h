//
//  LQSMainView.h
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
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

@end


//
//  LQSLeftTableView.h
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQSLeftTableView;
@protocol LQSLeftTableViewDelegate <NSObject>

@required
//点击我的关注页面数据传递
- (void)leftTableView:(LQSLeftTableView *)leftTableView rightViewFocusArray:(NSMutableArray *)rightViewFocusArray allDataArray:(NSMutableArray *)allDataArray;

//点击其余四个板块数据传递
- (void)leftTableView:(LQSLeftTableView *)leftTableView rightViewArray:(NSMutableArray *)rightViewArray allDataArray:(NSMutableArray *)allDataArray;

@end
@interface LQSLeftTableView : UITableView
@property (nonatomic, weak) id<LQSLeftTableViewDelegate> leftViewDelegate;


@end


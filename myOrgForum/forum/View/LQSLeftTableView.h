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
- (void)leftTableView:(LQSLeftTableView *)leftTableView rightViewArray:(NSMutableArray *)rightViewArray;

- (void)leftTableView:(LQSLeftTableView *)leftTableView rightViewFocusArray:(NSMutableArray *)rightViewFocusArray;

@end
@interface LQSLeftTableView : UITableView
@property (nonatomic, weak) id<LQSLeftTableViewDelegate> leftViewDelegate;


@end


//
//  LQSLatestMarrowTableView.h
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQSLatestMarrowTableView,LQSBBSDetailViewController;
@protocol LQSLatestMarrowTableViewDelegate <NSObject>

- (void)latestMarrowTableView:(LQSLatestMarrowTableView *)latestMarrowTableView detailVc:(LQSBBSDetailViewController *)dvc;

@end

@interface LQSLatestMarrowTableView : UITableView
@property (nonatomic, strong) NSString *sortby;
@property (nonatomic, weak) id<LQSLatestMarrowTableViewDelegate> idelegate;
@end

//
//  LQSDiscoverBaseTableViewController.h
//  myOrgForum
//
//  Created by g x on 2017/7/18.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LQSDiscoverBaseTableViewDelegate <NSObject>

@required
- (void)tableViewScroll:(UITableView *)tableView offsetY:(CGFloat)offsetY;
@end

@interface LQSDiscoverBaseTableViewController : UITableViewController

@property (nonatomic,weak)id <LQSDiscoverBaseTableViewDelegate> delegate;

- (void)prepareNetDataForBorderId:(NSString *)boardId
                          success:(void (^)())success
                          failure:(void (^)())failure;
@end

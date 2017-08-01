//
//  LQSRightTableView.h
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSRightTableView : UITableView
@property (nonatomic, strong) NSMutableArray *rightDataArray;
@property (nonatomic, strong) NSMutableArray *notFocusArray;//没有点击关注的数据
@property (nonatomic, strong) NSMutableArray *allFocusArray;//所有论坛版块的数据
@property (nonatomic, assign) int sectionNum;
@end

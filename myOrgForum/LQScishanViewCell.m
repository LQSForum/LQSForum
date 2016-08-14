
//
//  LQScishanViewCell.m
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQScishanViewCell.h"
@class LQSCishanStatusTopView;
@class LQSCishanStatusToolBar;
@interface LQScishanViewCell()
/** 顶部的view */
@property (nonatomic, weak) LQSCishanStatusTopView *topView;

/** 底部的工具条 */
@property (nonatomic, weak)  LQSCishanStatusToolBar*toolbar;
@end
@implementation LQScishanViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    LQScishanViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LQScishanViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // 添加所有需要显示的子控件
        
        // 1.添加顶部的控件
        [self setupTopView];
        
        // 2.添加底部的工具条
        [self setupToolbar];
    }
    return self;
}

/**
 *  添加顶部的控件
 */
- (void)setupTopView
{
    LQSCishanStatusTopView *topView = [[LQSCishanStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

/**
 *  添加底部的工具条
 */
- (void)setupToolbar
{
    LQSCishanStatusToolBar *toolbar = [[LQSCishanStatusToolBar alloc] init];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 *  设置frame数据
 */
- (void)setStatusFrame:(LQSCishanModelFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.传递数据给topView
    self.topView.cishanStatusFrame = statusFrame;
    
    // 2.设置toolbar的frame
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.cishanStatus = statusFrame.cishanStatus;
}

@end

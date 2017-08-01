


//
//  LQSSpecifyHeader.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSSpecifyHeader.h"

@implementation LQSSpecifyHeader

- (void)prepare
{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.textColor = [UIColor blueColor];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开就可以刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"哥正在帮你刷新。。。"forState:MJRefreshStateRefreshing ];
//    自动调整透明度
    self.automaticallyChangeAlpha = YES;





}

@end

//
//  LQSdashangSecView.m
//  myOrgForum
//  功能:  打赏页的section0的headerView
//  Created by Queen_B on 2016/11/13.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSdashangSecView.h"
#import "LQSAddViewHelper.h"
@implementation LQSdashangSecView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    // 评分:
    UILabel *pinglabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    pinglabel.text = @"评分";
    pinglabel.backgroundColor = [UIColor redColor];
//    [pinglabel sizeToFit];
    pinglabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:pinglabel];
    // 评分区间
    UILabel *qujianLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 120, 0, 40, 60)];
    qujianLabel.backgroundColor = [UIColor yellowColor];
    qujianLabel.text = @"评分区间";
    qujianLabel.numberOfLines = 0;
    qujianLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:qujianLabel];
    // 今日剩余
    UILabel *shengyuLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 50, 0, 40, 60)];
    shengyuLabel.backgroundColor = [UIColor blueColor];
    shengyuLabel.text = @"今日剩余";
    shengyuLabel.numberOfLines = 0;
    shengyuLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:shengyuLabel];

}
@end

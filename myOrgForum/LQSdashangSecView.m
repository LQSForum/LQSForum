//
//  LQSdashangSecView.m
//  myOrgForum
//  功能:  打赏页的section0的headerView
//  Created by Queen_B on 2016/11/13.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//  具体控件距离，尺寸等还需要调整。

#import "LQSdashangSecView.h"
#import "LQSAddViewHelper.h"
@implementation LQSdashangSecView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}
- (void)setupViews{
    switch (self.headerOrFooter) {
        case header:
            [self setupHeaderView];
            break;
        case footer:
            [self setupFooterView];
            break;
        default:
            break;
    }
    
}
- (void)setupHeaderView{
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
-(void)setupFooterView{
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.cornerRadius = 5;
    sureBtn.backgroundColor = [UIColor greenColor];
}
- (void)sureBtnClick:(UIButton *)sender{
    if (self.sureBtnclkBlock) {
        self.sureBtnclkBlock(sender);
    }
}
@end

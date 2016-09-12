//
//  LQSForumDetailHeadView.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailHeadView.h"
#import "UIColor+Hex.h"
#import "LQSHttpsRequest.h"
@interface LQSForumDetailHeadView(){
}
@property (nonatomic, readwrite, retain) IBOutlet UIImageView *mainImageView;
@property (nonatomic, readwrite, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, readwrite, retain) IBOutlet UILabel *introLabel;
@property (nonatomic, readwrite, retain) IBOutlet UILabel *subTitleLabel;
@property (nonatomic, readwrite, retain) IBOutlet UILabel *todayNumLabel;
@property (nonatomic, readwrite, retain) IBOutlet UIButton *followButton;
@end
@implementation LQSForumDetailHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    [_followButton setBackgroundImage:[UIImage imageWithColor:[UIColor lqs_themeColor]] forState:UIControlStateNormal];
    UIImage* image = [UIImage imageWithColor:[UIColor lightGrayColor]];
    [_followButton setBackgroundImage:image forState:UIControlStateSelected];
    [_followButton setBackgroundImage:image forState:UIControlStateSelected|UIControlStateHighlighted];
}
- (void)setModel:(LQSForumDetailForumInfoModel *)model{
    _model = model;
    _titleLabel.text = model.title;
    _introLabel.text = model.desc;
    _followButton.selected = model.isFocus;
    _subTitleLabel.text = [NSString stringWithFormat:@"主题:%zd",model.postsTotalNum];
    _todayNumLabel.text = [NSString stringWithFormat:@"今日:%zd",model.tdPostsNum];
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
}

- (IBAction)followButtonClick:(UIButton *)sender{
    NSString* action = @"favorite";
    if (self.model.isFocus) {
        action = @"delfavorite";
    }
    NSDictionary *dict = @{@"action":action,
                           @"idType":@"fid",
                           @"apphash":@"1de934cc",
                           @"id": @(self.model.fid) ?: @"",
                           @"accessToken":@"7e3972a7a729e541ee373e7da3d06",
                           @"accessSecret":@"39a68e4d5473e75669bce2d70c4b9",
                           @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                           @"egnVersion":@"v2035.2",
                           @"sdkVersion":@"2.4.3.0"};
    __weak typeof(self) weakSelf = self;
    [[LQSHttpsRequest new] POST:@"http://forum.longquanzs.org//mobcent/app/web/index.php?r=user/userfavorite" parameters:dict success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        if ([dict[@"rs"] integerValue] == 1) {
            weakSelf.model.isFocus ^= 1;
            if (weakSelf.model.isFocus) {
                [kAppDelegate showHUDMessage:@"关注成功" hideDelay:1.0];
                sender.selected = YES;
            }
            else{
                sender.selected = NO;
                [kAppDelegate showHUDMessage:@"取消关注成功" hideDelay:1.0];
            }
        }
    } failure:^(NSError *error) {
        LQSLog(@"error%@",error);
        kNetworkNotReachedMessage;
    }];
}

@end


//
//  LQSRightViewCell.m
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSRightViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "LQSUserManager.h"
#define LQSForumTextSize 14

@interface LQSRightViewCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *favIcon;
@property (nonatomic, strong) UILabel *favNum;
@property (nonatomic, strong) UIImageView *contentIcon;
@property (nonatomic, strong) UILabel *contentNum;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *focusBtn;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation LQSRightViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        
    }
    
    return self;
    
}

- (void)setUpUI{
    
    self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 56, 56)];
    self.icon.backgroundColor = [UIColor lightGrayColor];
    
    //设置图片圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.icon.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.icon.bounds;
    maskLayer.path = maskPath.CGPath;
    self.icon.layer.mask = maskLayer;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:LQSForumTextSize];
    //        self.titleLabel.backgroundColor = [UIColor redColor];
    [self.titleLabel sizeToFit];
    
    self.favIcon = [[UIImageView alloc]init];
    self.favIcon.image = [UIImage imageNamed:@"dz_board_icon_follow"];
    
    self.favNum = [[UILabel alloc]init];
    self.favNum.font = [UIFont systemFontOfSize:10];
    self.favNum.textColor = [UIColor lightGrayColor];
    [self.favNum sizeToFit];
    
    self.contentIcon = [[UIImageView alloc]init];
    self.contentIcon.image = [UIImage imageNamed:@"dz_board_icon_reply"];
    
    self.contentNum = [[UILabel alloc]init];
    self.contentNum.font = [UIFont systemFontOfSize:10];
    self.contentNum.textColor = [UIColor lightGrayColor];
    [self.contentNum sizeToFit];
    
    self.focusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.focusBtn.backgroundColor = LQSColor(1, 183, 237, 1.0);
    [self.focusBtn setTintColor:[UIColor whiteColor]];
    self.focusBtn.titleLabel.font = [UIFont systemFontOfSize:LQSForumTextSize];
    [self.focusBtn.layer setMasksToBounds:YES];
    [self.focusBtn.layer setCornerRadius:2.0];
    [self.focusBtn addTarget:self action:@selector(selectedFocusBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.favIcon];
    [self.contentView addSubview:self.favNum];
    [self.contentView addSubview:self.contentIcon];
    [self.contentView addSubview:self.contentNum];
    [self.contentView addSubview:self.focusBtn];
    
    [self settingFrame];
}


- (void)settingFrame{
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(18);
    }];
    
    [self.favIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
    
    [self.favNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favIcon.mas_right).offset(5);
        make.bottom.equalTo(self.favIcon.mas_bottom);
    }];
    
    [self.contentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favNum.mas_right).offset(10);
        make.top.equalTo(self.favIcon.mas_top);
        make.width.equalTo(@15);
        make.height.equalTo(@15);

    }];
    
    [self.contentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentIcon.mas_right).offset(5);
        make.bottom.equalTo(self.favNum.mas_bottom);
        
    }];
    
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.contentView.mas_top).offset(13);
        make.width.equalTo(@50);
    }];
    
}

- (void)setCellModel:(LQSCellModel *)cellModel{
    
    _cellModel = cellModel;
    self.titleLabel.text = cellModel.board_name;
    self.favNum.text = [NSString stringWithFormat:@"%zd",cellModel.favNum];
    //    LQSLog(@"%@",cellModel.last_posts_date);
    NSURL *url = [NSURL URLWithString:cellModel.board_img];
    [self.icon sd_setImageWithURL:url];
    self.contentNum.text = [NSString stringWithFormat:@"%zd",cellModel.td_posts_num];
    if ([self.addFocusArrayBoardID containsObject:@(cellModel.board_id)]) {
        [self.focusBtn setBackgroundColor:[UIColor lightGrayColor]];
        [self.focusBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.focusBtn.selected = YES;
    }else{
        [self.focusBtn setBackgroundColor:LQSColor(1, 183, 237, 1.0)];
        [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
        self.focusBtn.selected = NO;
    }
    
}


- (void)selectedFocusBtn:(UIButton *)sender{
    self.cellModel.is_focus = !sender.isSelected;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *state = [user objectForKey:@"userLoginState"];
//    NSLog(@"%@",state);
//    if ([state isEqualToString:@"FALSE"]) {
//        
//        LQLoginViewController *loginVc = [LQLoginViewController new];
//        LQSNavigationController *navVC = [[LQSNavigationController alloc] initWithRootViewController:loginVc];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"loginVC" object:navVC];
//    }else{
    
        if (self.cellModel.is_focus == 1) {
            [self changeFocusStateWithFocusString:@"favorite" boardId:self.cellModel.board_id];
            [self.focusBtn setTitle:@"取消" forState:UIControlStateNormal];
            [kAppDelegate showHUDMessage:@"关注成功!" hideDelay:1.0];
            if ([self.delegate respondsToSelector:@selector(rightViewAddFocus:)]) {
                [self.delegate rightViewAddFocus:self];
            }
        }else{
            [self changeFocusStateWithFocusString:@"delfavorite" boardId:self.cellModel.board_id];
            [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
            [kAppDelegate showHUDMessage:@"取消关注成功!" hideDelay:1.0];
            if ([self.delegate respondsToSelector:@selector(rightViewCancleFocus:)]) {
                [self.delegate rightViewCancleFocus:self];
                
            }
            
        }
//    }
    
}

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        //        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        //        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSSet *set = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
        _sessionManager.responseSerializer.acceptableContentTypes = [_sessionManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
    }
    return _sessionManager;
}

- (void)changeFocusStateWithFocusString:(NSString *)focusString boardId:(NSInteger)boardId{
    
    NSString *urlString = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=user/userfavorite";
    NSDictionary *parameters = @{@"accessSecret":@"f24c29a8120733daf65db8635f049",
                                 @"accessToken":@"9681504c5bd171bdc02c2f66a4dee",
                                 @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                 @"sdkVersion":@"2.4.3.0",
                                 @"apphash":@"8f34970d",
                                 @"idType":@"fid",
                                 @"action":focusString,
                                 @"id":@(boardId)
                                 };
    [self.sessionManager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSData *data = responseObject;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        //        NSString *p = @"/Users/yuhan/Desktop/plist";
        //        NSString *path = [p stringByAppendingPathComponent:@"forum.plist"];
        //        [dict writeToFile:path atomically:YES];
        LQSLog(@"%@",dict);
        //        LQSLog(@"%s", __FUNCTION__);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        [self.mj_header endRefreshing];
        NSLog(@"error%@",error);
        
    }];
    
    
}



- (NSMutableArray *)addFocusArrayBoardID{
    if (_addFocusArrayBoardID == nil) {
        _addFocusArrayBoardID = [NSMutableArray array];
    }
    return _addFocusArrayBoardID;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

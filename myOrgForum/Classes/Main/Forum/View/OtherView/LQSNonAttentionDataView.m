//
//  LQSNonAttentionDataView.m
//  myOrgForum
//
//  Created by 昱含 on 2017/6/17.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSNonAttentionDataView.h"

@interface LQSNonAttentionDataView ()

/** 图片背景 */
@property (nonatomic, strong) UIView *pictureView;
/** 图片 */
@property (nonatomic, strong) UIImageView *picture;
/** 猜你喜欢背景 */
@property (nonatomic, strong) UIView *likeView;
/** 猜你喜欢图片 */
@property (nonatomic, strong) UIButton *likeBtn;
/** 猜你喜欢横线 */
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;


@end

@implementation LQSNonAttentionDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor lqs_colorWithHexString:@"#d8d8d8"];
        [self addSubview:self.pictureView];
        [self.pictureView addSubview:self.picture];
        [self addSubview:self.likeView];
        [self.likeView addSubview:self.likeBtn];
        [self.likeView addSubview:self.line1];
        [self.likeView addSubview:self.line2];
        [self setupFrame];
    }
    
    return self;
}

- (void)setupFrame
{
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(220);
    }];
    
    [self.picture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.pictureView);
    }];
    
    [self.likeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pictureView.mas_bottom).offset(5);
        make.left.right.bottom.equalTo(self);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.likeView.mas_centerX);
        make.top.equalTo(self.likeView.mas_top).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeView.mas_left).offset(10);
        make.right.equalTo(self.likeBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.likeBtn.mas_centerY);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeBtn.mas_right).offset(10);
        make.right.equalTo(self.likeView.mas_right).offset(-10);
        make.centerY.equalTo(self.likeBtn.mas_centerY);
    }];
}

- (UIView *)pictureView
{
    if (_pictureView == nil) {
        _pictureView = [[UIView alloc] init];
        _pictureView.backgroundColor = [UIColor whiteColor];
    }
    return _pictureView;
}

- (UIImageView *)picture
{
    if (_picture == nil) {
        _picture = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topic_follow_list_noData_empty"]];
    }
    return _picture;
}

- (UIView *)likeView
{
    if (_likeView == nil) {
        _likeView = [[UIView alloc] init];
        _likeView.backgroundColor = [UIColor whiteColor];
    }
    return _likeView;
}

- (UIButton *)likeBtn
{
    if (_likeBtn == nil) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"topic_follow_list_noData_love"] forState:UIControlStateNormal];
        [_likeBtn setTitle:@"猜你喜欢" forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = kSystemFont(18);
    }
    return _likeBtn;
}



- (UIView *)line1
{
    if (_line1 == nil) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor lightGrayColor];
    }
    return _line1;
}

- (UIView *)line2
{
    if (_line2 == nil) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor lightGrayColor];
    }
    return _line2;
}

@end

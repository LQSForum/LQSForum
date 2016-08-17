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
#define LQSForumTextSize 14

@interface LQSRightViewCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *favIcon;
@property (nonatomic, strong) UILabel *favNum;
@property (nonatomic, strong) UIImageView *contentIcon;
@property (nonatomic, strong) UILabel *contentNum;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *focusBtn;

@end

@implementation LQSRightViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
        self.favIcon.image = [UIImage imageNamed:@"tab_setting_common"];
        
        self.favNum = [[UILabel alloc]init];
        self.favNum.font = [UIFont systemFontOfSize:LQSForumTextSize];
        self.favNum.textColor = [UIColor lightGrayColor];
        [self.favNum sizeToFit];
        
        self.contentIcon = [[UIImageView alloc]init];
        self.contentIcon.image = [UIImage imageNamed:@"tab_introduce_common"];
        
        self.contentNum = [[UILabel alloc]init];
        self.contentNum.font = [UIFont systemFontOfSize:LQSForumTextSize];
        self.contentNum.textColor = [UIColor lightGrayColor];
        [self.contentNum sizeToFit];
        
        self.focusBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.focusBtn.backgroundColor = [UIColor blueColor];
        [self.focusBtn setTintColor:[UIColor whiteColor]];
        [self.focusBtn.layer setMasksToBounds:YES];
        [self.focusBtn.layer setCornerRadius:2.0];
        
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.favIcon];
        [self.contentView addSubview:self.favNum];
        [self.contentView addSubview:self.contentIcon];
        [self.contentView addSubview:self.contentNum];
        [self.contentView addSubview:self.focusBtn];
        
        
    }
    
    return self;
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    [self.favIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        //        make.width.equalTo(@10);
        //        make.height.equalTo(@(self.favIcon.image.size.height/self.favIcon.image.size.width * self.favIcon.image.size.width));
    }];
    
    [self.favNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favIcon.mas_right).offset(5);
        make.bottom.equalTo(self.favIcon.mas_bottom);
    }];
    
    [self.contentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favNum.mas_right).offset(10);
        make.top.equalTo(self.favIcon.mas_top);
        //        make.width.equalTo(@10);
        //        make.height.equalTo(@(self.favIcon.image.size.height/self.favIcon.image.size.width * self.favIcon.image.size.width));
    }];
    
    [self.contentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentIcon.mas_right).offset(5);
        make.bottom.equalTo(self.favNum.mas_bottom);
        
    }];
    
    [self.focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.width.equalTo(@40);
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
    [self.focusBtn setTitle:@"关注" forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//
//  LQSLatestMarrowTableViewCell.m
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSLatestMarrowTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface LQSLatestMarrowTableViewCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *marrowIcon;
@property (nonatomic, strong) UILabel *lastReplyDate;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation LQSLatestMarrowTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        self.contentView.backgroundColor = [UIColor yellowColor];
        self.icon = [[UIImageView alloc]init];
        self.lastReplyDate = [[UILabel alloc]init];
        self.titleLabel = [[UILabel alloc]init];
        self.nameLabel = [[UILabel alloc]init];
        self.contentLabel = [[UILabel alloc]init];
        self.marrowIcon = [[UIImageView alloc]init];
        
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lastReplyDate];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        //        [self.contentView addSubview:self.marrowIcon];
        
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@100);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.icon.mas_left).offset(-10);
    }];
    
    [self.lastReplyDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.titleLabel);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lastReplyDate.mas_right).offset(20);
        make.bottom.equalTo(self.lastReplyDate.mas_bottom);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.nameLabel.mas_right).offset(30);
        
    }];
    
}

- (void)setModel:(LQSLastestMarrowModel *)model{
    _model = model;
    NSURL *url = [NSURL URLWithString:model.pic_path];
    [self.icon sd_setImageWithURL:url];
    self.titleLabel.text = model.title;
    self.titleLabel.numberOfLines = 0;
    self.lastReplyDate.text = model.last_reply_date;
    self.nameLabel.text = model.user_nick_name;
    self.contentLabel.text = [NSString stringWithFormat:@"%zd",model.replies];
    [self.nameLabel sizeToFit];
    [self.contentLabel sizeToFit];
    [self.lastReplyDate sizeToFit];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

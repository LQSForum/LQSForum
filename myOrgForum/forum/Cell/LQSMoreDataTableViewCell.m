//
//  LQSMoreDataTableViewCell.m
//  myOrgForum
//
//  Created by a on 16/9/7.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSMoreDataTableViewCell.h"

@interface LQSMoreDataTableViewCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *lastReplyDate;
@property (nonatomic, strong) UILabel *readLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *marrowImage;

@end

@implementation LQSMoreDataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        
    }
    
    return self;
    
}

- (void)setUpUI{
    
    self.icon = [[UIImageView alloc]init];
    self.lastReplyDate = [[UILabel alloc]init];
    self.titleLabel = [[UILabel alloc]init];
    self.nameLabel = [[UILabel alloc]init];
    self.readLabel = [[UILabel alloc]init];
    self.marrowImage = [[UIImageView alloc]init];
    self.nameLabel.font = [UIFont systemFontOfSize:10.0];
    self.lastReplyDate.font = [UIFont systemFontOfSize:10.0];
    self.readLabel.font = [UIFont systemFontOfSize:10.0];
    self.titleLabel.font = [UIFont systemFontOfSize:18.0];
    self.nameLabel.textColor = [UIColor lightGrayColor];
    self.lastReplyDate.textColor = [UIColor lightGrayColor];
    self.readLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.lastReplyDate];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.readLabel];
    [self.contentView addSubview:self.marrowImage];
    
    [self settingFrame];
    
    
}

- (void)settingFrame{
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@100);
    }];
    
    [self.marrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.height.equalTo(@20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.marrowImage.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.icon.mas_left).offset(-10);
    }];
    
    [self.lastReplyDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lastReplyDate.mas_right).offset(80);
        make.bottom.equalTo(self.lastReplyDate.mas_bottom);
    }];
    
    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.icon.mas_left).offset(-10);
        
    }];
    
    
    
}

- (void)setModel:(LQSForumDetailListModel *)model{
    _model = model;
    NSURL *url = [NSURL URLWithString:model.picPath];
    //    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.titleLabel.text = model.title;
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10.0];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.titleLabel.text length])];
    self.titleLabel.attributedText = attributedString;
    [self.titleLabel sizeToFit];
    self.lastReplyDate.text = [model last_posts_date];
    self.nameLabel.text = model.userNickName;
    self.readLabel.text = [NSString stringWithFormat:@"%zd阅读",model.hits];
    [self.nameLabel sizeToFit];
    [self.readLabel sizeToFit];
    [self.lastReplyDate sizeToFit];
    
    
    
    if (model.essence == 1) {
        
        self.marrowImage.image = [UIImage imageNamed:@"marrow"];
        
        
    }else{
        
        self.marrowImage.image = [UIImage imageNamed:@"top"];
    }
    
    if (model.picPath.length > 0) {
        self.icon.hidden = NO;
        [self.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"dz_icon_article_default"]];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.marrowImage.mas_right).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.icon.mas_left).offset(-10);
        }];
        
    }else{
        self.icon.hidden = YES;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.marrowImage.mas_right).offset(10);
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            
        }];
        
    }
    
}


@end

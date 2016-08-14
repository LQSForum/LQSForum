//
//  LQSCishanStatusOriginView.m
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCishanStatusOriginView.h"
@interface LQSCishanStatusOriginView()
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 配图(相册) */
@property (nonatomic, weak) LQSPhotosView *photosView;
@end

@implementation LQSCishanStatusOriginView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        /** 1.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 2.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 3.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 4.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textColor = [UIColor orangeColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 5.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = [UIFont systemFontOfSize:12];
        sourceLabel.textColor = [UIColor grayColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 6.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.font = [UIFont systemFontOfSize:16];
        contentLabel.numberOfLines = 0;
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /** 7.配图 */
        LQSPhotosView *photosView = [[LQSPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setStatusFrame:(LQSCishanModelFrame *)statusFrame
{
    self.cishanStatusFrame = statusFrame;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置frame
    [self setupFrame];
}
/**
 *  设置frame
 */
- (void)setupFrame
{
    self.frame = self.cishanStatusFrame.originalViewF;
    
    /** 1.头像 */
    self.iconView.frame = self.cishanStatusFrame.iconViewF;
    
    /** 2.会员图标 */
    self.vipView.frame = self.cishanStatusFrame.vipViewF;
    
    /** 3.昵称 */
    self.nameLabel.frame = self.cishanStatusFrame.nameLabelF;
    
    /** 4.时间 */
    self.timeLabel.x = self.nameLabel.x;
    self.timeLabel.y = CGRectGetMaxY(self.nameLabel.frame) + 10 * 0.5;
    NSString *time = self.cishanStatusFrame.cishanStatus.last_reply_date;
    self.timeLabel.size = [time sizeWithFont:[UIFont systemFontOfSize:12]];
    
    /** 5.来源 */
    self.sourceLabel.x = CGRectGetMaxX(self.timeLabel.frame) + 10;
    self.sourceLabel.y = self.timeLabel.y;
    NSString *source = self.cishanStatusFrame.cishanStatus.board_name;
    self.sourceLabel.size = [source sizeWithFont:[UIFont systemFontOfSize:12]];
    
    /** 6.正文\内容 */
    self.contentLabel.frame = self.cishanStatusFrame.contentLabelF;
    
    /** 7.配图 */
    self.photosView.frame = self.cishanStatusFrame.photosViewF;
}

/**
 *  设置数据
 */
- (void)setupData
{
    LQSCishanListModel *cishanStatus = self.cishanStatusFrame.cishanStatus;
    
    /** 1.头像 */
    NSURL *iconUrl = [NSURL URLWithString:cishanStatus.userAvatar];
    [self.iconView setImageWithURL:iconUrl placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    
    /** 3.昵称 */
    self.nameLabel.text = cishanStatus.user_nick_name;
    
    /** 4.时间 */
    self.timeLabel.text = cishanStatus.last_reply_date;
    
    /** 5.来源 */
    self.sourceLabel.text = cishanStatus.board_name;
    
    /** 6.正文\内容 */
    self.contentLabel.text = cishanStatus.summary;
    
    /** 7.配图 */
    self.photosView.photos = cishanStatus.imageList;
}

@end

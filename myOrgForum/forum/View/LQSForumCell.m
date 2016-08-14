//
//  LQSForumCell.m
//  myOrgForum
//
//  Created by 昱含 on 16/7/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumCell.h"
#import <AVFoundation/AVFoundation.h>
#define LQSForumTextSize 14

@interface LQSForumCell ()

@property (nonatomic, strong) UIImageView *icon;
//cell标题
@property (nonatomic, strong) UILabel *titleLabel;
//更新时间
@property (nonatomic, strong) UILabel *timeLabel;
//更新数量
@property (nonatomic, strong) UILabel *latestCountLbl;

@end

@implementation LQSForumCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
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
        [self.titleLabel sizeToFit];
//        self.titleLabel.backgroundColor = [UIColor redColor];

        
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:LQSForumTextSize];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        [self.timeLabel sizeToFit];
//        self.timeLabel.backgroundColor = [UIColor blueColor];

        
        self.latestCountLbl = [[UILabel alloc]init];
        self.latestCountLbl.font = [UIFont systemFontOfSize:LQSForumTextSize];
        self.latestCountLbl.textColor = LQSColor(1, 183, 237,1);
        [self.latestCountLbl sizeToFit];
//        self.latestCountLbl.backgroundColor = [UIColor yellowColor];

        
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.latestCountLbl];
    }
    
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(15);
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    
    [self.latestCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.titleLabel.mas_top);
    }];
    
}

- (void)setCellModel:(LQSCellModel *)cellModel{
    
    _cellModel = cellModel;
    
    self.titleLabel.text = cellModel.board_name;
    self.timeLabel.text = cellModel.last_posts_date;
//    LQSLog(@"%@",cellModel.last_posts_date);
    NSURL *url = [NSURL URLWithString:cellModel.board_img];
    [self.icon sd_setImageWithURL:url];
    
    //更新数据的隐藏与显示
    if (cellModel.td_posts_num == 0) {
        self.latestCountLbl.hidden = YES;
    }else{
        self.latestCountLbl.hidden = NO;
        self.latestCountLbl.text = [NSString stringWithFormat:@"(%zd)",cellModel.td_posts_num];
    }
}
@end

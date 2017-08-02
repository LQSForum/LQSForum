//
//  LQSLeftViewCell.m
//  myOrgForum
//
//  Created by a on 16/9/8.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSLeftViewCell.h"

#define LQSColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface LQSLeftViewCell ()


/** 版块主题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** cell横线 */
@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation LQSLeftViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.bottomLineView];
        [self createView];
    }
    return self;
}

- (void)createView {
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.bottom.right.equalTo(self.contentView);
        make.height.equalTo(@0.3);
    }];
    
}

- (void)setIsSelected:(BOOL)isSelected {
    if (isSelected) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = LQSColor(106, 133, 196, 1.0);
        self.titleLabel.font = [UIFont systemFontOfSize:16.0];
        
    } else {
        
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.titleLabel.backgroundColor = LQSColor(235, 235, 235, 1.0);
        self.backgroundColor = LQSColor(235, 235, 235, 1.0);
        
    }
    
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return _titleLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLineView;
}





@end

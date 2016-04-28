//
//  LQSRootTableViewCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSRootTableViewCell.h"
#import "UIView+Extension.h"
@implementation LQSRootTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier   ];
    if (self) {
        [self setup];
        [self loadSubViews];
    }


    return self;

}

- (void)awakeFromNib {
    [self setup];
    [self loadSubViews];
    // Initialization code
}

- (void)dealloc
{
    [LQSNotificationCenter removeObserver:self];

}

- (void)setup{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.separatorInset = UIEdgeInsetsZero;
    if (kios8System) {
        self.layoutMargins = UIEdgeInsetsZero;
    }


}

- (void)loadSubViews
{


}

- (void)layoutSubviews
{

    [super layoutSubviews];
    for (UIView *subView in self.contentView.superview.subviews) {
        if ([NSStringFromClass(subView.class) hasPrefix:@"SeparatorView"]) {
            subView.height = 0.5;
            subView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
            subView.hidden = NO;
        }
    }

}




@end

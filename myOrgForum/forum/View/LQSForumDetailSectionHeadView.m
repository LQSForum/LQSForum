//
//  LQSForumDetailSectionHeadView.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailSectionHeadView.h"

@interface LQSForumDetailSectionHeadView(){
    NSInteger   _tab;
}
@property (strong, nonatomic) IBOutlet UIButton *allButton;
@property (strong, nonatomic) IBOutlet UIButton *newsButton;
@property (strong, nonatomic) IBOutlet UIButton *essButton;
@property (strong, nonatomic) IBOutlet UIButton *sonButton;
@property (strong, nonatomic) IBOutlet UIView *indicatorView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *indicatorLayoutConstraint;

@end

@implementation LQSForumDetailSectionHeadView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self bringSubviewToFront:_indicatorView];
    _allButton.selected = YES;
}

- (void)removeSubForum{
    [_sonButton removeFromSuperview];
}


- (IBAction)buttonClick:(UIButton *)sender {
    if (_tab == sender.tag-100) {
        return;
    }
    _tab = sender.tag-100;
    sender.selected = YES;
    for (UIView* item in self.subviews) {
        if ([item isKindOfClass:[UIButton class]]) {
            if (item != sender) {
                [(UIButton*)item setSelected:NO];
            }
        }
    }
    [UIView animateWithDuration:0.25f animations:^{
        _indicatorLayoutConstraint.constant = sender.x;
        [self layoutIfNeeded];
    }];
    if ([self.delegate respondsToSelector:@selector(selectTheType:)]) {
        [self.delegate selectTheType:_tab];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

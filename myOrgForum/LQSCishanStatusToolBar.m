
//
//  LQSCishanStatusToolBar.m
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCishanStatusToolBar.h"

@interface LQSCishanStatusToolBar()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;
@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end
@implementation LQSCishanStatusToolBar
- (NSMutableArray *)btns
{
    if (_btns == nil) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置图片
        self.userInteractionEnabled = YES; // 开启用户交互
        
        // 2.添加3个按钮
        self.repostBtn = [self setupBtnWithIcon:@"timeline_icon_retweet" title:@"转发"];
        self.commentBtn = [self setupBtnWithIcon:@"timeline_icon_comment" title:@"评论"];
        self.attitudeBtn = [self setupBtnWithIcon:@"timeline_icon_unlike" title:@"赞"];
        
        // 3.添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

/**
 *  添加按钮
 *
 *  @param icon  图标
 *  @param title 标题
 */
- (UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置高亮时的背景
    btn.adjustsImageWhenHighlighted = NO;
    
    // 设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:btn];
    
    // 添加按钮到数组中
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置按钮的frame
    int btnCount = self.btns.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = 0;
        btn.x = btnW * i;
    }
    
    // 2.设置分割线的frame
    int dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        
        divider.width = 1;
        divider.height = btnH;
        divider.centerX = (i + 1) * btnW;
        divider.centerY = btnH * 0.5;
    }
}

- (void)setCishanStatus:(LQSCishanListModel *)cishanStatus
{

    _cishanStatus = cishanStatus;
    
    //    status.comments_count = 40000; //  4235.6万
    //    status.reposts_count = 116756;  // 11.6万
    //    status.attitudes_count = 78578; // 7.8万
    //
    
    
    // 2.评论
    [self setupBtnTitle:self.commentBtn count:cishanStatus.replies originalTitle:@"评论"];
    
    // 3.赞
    [self setupBtnTitle:self.attitudeBtn count:cishanStatus.hits originalTitle:@"赞"];


}
/**
 *  设置按钮的文字
 *
 *  @param btn           按钮
 *  @param count         按钮需要的数字
 *  @param originalTitle 如果没有数字, 显示什么文字
 */
- (void)setupBtnTitle:(UIButton *)btn count:(int)count originalTitle:(NSString *)originalTitle
{
    if (count) { // 非0, 有数量
        NSString *title = nil;
        
        if (count >= 10000) {
            double countDouble = count / 10000.0;
            
            title = [NSString stringWithFormat:@"%.1f万", countDouble];
            
            // 将字符串中.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        } else { // 不到10000
            title = [NSString stringWithFormat:@"%d", count];
        }
        
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 没有数量
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}


@end

//
//  LQSPluginView.m
//  myOrgForum
//
//  Created by Queen_B on 2016/11/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPluginView.h"

@interface LQSPluginView()
@property (nonatomic,strong)UIButton *picBtn;
@property (nonatomic,strong)UIButton *camBtn;
@property (nonatomic,strong)UIButton *locBtn;
@end
@implementation LQSPluginView

+(instancetype)pluginView{
    return [[self alloc]init];
}
- (void)setupSubViews{
    // 图片按钮
    [self addBtnAtIndex:0 WithNorImg:@"dz_toolbar_reply_picture_n" andHighLImg:@"dz_toolbar_reply_picture_h" andTitle:@"图片" sel:@selector(didSelectBtnAtIndex:) tag:10010];
    // 拍照按钮
    [self addBtnAtIndex:1 WithNorImg:@"dz_toolbar_reply_camera_n" andHighLImg:@"dz_toolbar_reply_camera_h" andTitle:@"拍照" sel:@selector(didSelectBtnAtIndex:) tag:10011];
    // 定位按钮
    [self addBtnAtIndex:2 WithNorImg:@"dz_toolbar_reply_location_n" andHighLImg:@"dz_toolbar_reply_location_h" andTitle:@"定位" sel:@selector(didSelectBtnAtIndex:) tag:10012];

}
/**
 给pluginBoardView添加子按钮控件的初始化方法,根据传入的index值,自动计算btn的位置,宽,高.默认按钮之间的间距为15,每行4个按钮,每页两行.还没有写自动计算页数的方法.

 @param index 子控件的位置.第几个index.从0开始
 @param norImg 按钮的normalImage.
 @param hlImg 按钮的hightlightImg
 @param title 按钮的标题
 @param action 按钮的点击事件
 @param tag 按钮的tag值
 */
- (void)addBtnAtIndex:(NSInteger )index WithNorImg:(NSString *)norImg andHighLImg:(NSString *)hlImg andTitle:(NSString *)title sel:(SEL)action tag:(NSInteger)tag{
    CGFloat btnW = (self.width-15*5)/4;
    CGFloat btnH = (self.height-15*3)/2;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15 +(15 +btnW)*(index%4), 15+(15+btnH)*(index/4), btnW, btnH)];
    [btn setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hlImg] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self.lqsPluginViewDelegate action:action forControlEvents:UIControlEventTouchUpInside];
    [self makeEdgeInsetsWithBtn:btn];
    [self addSubview:btn];
}
- (void)makeEdgeInsetsWithBtn:(UIButton *)btn{
    [btn.titleLabel sizeToFit];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, btn.titleLabel.height, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.height, -(btn.titleLabel.width + btn.width), 0, 0)];
}
- (void)didSelectBtnAtIndex:(UIButton *)selectedBtn{
    if (self.lqsPluginViewDelegate && [self.lqsPluginViewDelegate respondsToSelector:@selector(didSelectBtnAtIndex:)]) {
        [self.lqsPluginViewDelegate didSelectBtnAtIndex:selectedBtn];
    }
   
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"emoticon_keyboard_background"]];
//        [self setupSubViews];
            }
    return self;
}
-(void)addPlugBtn:(UIButton *)btn WithBtnNormImg:(NSString *)normImgName andhightlightImgName:(NSString *)heightlightImgName{
    
    
    
}

@end

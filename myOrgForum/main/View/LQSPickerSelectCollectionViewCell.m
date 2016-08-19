//
//  LQSPickerSelectCollectionViewCell.m
//  myOrgForum
//
//  Created by 宋小宇Mac pro on 16/8/11.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPickerSelectCollectionViewCell.h"

@interface LQSPickerSelectCollectionViewCell ()

@property (nonatomic, strong) UIButton * imgBtn;



@end


@implementation LQSPickerSelectCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupImgBtn];
        [self setupDeleteBtn];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addImage) name:@"image" object:nil];
    }
    return self;
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}



- (void)setupImgBtn
{
    
    self.imgBtn.frame = self.bounds;
    
    [self.imgBtn setBackgroundImage:[UIImage imageNamed:@"dz_publish_add_picture_n"] forState:UIControlStateNormal];
    
    [self addSubview:self.imgBtn];
    
    
    [self.imgBtn addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupDeleteBtn
{

    [self.imgBtn addSubview:self.deleteBtn];
    
    [self.deleteBtn setImage:[UIImage imageNamed:@"dz_posts_vote_del"] forState:UIControlStateNormal];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.imgBtn);
        
    }];
    
    
    [self.deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)imgBtnClick
{
    NSLog(@"点击了添加图片按钮");
    
    // 跳转控制器
    if ([self.delegate respondsToSelector:@selector(jmpPictureSelectedVC:)]) {
        [self.delegate jmpPictureSelectedVC:self];
    }
}

- (void)deleteBtnClick
{
    NSLog(@"点击了删除按钮");
    if ([self.delegate respondsToSelector:@selector(deletePicture:)]) {
        [self.delegate deletePicture:self];
            }
}

-(void)setImg:(UIImage *)img
{
    _img = img;
    
    //改变imgBtn的背景图片为选中的照片
    [self.imgBtn setImage:self.img forState:UIControlStateNormal];
    
}

//- (void)addImage
//{
//    [self.imgBtn setImage:self.img forState:UIControlStateNormal];
//}



#pragma mark - 懒加载
- (UIButton *)imgBtn
{
    if (_imgBtn == nil) {
        
        UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_imgBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        _imgBtn.imageView.clipsToBounds = YES;
        
        _imgBtn = imgBtn;
    }
    return _imgBtn;
}

- (UIButton *)deleteBtn
{
    if (_deleteBtn == nil) {
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn = deleteBtn;
    }
    return _deleteBtn;
}

@end

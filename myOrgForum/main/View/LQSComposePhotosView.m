//
//  LQSComposePhotosView.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSComposePhotosView.h"

@interface LQSComposePhotosView ()

@property(nonatomic,strong) UIButton *addImgBtn;


@end

@implementation LQSComposePhotosView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIButton *addImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addImgBtn = addImgBtn;
        [addImgBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    
        [addImgBtn setBackgroundColor:[UIColor redColor]];
        [self addSubview:addImgBtn];
        
        [addImgBtn addTarget:self action:@selector(addImgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)addImgBtnClick
{
    NSLog(@"添加图片");
    if ([self.delegate respondsToSelector:@selector(jmpPickVC:)]) {
        
        [self.delegate jmpPickVC:self];
    }
    
}
//- (void)addImage:(UIImage *)image
//{
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.clipsToBounds = YES;
//    imageView.image = image;
//    [self addSubview:imageView];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat addImgBtnW = 50;
    CGFloat addImgBtnH = addImgBtnW;
    CGFloat addImgBtnX = 8;
    NSLog(@"-------%f",self.height);
    CGFloat addImgBtnY = (self.height - addImgBtnH) * 0.5;
    self.addImgBtn.frame = CGRectMake(addImgBtnX, addImgBtnY, addImgBtnW, addImgBtnH);

}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    int count = self.subviews.count;
//    // 一行的最大列数
//    int maxColsPerRow = 4;
//    
//    // 每个图片之间的间距
//    CGFloat margin = 10;
//    
//    // 每个图片的宽高
//    CGFloat imageViewW = (self.width - (maxColsPerRow + 1) * margin) / maxColsPerRow;
//    CGFloat imageViewH = imageViewW;
//    
//    for (int i = 0; i<count; i++) {
//        // 行号
//        int row = i / maxColsPerRow;
//        // 列号
//        int col = i % maxColsPerRow;
//        
//        UIImageView *imageView = self.subviews[i];
//        imageView.width = imageViewW;
//        imageView.height = imageViewH;
//        imageView.y = row * (imageViewH + margin);
//        imageView.x = col * (imageViewW + margin) + margin;
//    }
//}
//
//- (NSArray *)images
//{
//    NSMutableArray *array = [NSMutableArray array];
//    for (UIImageView *imageView in self.subviews) {
//        [array addObject:imageView.image];
//    }
//    return array;
//}

@end


//
//  LQSCishanModelFrame.m
//  myOrgForum
//
//  Created by 周双 on 16/8/14.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSCishanModelFrame.h"
#define IWCellMargin 8
// cell的内边距
#define IWCellPadding 10

// 返回最大列数
#define IWPhotosMaxCols(count) ((count == 4) ? 2 : 3)
// 配图
// 1张配图的宽度
#define IWPhotoW 70
// 1张配图的高度
#define IWPhotoH 70
// 配图之间的间距
#define IWPhotoMargin 10
// 返回最大列数
#define IWCellWidth [UIScreen mainScreen].bounds.size.width

@implementation LQSCishanModelFrame

/** 根据数据计算子控件的frame */
- (void)setCishanStatus:(LQSCishanListModel *)cishanStatus
{
    _cishanStatus = cishanStatus;
    
    // 1.计算顶部控件的frame
    [self setupTopViewFrame];
    
    // 2.计算底部工具条的frame
    [self setupToolbarFrame];
    
    // 3.cell的高度
    _cellHeight = CGRectGetMaxY(_toolbarF);

}




/** 根据数据计算子控件的frame */
- (void)setStatus:(LQSCishanListModel *)cishanStatus
{
    _cishanStatus = cishanStatus;
    
    // 1.计算顶部控件的frame
    [self setupTopViewFrame];
    
    // 2.计算底部工具条的frame
    [self setupToolbarFrame];
    
    // 3.cell的高度
    _cellHeight = CGRectGetMaxY(_toolbarF);
}

/**
 *  计算顶部控件的frame
 */
- (void)setupTopViewFrame
{
    // 1.计算原创微博的frame
    [self setupOriginalViewFrame];
    
    // 3.计算顶部控件的frame
    CGFloat topViewH = 0;
        topViewH = CGRectGetMaxY(_originalViewF);
    CGFloat topViewW = kScreenWidth;
    CGFloat topViewX = 0;
    CGFloat topViewY = IWCellMargin;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
}

/**
 *  根据配图的个数计算配图的尺寸
 */
- (CGSize)photosSizeWithCount:(int)photosCount
{
    // 一行最多的列数
    int maxCols = IWPhotosMaxCols(photosCount);
    
    // 列数
    int cols = (photosCount >= maxCols) ? maxCols : photosCount;
    
    // 行数
    int rows = photosCount / maxCols;
    if (photosCount % maxCols != 0) { // 不是maxCols的倍数
        rows++;
    }
    
    // 配图的宽度取决于图片的列数
    // 配图的宽度 == 列数 * IWPhotoW + (列数 - 1) * photoMargin
    CGFloat photosViewW = cols * IWPhotoW + (cols - 1) * IWPhotoMargin;
    
    // 配图的高度取决于图片的行数
    // 配图的高度 == 行数 * IWPhotoH + (行数 - 1) * photoMargin
    CGFloat photosViewH = rows * IWPhotoH + (rows - 1) * IWPhotoMargin;
    
    return CGSizeMake(photosViewW, photosViewH);
}

/**
 *  计算原创微博的frame
 */
- (void)setupOriginalViewFrame
{
    // 1.头像
    CGFloat iconViewX = IWCellPadding;
    CGFloat iconViewY = IWCellPadding;
    CGFloat iconViewW = 35;
    CGFloat iconViewH = 35;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 2.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + IWCellPadding;
    CGFloat nameLabelY = iconViewY;
    
    
    CGSize nameLabelSize = [self.cishanStatus.title sizeWithFont:[UIFont systemFontOfSize:13]];
    _nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    // 3.会员图标
    CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + IWCellPadding;
    CGFloat vipViewY = nameLabelY;
    CGFloat vipViewW = 14;
    CGFloat vipViewH = nameLabelSize.height;
    _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
    // 4.正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF) + IWCellPadding;
    CGFloat contentLabelMaxW = IWCellWidth - 2 * IWCellPadding;
    CGSize contentLabelMaxSize = CGSizeMake(contentLabelMaxW, MAXFLOAT);
    CGSize contentLabelSize = [self.cishanStatus.title sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:contentLabelMaxSize];
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 5.配图
    NSUInteger photosCount = self.cishanStatus.imageList.count;
    CGFloat originalViewH = 0;
    if (photosCount) {
        CGFloat photosViewX = contentLabelX;
        CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + IWCellPadding;
        // 计算配图的尺寸
        CGSize photosViewSize = [self photosSizeWithCount:photosCount];
        _photosViewF = (CGRect){{photosViewX, photosViewY}, photosViewSize};
        
        originalViewH = CGRectGetMaxY(_photosViewF) + IWCellPadding;
    } else { // 没有配图
        originalViewH = CGRectGetMaxY(_contentLabelF) + IWCellPadding;
    }
    
    // 6.原创微博的整体
    CGFloat originalViewX = 0;
    CGFloat originalViewY = 0;
    CGFloat originalViewW = IWCellWidth;
    _originalViewF = CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
}



/**
 *  计算底部工具条的frame
 */
- (void)setupToolbarFrame
{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(_topViewF);
    CGFloat toolbarW = IWCellWidth;
    CGFloat toolbarH = 35;
    _toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}

@end

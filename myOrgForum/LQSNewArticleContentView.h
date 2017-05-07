//
//  LQSNewArticleContentView.h
//  myOrgForum
//
//  Created by g x on 2017/4/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//  注：这个新的类，是代替之前的LQSArticleContentView的，因为那个类使用的是textView的attachment，但是无法随机地显示视频位置。所以改为现在的这个，最简单的笨方法。

#import <UIKit/UIKit.h>
#import "LQSBBSDetailModel.h"

@interface LQSNewArticleContentView : UIView

@property(nonatomic) CGFloat preferredMaxLayoutWidth;
@property(copy, nonatomic) NSArray<LQSBBSContentModel *> *content;
@property (nonatomic,strong)NSMutableArray *picUrlArr;// 用于返回拥有的图片url数组, 也就是type = 1时的图片url,这里type=1并不一定对，我看还有type = 5的类型，暂时先用着1，到时候看情况。
@property (nonatomic,strong)NSMutableArray *ImgArr;// 存储NSTextAttachment里面存储的img,用于在点击时对比，所点击的是第几个。
@property (nonatomic,assign)CGFloat totalH;
@end

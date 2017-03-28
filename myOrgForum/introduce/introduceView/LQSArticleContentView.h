//
//  LQSArticleContentView.h
//  mybaby
//
//  Created by 阿凡树 on 16/8/31.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSBBSDetailModel.h"
@interface LQSArticleContentView : UITextView

@property(nonatomic) CGFloat preferredMaxLayoutWidth;
@property(copy, nonatomic) NSArray<LQSBBSContentModel *> *content;
@property (nonatomic,strong)NSMutableArray *picUrlArr;// 用于返回拥有的图片url数组, 也就是type = 1时的图片url,这里type=1并不一定对，我看还有type = 5的类型，暂时先用着1，到时候看情况。

@end

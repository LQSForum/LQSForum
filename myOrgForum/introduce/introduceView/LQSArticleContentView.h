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

@end

//
//  LQSRotationPictureView.h
//  myOrgForum
//
//  Created by wangbo on 2017/7/19.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSRecommendItemModel.h"

/**
 * 
 */
@interface LQSRotationPictureView : UIView

+ (LQSRotationPictureView *)rotationPicViewWithFrame:(CGRect)rect withImageArray:(NSMutableArray<LQSRecommendItemModel> *)imageArray;

- (instancetype)initWithImageArray:(NSMutableArray<LQSRecommendItemModel> *)imageArray;

@end

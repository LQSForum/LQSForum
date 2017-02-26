//
//  LQSPluginListView.h
//  myOrgForum
//
//  Created by Queen_B on 2016/11/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSPluginListView : UIView
/** 需要展示的pluginView */
@property (nonatomic, strong) NSMutableArray *plugins;
- (void)addPlugBtn:(UIButton *)btn WithBtnNormImg:(NSString *)normImgName andhightlightImgName:(NSString *)heightlightImgName;
@end

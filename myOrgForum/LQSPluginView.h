//
//  LQSPluginView.h
//  myOrgForum
//
//  Created by Queen_B on 2016/11/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSPluginView : UIView
+ (instancetype)pluginView;
- (void)addPlugBtn:(UIButton *)btn WithBtnNormImg:(NSString *)normImgName andhightlightImgName:(NSString *)heightlightImgName;
@end

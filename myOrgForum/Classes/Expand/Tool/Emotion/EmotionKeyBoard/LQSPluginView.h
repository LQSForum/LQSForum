//
//  LQSPluginView.h
//  myOrgForum
//
//  Created by Queen_B on 2016/11/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LQSPluginViewDelegate <NSObject>
- (void)didSelectBtnAtIndex:(UIButton *)selectedBtn;
@end
@interface LQSPluginView : UIView
@property (nonatomic,weak)id <LQSPluginViewDelegate> lqsPluginViewDelegate;
+ (instancetype)pluginView;
- (void)setupSubViews;
- (void)addPlugBtn:(UIButton *)btn WithBtnNormImg:(NSString *)normImgName andhightlightImgName:(NSString *)heightlightImgName;
@end

//
//  LQSdashangSecView.h
//  myOrgForum
//
//  Created by Queen_B on 2016/11/13.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger,headerOrFooter){
    header,
    footer
};
typedef void(^sureBtnClkBlock)(UIButton *);
@interface LQSdashangSecView : UIView
@property (nonatomic,assign)headerOrFooter headerOrFooter;
@property (nonatomic,copy)sureBtnClkBlock sureBtnclkBlock;
- (void)setupViews;
@end

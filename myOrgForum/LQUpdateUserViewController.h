//
//  LQUpdateUserViewController.h
//  myOrgForum
//
//  Created by su on 16/8/9.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "rootViewController.h"

@interface LQUpdateUserViewController : rootViewController
{
    UIButton* secretBtn;   //性别保密
    UIButton* manBtn;      //性别男
    UIButton* womanBtn;    //性别女
    BOOL      IsSelectSecretBtn;
    BOOL      IsSelectManBtn;
    BOOL      IsSelectWomanBtn;
    BOOL      IsUploadingPic;
    UIImageView *selectImageView;
    NSString* savedImagePath ;
    UIAlertView *postImgAlertView;
}
@end

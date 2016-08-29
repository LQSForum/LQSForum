//
//  rootViewController.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/22.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rootViewController : UIViewController
- (void)loadData;
- (void)setUpViews;

- (void)pickerImageFromCameraWithTag:(NSInteger)tag;

- (void)pickerImageFromAlbumWithTag:(NSInteger)tag;

- (void)pickedImage:(UIImage *)image tag:(NSInteger)tag;

@end

//
//  LQSForumDetailOptionViewController.h
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LQSForumDetailOptionDelegate;
@interface LQSForumDetailOptionViewController : UIViewController
@property (nonatomic, readwrite, weak) id<LQSForumDetailOptionDelegate> delegate;

- (CGFloat)contentHeight;
- (void)setContentArray:(NSArray*)array;

@end

@protocol LQSForumDetailOptionDelegate <NSObject>



@end
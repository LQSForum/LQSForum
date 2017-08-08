//
//  LQSDiscoverHeadView.h
//  myOrgForum
//
//  Created by g x on 2017/7/12.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LQSDiscoverHeadViewDelegate <NSObject>

- (void)DiscoverHeadViewClickedHeadBtnWithBoardId:(NSString *)boardId;

@end
@interface LQSDiscoverHeadView : UIView

@property (nonatomic,weak)id <LQSDiscoverHeadViewDelegate> delegate;

@end

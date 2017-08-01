//
//  LQSRightViewCell.h
//  myOrgForum
//
//  Created by a on 16/8/17.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQSCellModel.h"
@class LQSRightViewCell;
@protocol LQSRightViewCellDelegate <NSObject>

- (void)rightViewAddFocus:(LQSRightViewCell *)rightViewCell;
- (void)rightViewCancleFocus:(LQSRightViewCell *)rightViewCell;


@end
@interface LQSRightViewCell : UITableViewCell

@property (nonatomic, strong) LQSCellModel *cellModel;
@property (nonatomic, strong) NSMutableArray *focusArray;
@property (nonatomic, weak) id<LQSRightViewCellDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *addFocusArrayBoardID;

@end
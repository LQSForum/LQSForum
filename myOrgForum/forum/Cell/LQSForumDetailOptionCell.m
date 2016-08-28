//
//  LQSForumDetailOptionCell.m
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSForumDetailOptionCell.h"
@interface LQSForumDetailOptionCell()
@property (strong, nonatomic) IBOutlet UIView *rightLineView;
@end
@implementation LQSForumDetailOptionCell
- (void)setHiddenRightLine:(BOOL)hidden{
    _rightLineView.hidden = hidden;
}
@end

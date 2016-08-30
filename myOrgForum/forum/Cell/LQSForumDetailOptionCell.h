//
//  LQSForumDetailOptionCell.h
//  myOrgForum
//
//  Created by 阿凡树 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQSForumDetailOptionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (void)setHiddenRightLine:(BOOL)hidden;

@end


//
//  LQSWaterFlowViewCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/7/18.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSWaterFlowViewCell.h"

@implementation LQSWaterFlowViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        // Initialization code
    }
    return self;
}




@end

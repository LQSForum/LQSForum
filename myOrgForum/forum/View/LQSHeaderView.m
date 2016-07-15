//
//  LQSHeaderView.m
//  myOrgForum
//
//  Created by 昱含 on 16/7/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSHeaderView.h"

@implementation LQSHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc]init];
        [self addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
//        self.titleLabel.backgroundColor = [UIColor redColor];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self.titleLabel sizeToFit];
    }
    return self;
}

@end

//
//  LQSDiscoverHeadView.m
//  myOrgForum
//
//  Created by g x on 2017/7/12.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSDiscoverHeadView.h"

@interface LQSDiscoverHeadView ()

@property (nonatomic,strong)NSMutableArray *btnsArr;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end
@implementation LQSDiscoverHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews{
    CGFloat btnWidth = kScreenWidth / 4;
    for (NSInteger i = 0; i < 8; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i%4*btnWidth, i/4*btnWidth, btnWidth, btnWidth)];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];
        [btn setImage:[UIImage imageNamed:[NSString  stringWithFormat:@"disc_top_%zd",i]] forState:UIControlStateNormal];
        [self addSubview:btn];
        [self.btnsArr addObject:btn];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)btnClick:(UIButton *)sender{
    
}
#pragma mark - 懒加载
-(NSMutableArray *)btnsArr{
    if (!_btnsArr) {
        _btnsArr = [NSMutableArray array];
    }
    return _btnsArr;
}
@end

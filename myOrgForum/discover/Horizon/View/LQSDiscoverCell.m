//
//  LQSDiscoverCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/7/18.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//这里画cell

#import "LQSDiscoverCell.h"



@interface LQSDiscoverCell()
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *priceLabel;
@end


@implementation LQSDiscoverCell

+ (instancetype)cellWithWaterflowView:(LQSWaterFlowView *)waterflowView
{
    static NSString *ID = @"DISCOVER";
    LQSDiscoverCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[LQSDiscoverCell alloc] init];
        cell.identifier = ID;
    }
    return cell;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.textColor = [UIColor whiteColor];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
    }
    return self;
}



- (void)setShijieDataModel:(LQSShijieDataListModel *)shijieDataModel
{
    _shijieDataModel = shijieDataModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shijieDataModel.pic_path] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    


}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds;
    
    CGFloat priceX = 0;
    CGFloat priceH = 25;
    CGFloat priceY = self.bounds.size.height - priceH;
    CGFloat priceW = self.bounds.size.width;
    self.priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
}

@end


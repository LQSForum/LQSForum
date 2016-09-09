//
//  LQSDiscoverCell.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/7/18.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//这里画cell

#import "LQSDiscoverCell.h"
#define margin 10


@interface LQSDiscoverCell()
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) UILabel *contentLabel;
@property (weak, nonatomic) UILabel *timeLabel;
@property (weak,nonatomic) UILabel *nameLabel;
@property (weak,nonatomic) UILabel *titleLabel;
@property (nonatomic, weak) UIButton * hitsLabel;

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
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        
//        创建点击量控件
        UIButton * hitsLabel = [[UIButton alloc] initWithFrame:CGRectZero];
        self.hitsLabel = hitsLabel;
        hitsLabel.backgroundColor = LQSColor(39, 40, 43, 0.6);
        [imageView addSubview:hitsLabel];
        

//         主题标婷title
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.numberOfLines = 0;
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
//        添加名称
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        [nameLabel setFont:[UIFont systemFontOfSize:11]];

//        添加时间
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        [timeLabel setFont:[UIFont systemFontOfSize:11]];
    }
    return self;
}

- (void)setShijieDataModel:(LQSShijieDataListModel *)shijieDataModel
{
    _shijieDataModel = shijieDataModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shijieDataModel.pic_path] placeholderImage:[UIImage imageNamed:@"loading"]];
    [self.hitsLabel setTitle:shijieDataModel.hits forState:UIControlStateNormal];
    [self.titleLabel setText:shijieDataModel.title];
    [self.nameLabel setText:shijieDataModel.user_nick_name];
    [self.timeLabel setText:[NSString stringWithFormat:@"%@",shijieDataModel.last_reply_date]];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
//    计算contentLabel的高度 = 标题的高度 + 3 * margin + 名称或者时间的高度
//    计算标题的高度
    
    CGSize titleSize = [self sizeWithText:self.shijieDataModel.title font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake((kScreenWidth - 3 * LQSMargin) / 2, MAXFLOAT)];
    
    self.titleLabel.frame = CGRectMake(margin, (kScreenWidth - 3 * LQSMargin) / 2 * self.shijieDataModel.ratio + LQSMargin, (kScreenWidth - 3 * LQSMargin) * 0.5 , titleSize.height);
    self.titleLabel.numberOfLines = 0;
//    用户昵称
    self.nameLabel.frame = CGRectMake(margin, CGRectGetMaxY(self.titleLabel.frame) + LQSMargin, (kScreenWidth - 3 * LQSMargin) * 0.25, 10);
    
    self.timeLabel.frame = CGRectMake((kScreenWidth - 3 * LQSMargin) * 0.25 + 2 *LQSMargin , CGRectGetMaxY(self.titleLabel.frame) + LQSMargin, CGRectGetMaxX(self.titleLabel.frame) - CGRectGetMaxX(self.nameLabel.frame) - LQSMargin, 10);
//    图片frame
        self.imageView.frame = CGRectMake(0, 0, (kScreenWidth - 3 * LQSMargin) / 2,(kScreenWidth - 3 * LQSMargin) / 2 * self.shijieDataModel.ratio ) ;
//点击量label的frame
    self.hitsLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) - LQSMargin - 30 , LQSMargin, 30, 20);
    self.hitsLabel.userInteractionEnabled = NO;
    self.hitsLabel.titleLabel.textAlignment  = NSTextAlignmentCenter;
    [self.hitsLabel.titleLabel setTextColor:[UIColor whiteColor]];
    [self.hitsLabel setFont:[UIFont systemFontOfSize:12]];
    self.hitsLabel.layer.cornerRadius = 5;
    self.contentLabel.frame = CGRectMake(0,self.bounds.size.height - 35,self.bounds.size.width ,35);

    }

- (CGSize)sizeWithText:(NSString *)text
                  font:(UIFont *)font
               maxSize:(CGSize)masxSize{
    
    return [text boundingRectWithSize:masxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    
}

- (CGFloat)cellHeight{
    
    CGSize size = [self sizeWithText:self.shijieDataModel.title font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake((kScreenWidth - 3 * LQSMargin) / 2 - 20, MAXFLOAT)];
    return  (kScreenWidth - 3 * LQSMargin) / 2 * self.shijieDataModel.ratio + size.height + 3 * LQSMargin;
    
}
@end


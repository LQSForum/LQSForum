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






//@property (nonatomic,strong)NSString * special;
//@property (nonatomic,strong)NSString * fid;
//@property (nonatomic,strong)NSArray * board_id;
//@property (nonatomic,strong)NSString * board_name;
//@property (nonatomic,strong)NSString *   source_type;
//@property (nonatomic, strong) NSString *source_id;
//@property (nonatomic,strong)NSString * title;
//@property (nonatomic,strong)NSString * user_id;
//@property (nonatomic,strong)NSArray * last_reply_date;
//@property (nonatomic,strong)NSString * user_nick_name;
//@property (nonatomic,strong)NSString *   hits;
//@property (nonatomic, strong) NSString *summary;
//@property (nonatomic,strong)NSString * replies;
//@property (nonatomic,strong)NSString * pic_path;
//@property (nonatomic,assign)CGFloat ratio;
//@property (nonatomic,strong)NSString * redirectUrl;
//@property (nonatomic,strong)NSString *   userAvatar;
//@property (nonatomic, strong) NSString *gender;
//@property (nonatomic,strong)NSString * recommendAdd;
//@property (nonatomic,strong)NSString * isHasRecommendAdd;
//@property (nonatomic,strong)NSArray * distance;
//@property (nonatomic,strong)NSString * location;
//@property (nonatomic,strong)NSString *   imageList;
//@property (nonatomic, strong) NSString *sourceWebUrl;
//@property (nonatomic, strong) NSString *verify;



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
        
//        创建点击量控件
        UIButton * hitsLabel = [[UIButton alloc] initWithFrame:CGRectZero];
        self.hitsLabel = hitsLabel;
        hitsLabel.backgroundColor = LQSColor(39, 40, 43, 0.6);
        [imageView addSubview:hitsLabel];
        
        
        
        
//        放描述内容的label
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.backgroundColor = LQSColor(255, 255, 255, 0.7);
        contentLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        contentLabel.textAlignment = NSTextAlignmentCenter;
//        contentLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
//         主题标婷title
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.numberOfLines = 0;
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        [contentLabel addSubview:titleLabel];
        self.titleLabel = titleLabel;
//        添加名称
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [contentLabel addSubview:nameLabel];
        self.nameLabel = nameLabel;
        [nameLabel setFont:[UIFont systemFontOfSize:11]];

//        添加时间
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [contentLabel addSubview:timeLabel];
        self.titleLabel = timeLabel;
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

- (float)getTheLabelHeightWithText:(NSString *)labelStr andFont:(UIFont *)labelFont andLabelWidth:(float)labelWidth
{
    CGSize stringSize = [labelStr sizeWithFont:labelFont constrainedToSize:CGSizeMake(labelWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    float labelHeight = stringSize.height;
    return labelHeight;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
//    计算contentLabel的高度 = 标题的高度 + 3 * margin + 名称或者时间的高度
//    计算标题的高度
    
//   self.titleLabel.height = [self getTheLabelHeightWithText:self.shijieDataModel.summary andFont:[UIFont systemFontOfSize:14] andLabelWidth:self.bounds.size.width - 2 * margin];
    self.titleLabel.frame = CGRectMake(margin, margin * 0.5, self.bounds.size.width - 2 * margin, 10);
    self.titleLabel.backgroundColor = [UIColor greenColor];
    
    self.nameLabel.frame = CGRectMake(margin, 2 *(margin * 0.5) + 10, self.bounds.size.width * 0.5, 10);
    
    self.timeLabel.frame = CGRectMake(self.bounds.size.width * 0.5, 2 *margin + 10, self.bounds.size.width * 0.5, 10);
    
    self.contentLabel.frame = CGRectMake(0,self.bounds.size.height - 35,self.bounds.size.width ,35);
        self.imageView.frame = self.bounds ;
    self.hitsLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) - LQSMargin - 30 , LQSMargin, 30, 20);
    self.hitsLabel.userInteractionEnabled = NO;
    self.hitsLabel.titleLabel.textAlignment  = NSTextAlignmentCenter;
    [self.hitsLabel.titleLabel setTextColor:[UIColor whiteColor]];
    [self.hitsLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.hitsLabel.layer.cornerRadius = 5;
    
    }

@end


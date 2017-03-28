//
//  LQSDashangTableViewCell.m
//  myOrgForum
//  功能:  打赏页的cell
//  Created by Queen_B on 2016/11/13.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSDashangTableViewCell.h"
#import "LQSAddViewHelper.h"
@interface LQSDashangTableViewCell ()
@property (nonatomic, assign) BOOL isCreated;
@property (nonatomic,weak)UITextField *weiXiaoTF;
@property (nonatomic,weak)UILabel *shengYuLabel;
@property (nonatomic,weak)UITextView *pingFenLiYouTV;


@end
@implementation LQSDashangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    self.totalHeight = 0;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}
- (void)layoutSubviews{
    if (!self.isCreated) {
        [self createCellForIndexPath];
    }
    
}
- (void)createCellForIndexPath
{
    switch (self.indexPath.section) {
        case 0:{
//            self.height = 73;
            [self setCellForSection0];
            break;
        }case 1:{
            [self setCellForContentSection1];
            break;
        }case 2:{
            [self setCellForContentSection2];
            break;
        }default:
            break;
        
    }
}
// 打赏页的第一个cell:微笑:输入框 0~10 剩余分数
- (void)setCellForSection0{
    UILabel *smileLabel;
    [LQSAddViewHelper addLable:&smileLabel withFrame:CGRectMake(0, 0, 60, 50) text:@"微笑:" textFont:[UIFont boldSystemFontOfSize:15] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineNumber:0 tag:0 superView:self.contentView];
    smileLabel.backgroundColor = [UIColor blueColor];
    // 计算出来的宽度:kscreenWidth - 70 - 120,高度:50-20 = 30
    UITextField *weixiaoTF = [[UITextField alloc]initWithFrame:CGRectMake(70,10, kScreenWidth - 190 ,30)];
    weixiaoTF.borderStyle = UITextBorderStyleRoundedRect;
    self.weiXiaoTF = weixiaoTF;
    [self.contentView addSubview:weixiaoTF];
    // 评分区间 0~10
    UILabel *qujianLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 120, 0, 40, 50)];
    qujianLabel.backgroundColor = [UIColor yellowColor];
    qujianLabel.text = @"0 ~ 10";
    qujianLabel.numberOfLines = 0;
    qujianLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:qujianLabel];
    // 今日剩余,需要从服务器拿到剩余量。
    UILabel *shengyuLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 50, 0, 40, 50)];
    shengyuLabel.backgroundColor = [UIColor blueColor];
    shengyuLabel.text = @"90";
    shengyuLabel.numberOfLines = 0;
    shengyuLabel.textAlignment = NSTextAlignmentCenter;
    self.shengYuLabel = shengyuLabel;
    [self.contentView addSubview:shengyuLabel];
    self.isCreated = YES;
}
- (void)setCellForContentSection1{
    // 可选评分理由label
    UILabel *keXuanPingFenLabel;
    [LQSAddViewHelper addLable:&keXuanPingFenLabel withFrame:CGRectMake(5, 2, 200, 30) text:@"可选评分理由" textFont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    keXuanPingFenLabel.backgroundColor = [UIColor orangeColor];
    UITextView *keXuanPingFenTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 35, KLQScreenFrameSize.width, 80)];
    self.pingFenLiYouTV = keXuanPingFenTextView;
    keXuanPingFenTextView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:keXuanPingFenTextView];
    self.isCreated = YES;
}
- (void)setCellForContentSection2{
    UILabel *tongZhiZuoZheLabel;
    [LQSAddViewHelper addLable:&tongZhiZuoZheLabel withFrame:CGRectMake(0,5, 100, 30) text:@"通知作者" textFont:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    UISwitch *tongZhiZuoZheSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(LQSScreenW - 60, 5, 60, 30)];
    [self.contentView addSubview:tongZhiZuoZheSwitch];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

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


@end
@implementation LQSDashangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //    [self createCellForIndexPath];
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
    [self.contentView addSubview:weixiaoTF];
    // 评分区间 0~10
    UILabel *qujianLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 120, 0, 40, 50)];
    qujianLabel.backgroundColor = [UIColor yellowColor];
    qujianLabel.text = @"0 ~ 10";
    qujianLabel.numberOfLines = 0;
    qujianLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:qujianLabel];
    // 今日剩余
    UILabel *shengyuLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 50, 0, 40, 50)];
    shengyuLabel.backgroundColor = [UIColor blueColor];
    shengyuLabel.text = @"90";
    shengyuLabel.numberOfLines = 0;
    shengyuLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:shengyuLabel];
}
- (void)setCellForContentSection1{
    
}
- (void)setCellForContentSection2{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

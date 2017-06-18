//
//  LQSRecommendListTableViewCell.m
//  myOrgForum
//
//  Created by wangbo on 2017/6/14.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSRecommendListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

typedef NS_ENUM(NSUInteger, RecommendListCellType) {
    RecommendListCellTypeNone = 0,      //默认文字
    RecommendListCellTypeText,          //文字
    RecommendListCellTypeSingeImage,    //只有右边有一个图片
    RecommendListCellTypeMultiImage,    //多张图，在cell中间展示，一般展示3张
};

#define RecommendLeftMargin     10.0f
#define RecommendTopMargin      8.0f
#define RecommendRightMargin    10.0f
#define RecommendBottomMargin   8.0f

@interface LQSRecommendListTableViewCell ()

@property (nonatomic, assign) RecommendListCellType cellUIType;
@property (nonatomic, strong, readwrite) LQSRecommendListModel *recommendModel;
@property (nonatomic, strong) UIImageView *essenceIcon;   //精 icon essence为1时，
@property (nonatomic, strong) UILabel *titleLabel;      //标题 title 一行
@property (nonatomic, strong) UILabel *subjectLabel;    //简介 subject 最多展示两行 ，一行的话上下居中
@property (nonatomic, strong) UILabel *timeLabel;       //时间 last_reply_date
@property (nonatomic, strong) UILabel *nickNameLabel;   //昵称 user_nick_name
@property (nonatomic, strong) UILabel *hitsLabel;       //阅读数 取hits 和阅读分开
@property (nonatomic, strong) UILabel *readLabel;       //阅读分开 后续看是否需要

@property (nonatomic, strong) UIImageView *detailImageView;   //一张图 对应 pic_path
@property (nonatomic, strong) NSMutableArray *detailImageViewArray;    //取imageList的前三张图，如果少于三张，取全部。做成ImageView
@property (nonatomic, strong) UIView *multiImageBgView;     //取imageList的前三张图，如果少于三张，取全部。做成ImageView
@property (nonatomic, strong) UIView *bottomLineView;       //底部分割线

@end

@implementation LQSRecommendListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.cellUIType = RecommendListCellTypeNone;
        [self configCellView];
    }
    
    return self;
}

- (void)configCellView {
    [self.contentView addSubview:self.essenceIcon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subjectLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.detailImageView];
    [self.contentView addSubview:self.hitsLabel];
    [self.contentView addSubview:self.bottomLineView];
}

- (RecommendListCellType)cellTypeWithModel:(LQSRecommendListModel *)recommendModel {
    if (!recommendModel) {
        return RecommendListCellTypeNone;
    }
    
    if (recommendModel.imageList && [recommendModel.imageList count] > 0) {
        
        if ([recommendModel.imageList count] >= 3) {
            return RecommendListCellTypeMultiImage;
        } else {
            if (recommendModel.pic_path && recommendModel.pic_path.length > 0) {
                return RecommendListCellTypeSingeImage;
            } else {
                return RecommendListCellTypeMultiImage;
            }
        }
    }
    
    if (recommendModel.pic_path && recommendModel.pic_path.length > 0) {
        return RecommendListCellTypeSingeImage;
    }
    
    return RecommendListCellTypeText;
}

- (void)updateCellWithModel:(LQSRecommendListModel *)recommendModel {
    self.cellUIType = [self cellTypeWithModel:recommendModel];
    self.recommendModel = recommendModel;
    
    switch (self.cellUIType) {
        case RecommendListCellTypeText: {
            [self layoutTextType];
        }
            break;
            
        case RecommendListCellTypeSingeImage: {
            [self layoutSingleImageType];
        }
            break;
            
        case RecommendListCellTypeMultiImage: {
            [self layoutMultiImageType];
        }
            break;
            
        case RecommendListCellTypeNone: {
            //此处忽略，如果没有值就不进来这个函数
            [self clearUI];
        }
            
        default:
            break;
    }
}

- (void)clearUI {
//    if (_essenceIcon) {
//        _essenceIcon
//    }
}

- (void)layoutTextType {
    CGFloat titleLeftOffset = RecommendLeftMargin;
    if ([self.recommendModel.essence boolValue]) {
        self.essenceIcon.frame = CGRectMake(RecommendLeftMargin, RecommendTopMargin, 20.0f, 20.0f);
        self.essenceIcon.hidden = NO;
        titleLeftOffset = self.essenceIcon.frame.origin.x + self.essenceIcon.frame.size.width + 5.0f;
    } else {
        self.essenceIcon.hidden = YES;
    }
    
    self.detailImageView.hidden = YES;
    self.detailImageView.image = nil;
    
    self.titleLabel.text = LQSTR(self.recommendModel.title);
    self.titleLabel.frame = CGRectMake(titleLeftOffset, RecommendTopMargin, LQSScreenW - titleLeftOffset - RecommendRightMargin, 20.0f);
    
    self.subjectLabel.text = LQSTR(self.recommendModel.subject);
    self.subjectLabel.numberOfLines = 2;
    self.subjectLabel.frame = CGRectMake(RecommendLeftMargin, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, LQSScreenW - RecommendLeftMargin - RecommendRightMargin, 50);
    
    self.timeLabel.frame = CGRectMake(RecommendLeftMargin, self.subjectLabel.frame.origin.y + self.subjectLabel.frame.size.height, 90, 16);
    
    self.nickNameLabel.text = LQSTR(self.recommendModel.user_nick_name);
    self.nickNameLabel.frame = CGRectMake(self.timeLabel.origin.x + self.timeLabel.size.width + 5, self.timeLabel.origin.y, 100, 16);
    
    self.hitsLabel.frame = CGRectMake(LQSScreenW - RecommendRightMargin - 90, self.nickNameLabel.origin.y, 90, 16);
    self.hitsLabel.text = [NSString stringWithFormat:@"%@阅读", self.recommendModel.hits];
//    if (self.recommendModel.hits.length > 0) {
//        self.hitsLabel.text = [NSString stringWithFormat:@"%@阅读", self.recommendModel.hits];
//    } else {
//        self.hitsLabel.text = [NSString stringWithFormat:@"0阅读"];
//    }
    
    self.bottomLineView.frame = CGRectMake(RecommendLeftMargin, self.hitsLabel.frame.origin.y + self.hitsLabel.frame.size.height, LQSScreenW - RecommendLeftMargin - RecommendRightMargin, 0.5f);
}

- (void)layoutSingleImageType {
    CGFloat titleLeftOffset = RecommendLeftMargin;
    if ([self.recommendModel.essence boolValue]) {
        self.essenceIcon.frame = CGRectMake(RecommendLeftMargin, RecommendTopMargin, 20.0f, 20.0f);
        self.essenceIcon.hidden = NO;
        titleLeftOffset = self.essenceIcon.frame.origin.x + self.essenceIcon.frame.size.width + 5.0f;
    } else {
        self.essenceIcon.hidden = YES;
    }
    
    self.detailImageView.frame = CGRectMake(LQSScreenW - RecommendRightMargin - 100, self.titleLabel.frame.origin.y, 100.0f, 60.0f);
    [self.detailImageView sd_setImageWithURL:[NSURL URLWithString:self.recommendModel.pic_path] placeholderImage:nil];
    self.detailImageView.hidden = NO;
    
    self.titleLabel.text = LQSTR(self.recommendModel.title);
    self.titleLabel.frame = CGRectMake(titleLeftOffset, RecommendTopMargin, LQSScreenW - titleLeftOffset - self.detailImageView.frame.size.width - 10 - RecommendRightMargin, 20.0f);
    
    self.subjectLabel.text = LQSTR(self.recommendModel.subject);
    self.subjectLabel.numberOfLines = 2;
    self.subjectLabel.frame = CGRectMake(RecommendLeftMargin, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, LQSScreenW - RecommendLeftMargin - self.detailImageView.frame.size.width - 10 - RecommendRightMargin, 40);
    
    self.timeLabel.frame = CGRectMake(RecommendLeftMargin, self.subjectLabel.frame.origin.y + self.subjectLabel.frame.size.height, 90, 16);
    
    self.nickNameLabel.text = LQSTR(self.recommendModel.user_nick_name);
    self.nickNameLabel.frame = CGRectMake(self.timeLabel.origin.x + self.timeLabel.size.width + 5, self.timeLabel.origin.y, 100, 16);
    
    self.hitsLabel.text = [NSString stringWithFormat:@"%@阅读", self.recommendModel.hits];
    self.hitsLabel.frame = CGRectMake(LQSScreenW - RecommendRightMargin - 90, self.nickNameLabel.origin.y, 90, 16);
    self.bottomLineView.frame = CGRectMake(RecommendLeftMargin, self.hitsLabel.frame.origin.y + self.hitsLabel.frame.size.height, LQSScreenW - RecommendLeftMargin - RecommendRightMargin, 0.5f);
}

- (void)layoutMultiImageType  {
    CGFloat titleLeftOffset = RecommendLeftMargin;
    if ([self.recommendModel.essence boolValue]) {
        self.essenceIcon.frame = CGRectMake(RecommendLeftMargin, RecommendTopMargin, 20.0f, 20.0f);
        self.essenceIcon.hidden = NO;
        titleLeftOffset = self.essenceIcon.frame.origin.x + self.essenceIcon.frame.size.width + 5.0f;
    } else {
        self.essenceIcon.hidden = YES;
    }
    
    
    self.titleLabel.text = LQSTR(self.recommendModel.title);
    self.titleLabel.frame = CGRectMake(titleLeftOffset, RecommendTopMargin, LQSScreenW - titleLeftOffset - RecommendRightMargin, 20.0f);
    
    self.subjectLabel.text = LQSTR(self.recommendModel.subject);
    self.subjectLabel.numberOfLines = 1;
    self.subjectLabel.frame = CGRectMake(RecommendLeftMargin, self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height, LQSScreenW - RecommendLeftMargin - RecommendRightMargin, 20);
    
    
    //
    
    self.timeLabel.frame = CGRectMake(RecommendLeftMargin, self.subjectLabel.frame.origin.y + self.subjectLabel.frame.size.height, 90, 16);
    
    self.nickNameLabel.text = LQSTR(self.recommendModel.user_nick_name);
    self.nickNameLabel.frame = CGRectMake(self.timeLabel.origin.x + self.timeLabel.size.width + 5, self.timeLabel.origin.y, 100, 16);
    
    self.hitsLabel.text = [NSString stringWithFormat:@"%@阅读", self.recommendModel.hits];
    self.hitsLabel.frame = CGRectMake(LQSScreenW - RecommendRightMargin - 90, self.nickNameLabel.origin.y, 90, 16);
    self.bottomLineView.frame = CGRectMake(RecommendLeftMargin, self.hitsLabel.frame.origin.y + self.hitsLabel.frame.size.height, LQSScreenW - RecommendLeftMargin - RecommendRightMargin, 0.5f);
}

#pragma mark - 类方法 取cell的高度
+ (CGFloat)heightWithRecommendListModel:(LQSRecommendListModel *)recommendModel {
    if (!recommendModel || recommendModel.title.length == 0) {
        return 0.0f;
    }
    
    if (recommendModel.imageList && [recommendModel.imageList count] > 0) {
        return 120; //RecommendListCellTypeMultiImage
    }
    
    if (recommendModel.pic_path && recommendModel.pic_path.length > 0) {
        return 110; //RecommendListCellTypeSingeImage
    }
    
    return 110;
}

#pragma mark - tool 移至公共区域
- (NSString *)getDateStringWithTimeStamp:(NSString *)timeStampString {
    if (!timeStampString || 0 == timeStampString.length) {
        return nil;
    }
    
    NSTimeInterval lastReplyInterval = (NSTimeInterval)[timeStampString longLongValue];
    
//    NSDate *lastReplydate = [[NSDate alloc] initWithTimeIntervalSince1970:timeStamp];
    
    //分别返回 分钟前 小时前 ，天前 ， 30天后返回 格式 2017-06-18
    
    NSTimeInterval nowInterval = [[NSDate date] timeIntervalSince1970];
    
    NSTimeInterval intervalOffset = nowInterval - lastReplyInterval;
    
    int64_t seconds =  intervalOffset/1000;
    
    NSString *finalTime = nil;
    
    int64_t minutes  = seconds / 60;
    
//    //TODO 逻辑待确认，整形计算会自动抹去小数点后
//    if (minutes < 60) {
//        finalTime = [NSString stringWithFormat:@"%lld分钟前", minutes];
//    } else  {
//        int64_t hours = minutes / 60;
//        
//        if (hours < 24) {
//            finalTime = [NSString stringWithFormat:@"%lld小时前", hours];
//        } else {
//            int64_t days = hours / 24;
//            
//            if (days < 30) {
//                finalTime = [NSString stringWithFormat:@"%lld天前", days];
//            } else {
//                NSDateFormatter *formatter = [NSDateFormatter da];
//            }
//        }
//    }
    
    return finalTime;
}

#pragma mark - getter
- (UIImageView *)essenceIcon {
    if (!_essenceIcon) {
        _essenceIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"marrow"]];
        _essenceIcon.backgroundColor = [UIColor clearColor];
//        _essenceIcon.frame = CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
    }
    
    return _essenceIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _titleLabel;
}

- (UILabel *)subjectLabel {
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.backgroundColor = [UIColor clearColor];
        _subjectLabel.textColor = [UIColor lightGrayColor];
        _subjectLabel.font = [UIFont systemFontOfSize:14.0f];
        _subjectLabel.numberOfLines = 2;
        _subjectLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _subjectLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _timeLabel;
}

- (UILabel *)nickNameLabel {
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.backgroundColor = [UIColor clearColor];
        _nickNameLabel.textColor = [UIColor lightGrayColor];
        _nickNameLabel.font = [UIFont systemFontOfSize:12.0];
        _nickNameLabel.numberOfLines = 1;
        _nickNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _nickNameLabel;
}

- (UILabel *)hitsLabel {
    if (!_hitsLabel) {
        _hitsLabel = [[UILabel alloc] init];
        _hitsLabel.backgroundColor = [UIColor clearColor];
        _hitsLabel.textColor = [UIColor lightGrayColor];
        _hitsLabel.font = [UIFont systemFontOfSize:12.0f];
        _hitsLabel.numberOfLines = 1;
        _hitsLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _hitsLabel;
}

- (UIImageView *)detailImageView {
    if (!_detailImageView) {
        _detailImageView = [[UIImageView alloc] init];
        _detailImageView.backgroundColor = [UIColor clearColor];
    }
    
    return _detailImageView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _bottomLineView;
}

@end

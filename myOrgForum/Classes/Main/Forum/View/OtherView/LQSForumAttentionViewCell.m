//
//  LQSForumAttentionViewCell.m
//  myOrgForum
//
//  Created by 昱含 on 2017/5/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSForumAttentionViewCell.h"
#import "LQSAttentionPicturesView.h"

#define LQSAttentionPhotoH (LQSScreenW-LQSMargin*4)/3;

@interface LQSForumAttentionViewCell ()
/** 头像 */
@property (nonatomic, strong) UIView *background;
/** 头像 */
@property (nonatomic, strong) UIImageView *userIcon;
/** 用户名称 */
@property (nonatomic, strong) UILabel *userNameLbl;
/** 用户性别 */
@property (nonatomic, strong) UIImageView *userGenderView;
/** 发表时间 */
@property (nonatomic, strong) UILabel *publishTimeLbl;
/** 来源关注版块 */
@property (nonatomic, strong) UILabel *attentionLbl;
/** 主题 */
@property (nonatomic, strong) UILabel *titleLbl;
/** 摘要 */
@property (nonatomic, strong) UILabel *contentLbl;
/** 图片 */
@property (nonatomic, strong) UIImageView *picture;
/** 图片背景视图 */
@property (nonatomic, strong) LQSAttentionPicturesView *pictureBackgroundView;
/** 图片数组 */
@property (nonatomic, strong) NSMutableArray  *pictureArr;
/** 版块来源名称 */
@property (nonatomic, strong) UIButton *sourceBtn;
/** 底部状态栏 */
@property (nonatomic, strong) UIView *bottomView;
/** 分享 */
@property (nonatomic, strong) UIButton *shareBtn;
/** 评论 */
@property (nonatomic, strong) UIButton *commentNumBtn;
/** 浏览量 */
@property (nonatomic, strong) UIButton *readNumBtn;
/** 竖线1 */
@property (nonatomic, strong) UIView *line1;
/** 竖线2 */
@property (nonatomic, strong) UIView *line2;
/** 标题高度 */
@property (nonatomic, assign) CGFloat titleH;
/** 内容高度 */
@property (nonatomic, assign) CGFloat introductionH;
/** cell高度 */
@property (nonatomic, assign) CGFloat cellH;

@end


@implementation LQSForumAttentionViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor lqs_colorWithHexString:@"#d8d8d8"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.background];
        [self.background addSubview:self.userIcon];
        [self.background addSubview:self.userNameLbl];
        [self.background addSubview:self.userGenderView];
        [self.background addSubview:self.publishTimeLbl];
        [self.background addSubview:self.attentionLbl];
        [self.background addSubview:self.titleLbl];
        [self.background addSubview:self.contentLbl];
        [self.background addSubview:self.sourceBtn];
        [self.background addSubview:self.pictureBackgroundView];
        [self.background addSubview:self.bottomView];
        [self.bottomView addSubview:self.line1];
        [self.bottomView addSubview:self.line2];
        [self.bottomView addSubview:self.shareBtn];
        [self.bottomView addSubview:self.commentNumBtn];
        [self.bottomView addSubview:self.readNumBtn];
        
        [self setUpUI];
        
    }
    
    return self;
    
}

#pragma mark - PrivateMethods
- (void)setUpUI
{
    
    [self.background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.background).offset(10);
        make.width.height.mas_equalTo(35);
    }];
    
    
    [self.userNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(10);
        make.top.equalTo(self.background.mas_top).offset(12);
    }];
    
    
    [self.userGenderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLbl.mas_right).offset(10);
        make.top.equalTo(self.background.mas_top).offset(10);
        make.width.height.mas_equalTo(15);
    }];
    
    
    [self.publishTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLbl.mas_left);
        make.top.equalTo(self.userNameLbl.mas_bottom).offset(5);
    }];
    
    
    [self.attentionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.publishTimeLbl.mas_right).offset(10);
        make.top.equalTo(self.publishTimeLbl.mas_top);
    }];
    
    
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_left);
        make.top.equalTo(self.userIcon.mas_bottom).offset(10);
        make.right.equalTo(self.background.mas_right).offset(-10);
    }];
    
    
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_left);
        make.top.equalTo(self.titleLbl.mas_bottom).offset(10);
        make.right.equalTo(self.background.mas_right).offset(-10);
    }];
    
    
    [self.sourceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.background.mas_top).offset(5);
        make.right.equalTo(self.background.mas_right).offset(-10);
    }];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.background);
        make.height.mas_equalTo(35);
    }];
    
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self.bottomView);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareBtn.mas_right);
        make.top.equalTo(self.bottomView.mas_top).offset(5);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-5);
        make.width.mas_equalTo(0.5);
    }];
    
    
    [self.commentNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.bottomView);
        make.left.equalTo(self.line1.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentNumBtn.mas_right);
        make.top.equalTo(self.bottomView.mas_top).offset(5);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-5);
        make.width.mas_equalTo(0.5);
    }];
    
    
    [self.readNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.background.mas_right);
        make.top.bottom.equalTo(self.bottomView);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
}


- (CGFloat)calculateCellHeightWithData:(LQSForumAttentionModel *)model
{
    self.cellH = 0;
    if (model.attentionPictureList.count > 0) {
        self.cellH = self.titleH + self.introductionH + 35 + 35 + 10*6 +LQSAttentionPhotoH;
    }else{
        self.cellH = self.titleH + self.introductionH + 35 + 35 + 10*5;
    }
    return self.cellH;
}

//计算标题和内容的高度
- (void)calculateCellTitleAndContentHeightWith:(LQSForumAttentionModel *)model
{
    //title行高
    NSString *firstWord1 = [model.attentionTitle substringToIndex:1];
    CGFloat oneRowHeight1 = [firstWord1 sizeWithAttributes:@{NSFontAttributeName:kSystemFont(33.0)}].height;
    NSDictionary *attributes1 = @{NSFontAttributeName:kSystemFont(33.0)};
    CGSize textSize1 = [model.attentionTitle boundingRectWithSize:CGSizeMake(kScreenWidth-20, 0) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes1 context:nil].size;
    
    if ((textSize1.height-oneRowHeight1) < 5 || (textSize1.height-oneRowHeight1) == 5) {
        NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:model.attentionTitle];
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle1 setLineSpacing:0];
        [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0,model.attentionTitle.length)];
        [self.titleLbl setAttributedText:string1];
        
        self.titleH = textSize1.height;
    }else{
        
        NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:model.attentionTitle];
        NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle1 setLineSpacing:5.0];
        [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0,model.attentionTitle.length)];
        [self.titleLbl setAttributedText:string1];
        self.titleH = oneRowHeight1*2+5.0;
    }
    
    CGRect titleFrame = self.titleLbl.frame;
    titleFrame.size.height = self.titleH;
    self.titleLbl.frame = titleFrame;
    [self.titleLbl sizeToFit];
    self.titleLbl.textAlignment = NSTextAlignmentLeft;
    self.titleLbl.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    
    //introduction行高
    NSDictionary *attributes2 = @{NSFontAttributeName:kSystemFont(30.0)};
    CGSize textSize2 = [model.attentionSubject boundingRectWithSize:CGSizeMake(kScreenWidth-20, 0) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:attributes2 context:nil].size;
    NSString *firstWord2 = [model.attentionSubject substringToIndex:1];
    CGFloat oneRowHeight2 = [firstWord2 sizeWithAttributes:@{NSFontAttributeName:kSystemFont(30.0)}].height;
    if ((textSize2.height-oneRowHeight2) < 5 || (textSize2.height-oneRowHeight2) == 5) {
        NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc]initWithString:model.attentionSubject];
        NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle2 setLineSpacing:0];
        [string2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0,model.attentionSubject.length)];
        [self.contentLbl setAttributedText:string2];
        self.introductionH = textSize2.height;
        
        
    }else{
        
        NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc]initWithString:model.attentionSubject];
        NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle2 setLineSpacing:5.0];
        [string2 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0,model.attentionSubject.length)];
        [self.contentLbl setAttributedText:string2];
        self.introductionH = oneRowHeight2*2+5.0;
    }
    CGRect contentFrame = self.contentLbl.frame;
    contentFrame.size.height = self.introductionH;
    self.contentLbl.frame = contentFrame;
    
    [self.contentLbl sizeToFit];
    self.contentLbl.textAlignment = NSTextAlignmentLeft;
    self.contentLbl.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    
}


//- (void)addPictureWithCount:(NSInteger)count width:(CGFloat)width margin:(CGFloat)margin originY:(CGFloat)originY attentionModel:(LQSForumAttentionModel *)model
//{
//    [self.pictureArr removeAllObjects];
//    for (NSInteger i = 0; i < count; i++) {
//        
//        _picture = [self.pictureBackgroundView viewWithTag:100+i];
//        if (_picture == nil) {
//            _picture = [[UIImageView alloc]init];
//            _picture.tag = 100+i;
//            _picture.contentMode = UIViewContentModeScaleAspectFill;
//            _picture.layer.masksToBounds = YES;
//            _picture.frame = CGRectMake(margin+(margin+width)*i, 0, width, width);
//            [_picture sd_setImageWithURL:[NSURL URLWithString:model.attentionPictureList[i]]];
//            [self.pictureBackgroundView addSubview:_picture];
//        }
//        
//    }
//}

#pragma mark - EventResponse
- (void)sourceBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToForumDetail:)]) {
        [self.delegate pushToForumDetail:self];
    }
}

- (void)userIconTap:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToAuthorPage)]) {
        [self.delegate pushToAuthorPage];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.model.attentionPictureList.count > 0) {
        self.pictureBackgroundView.hidden = NO;
        [self.pictureBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.background);
            make.top.equalTo(self.contentLbl.mas_bottom).offset(10);
            make.height.mas_equalTo((LQSScreenW-10*4)/3);
        }];
        
        self.pictureBackgroundView.photos = self.model.attentionPictureList;
        
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pictureBackgroundView.mas_bottom).offset(10);
            make.left.right.equalTo(self.background);
            make.height.mas_equalTo(35);
        }];
        
    }else{
        
        self.pictureBackgroundView.hidden = YES;
        [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLbl.mas_bottom).offset(10);
            make.left.right.equalTo(self.background);
            make.height.mas_equalTo(35);
        }];
    }
}


#pragma mark - GetterAndSetter
- (void)setModel:(LQSForumAttentionModel *)model
{
    _model = model;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.attentionUserIcon]];
    self.userNameLbl.text = model.attentionUserName;
    //时间戳转换
    NSString *dateStr = [model.attentionReplyDate changeDate:model.attentionReplyDate];
    self.publishTimeLbl.text = dateStr;
    self.attentionLbl.text = @"来自关注的版块";
    [self.sourceBtn setTitle:model.attentionBoardName forState:UIControlStateNormal];
    
    
    [self calculateCellTitleAndContentHeightWith:model];
    
    [self.commentNumBtn setTitle:[NSString stringWithFormat:@"%zd",model.attentionCommentNum] forState:UIControlStateNormal];
    [self.commentNumBtn setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:5.0];
    [self.readNumBtn setTitle:[NSString stringWithFormat:@"%zd",model.attentionReadNum] forState:UIControlStateNormal];
    [self.readNumBtn setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:5.0];
    
    if (model.attentionUserGender == 2 ) {
        self.userGenderView.image = [UIImage imageNamed:@"dz_personal_icon_woman"];
    }else if (model.attentionUserGender == 1){
        self.userGenderView.image = [UIImage imageNamed:@"dz_personal_icon_man"];
    }
    
    [self setNeedsLayout];
    
}


- (UIView *)background
{
    if (_background == nil) {
        _background = [[UIView alloc] init];
        _background.backgroundColor = [UIColor whiteColor];
    }
    return _background;
}


- (UIImageView *)userIcon
{
    if (_userIcon == nil) {
        _userIcon = [[UIImageView alloc] init];
        _userIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconTap:)];
        [_userIcon addGestureRecognizer:tapGesture];

    }
    return _userIcon;
}

- (UILabel *)userNameLbl
{
    if (_userNameLbl == nil) {
        _userNameLbl = [[UILabel alloc] init];
        _userNameLbl.textColor = [UIColor blackColor];
        _userNameLbl.font = kSystemFont(24.0);
        _userNameLbl.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userIconTap:)];
        [_userNameLbl addGestureRecognizer:tapGesture];
    }
    return _userNameLbl;
}

- (UIImageView *)userGenderView
{
    if (_userGenderView == nil) {
        _userGenderView = [[UIImageView alloc] init];
    }
    return _userGenderView;
}

- (UILabel *)publishTimeLbl
{
    if (_publishTimeLbl == nil) {
        _publishTimeLbl = [[UILabel alloc] init];
        _publishTimeLbl.textColor = [UIColor lightGrayColor];
        _publishTimeLbl.font = kSystemFont(24.0);
    }
    return _publishTimeLbl;
}

- (UILabel *)attentionLbl
{
    if (_attentionLbl == nil) {
        _attentionLbl = [[UILabel alloc] init];
        _attentionLbl.textColor = [UIColor lightGrayColor];
        _attentionLbl.font = kSystemFont(24.0);
    }
    return _attentionLbl;
}

- (UILabel *)titleLbl
{
    if (_titleLbl == nil) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = kSystemFont(33.0);
        _titleLbl.numberOfLines = 2;
    }
    return _titleLbl;
}

- (UILabel *)contentLbl
{
    if (_contentLbl == nil) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.textColor = [UIColor lightGrayColor];
        _contentLbl.font = kSystemFont(30.0);
        _contentLbl.numberOfLines = 2;
    }
    return _contentLbl;
}


- (UIButton *)sourceBtn
{
    if (_sourceBtn == nil) {
        _sourceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sourceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _sourceBtn.titleLabel.font = kSystemFont(24.0);
        [_sourceBtn addTarget:self action:@selector(sourceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sourceBtn;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    }
    return _bottomView;
}

- (UIButton *)shareBtn
{
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = kSystemFont(24.0);
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"dz_list_circle_share"] forState:UIControlStateNormal];
        [_shareBtn setButtonImageTitleStyle:ButtonImageTitleStyleLeft padding:5.0];
    }
    return _shareBtn;
}

- (UIButton *)commentNumBtn
{
    if (_commentNumBtn == nil) {
        _commentNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentNumBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _commentNumBtn.titleLabel.font = kSystemFont(24.0);
        [_commentNumBtn setImage:[UIImage imageNamed:@"dz_list_circle_replies"] forState:UIControlStateNormal];
    }
    return _commentNumBtn;
}

- (UIButton *)readNumBtn
{
    if (_readNumBtn == nil) {
        _readNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_readNumBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _readNumBtn.titleLabel.font = kSystemFont(24.0);
        [_readNumBtn setImage:[UIImage imageNamed:@"dz_list_circle_pv"] forState:UIControlStateNormal];
    }
    return _readNumBtn;
}

- (UIView *)line1
{
    if (_line1 == nil) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor lightGrayColor];
    }
    return _line1;
}

- (UIView *)line2
{
    if (_line2 == nil) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor lightGrayColor];
    }
    return _line2;
}

- (LQSAttentionPicturesView *)pictureBackgroundView
{
    if (_pictureBackgroundView == nil) {
        _pictureBackgroundView = [[LQSAttentionPicturesView alloc] init];
    }
    return _pictureBackgroundView;
}

- (NSMutableArray *)pictureArr
{
    if (_pictureArr == nil) {
        _pictureArr = [NSMutableArray array];
    }
    return _pictureArr;
}

@end

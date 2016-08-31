//
//  LQSBBSDetailCell.m
//  myOrgForum
//  功能：帖子详情页cell
//  Created by XJW on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBBSDetailCell.h"
#import "LQSAddViewHelper.h"
#import "LQSArticleContentView.h"
#define kCONTENTIMAGETAG_BEGIN 20160830

@interface LQSBBSDetailCell ()

@property (nonatomic, assign) BOOL isCreated;
@property (nonatomic, assign) CGFloat totalHeight;

@end

@implementation LQSBBSDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    [self createCellForIndexPath];
    self.totalHeight = 0;
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
            self.height = 73;
            [self setCellForSection0];
//            self.contentView.backgroundColor = [UIColor yellowColor];
            break;
        }case 1:{
            [self setCellForContentSection1];
            break;
        }case 2:{
            
            break;
        }case 3:{
            
            break;
        }case 4:{
            
            break;
        }
        default:
            break;
    }
}
- (void)setCellForSection0
{
    UILabel *titleLab;
    [LQSAddViewHelper addLable:&titleLab withFrame:CGRectMake(15, 10, KLQScreenFrameSize.width - 15 - 25, 39) text:LQSTR(self.myCtrl.bbsDetailModel.title) textFont:[UIFont boldSystemFontOfSize:15] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineNumber:2 tag:0 superView:self.contentView];
    UIImageView *scanImgView;
    [LQSAddViewHelper addImageView:&scanImgView frame:CGRectMake(15, 50, 12, 11) tag:0 image:[UIImage imageNamed:@"mc_forum_ico53_n"] superView:self.contentView imgUrlStr:@"" selector:nil];
    UILabel *scanLab;
    [LQSAddViewHelper addLable:&scanLab withFrame:CGRectMake(32, 49, KLQScreenFrameSize.width - 32 - 25, 14) text:LQSTR(self.myCtrl.bbsDetailModel.hits) textFont:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    if (self.myCtrl.bbsDetailModel.essence) {
        UILabel *essenceLab;
        [LQSAddViewHelper addLable:&essenceLab withFrame:CGRectMake(KLQScreenFrameSize.width - 10 -16, 10, 16, 16) text:@"精" textFont:[UIFont boldSystemFontOfSize:13] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineNumber:1 tag:0 superView:self.contentView];
        essenceLab.layer.cornerRadius = 2;
        essenceLab.clipsToBounds = YES;
        essenceLab.backgroundColor = [UIColor redColor];
    }
    self.isCreated = YES;
}
- (void)setCellForContentSection1
{
    //抬头
    UIImageView *userImgView;
    [LQSAddViewHelper addImageView:&userImgView frame:CGRectMake(10, 10, 40, 40) tag:0 image:[UIImage imageNamed:@"mc_forum_add_new_img.png"] superView:self.contentView imgUrlStr:self.myCtrl.bbsDetailModel.icon selector:nil];
    
    UILabel *userNameLab;
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [self.myCtrl.bbsDetailModel.user_nick_name  boundingRectWithSize:CGSizeMake(KLQScreenFrameSize.width - 55 - 78 - 10, 20) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    [LQSAddViewHelper addLable:&userNameLab withFrame:CGRectMake(55, 9, rect.size.width, 20) text:self.myCtrl.bbsDetailModel.user_nick_name textFont:[UIFont systemFontOfSize:15] textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    
    UILabel *titleNamelab;
    CGFloat x = CGRectGetMaxX(userNameLab.frame);
    x += 5;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rectForTitle = [self.myCtrl.bbsDetailModel.userTitle  boundingRectWithSize:CGSizeMake(KLQScreenFrameSize.width - 55 - 78 - 10, 20) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    [LQSAddViewHelper addLable:&titleNamelab withFrame:CGRectMake(x, 9, rectForTitle.size.width, 20) text:self.myCtrl.bbsDetailModel.userTitle textFont:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithRed:0.8 green:0.5 blue:0.3 alpha:1] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    
    UILabel *timeLab;
    [LQSAddViewHelper addLable:&timeLab withFrame:CGRectMake(55, CGRectGetMaxY(userNameLab.frame), 200, 20) text:@"1天前" textFont:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    
    UIButton *guanzhuBtn;
    [self addButton:&guanzhuBtn frame:CGRectMake(KLQScreenFrameSize.width - 10 - 78, 10, 78, 25) title:@"关注TA" titleFont:[UIFont systemFontOfSize:13] titleColor:[UIColor blackColor] borderwidth:KSingleLine_Width cornerRadius:0 selector:@selector(guanzhuTA) superView:self.contentView];
    //内容
    LQSArticleContentView *articleView = [[LQSArticleContentView alloc] initWithFrame:CGRectMake(15, 55.0f, KLQScreenFrameSize.width-30, 500)];
    articleView.preferredMaxLayoutWidth = KLQScreenFrameSize.width-30;
    articleView.content = self.myCtrl.bbsDetailModel.content;
    articleView.scrollEnabled = NO;
    [self.contentView addSubview:articleView];
    [articleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(55, 15, 10, 15));
    }];
    
//    for (NSInteger i = 0; i < self.myCtrl.bbsDetailModel.content.count; i++) {
//        if (i == 0) {
//            self.totalHeight = 55;
//        }
//        LQSBBSContentModel *model = self.myCtrl.bbsDetailModel.content[i];
//        if ((![model.infor containsString:@".png"] && ![model.infor containsString:@".jpg"] ) && model.infor.length > 0) {
//            [self addTextContentForText:model.infor];
//        }else{
//            [self addImageContentForUrl:model.originalInfo tag:kCONTENTIMAGETAG_BEGIN+i];
//        }
//    }
    self.isCreated = YES;
}
- (void)guanzhuTA
{
    
}
//添加text内容
- (void)addTextContentForText:(NSString *)string
{
//    while ([string rangeOfString:@"\n"].location == 0 ) {
//        string = [string substringWithRange:NSMakeRange([string rangeOfString:@"\n"].location, [string rangeOfString:@"\n"].length)];
//    }
//    while ([string rangeOfString:@"\r"].location == 0) {
//        string = [string substringWithRange:NSMakeRange([string rangeOfString:@"\r"].location, [string rangeOfString:@"\r"].length)];
//    }
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(KLQScreenFrameSize.width - 10, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    
    NSInteger nCount = [LQSAddViewHelper getCountOfString:string forCharacter:@"\n"]+[LQSAddViewHelper getCountOfString:string forCharacter:@"\r"];//([LQSAddViewHelper getCountOfString:string forCharacter:@"\n"]+[LQSAddViewHelper getCountOfString:string forCharacter:@"\r"]>5?5:[LQSAddViewHelper getCountOfString:string forCharacter:@"\n"]+[LQSAddViewHelper getCountOfString:string forCharacter:@"\r"]);

//        UITextView *atextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 0, rect.size.width, rect.size.height + nCount*10)];
//    
//        atextView.font = [UIFont systemFontOfSize:13];
//    
//        atextView.text = string;
//    
//        atextView.backgroundColor = [UIColor cyanColor];
//    
//        [self.contentView addSubview:atextView];
    UILabel *textLable;
    [LQSAddViewHelper addLable:&textLable withFrame:CGRectMake(5, self.totalHeight, rect.size.width, rect.size.height + nCount*10) text:string textFont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineNumber:0 tag:0 superView:self.contentView];
//    textLable.backgroundColor = [UIColor redColor];
    
    self.totalHeight += (rect.size.height + nCount*10);
}
//添加图片text
- (void)addImageContentForUrl:(NSString *)urlStr tag:(NSInteger)tag
{
    UIImageView *contentIngView;
    [self addImageView:&contentIngView frame:CGRectMake(5, self.totalHeight, KLQScreenFrameSize.width - 15, 470*(KLQScreenFrameSize.width - 15)/690) tag:tag image:[UIImage imageNamed:@"mc_forum_add_new_img.png"] superView:self.contentView imgUrlStr:urlStr selector:@selector(imageClick)];
    self.totalHeight += 470*(KLQScreenFrameSize.width - 15)/690;
}
- (void)addImageView:(UIImageView **)imageView frame:(CGRect)frame tag:(NSInteger)tag image:(UIImage *)img superView:(UIView *)superView imgUrlStr:(NSString *)urlStr selector:(SEL)selector
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    [superView addSubview:imgView];
    imgView.tag = tag;
    if (urlStr.length > 0) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(urlStr)] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!image) {
                imgView.image = img;
            }else{
                imgView.image = image;
//                imgView.frame = CGRectMake(frame.origin.x, frame.origin.y, KLQScreenFrameSize.width - 10,image.size.width*image.size.height/(KLQScreenFrameSize.width - 10));
                
            }
        }];
    }else{
        imgView.image = img;
    }
    if (tag != 0) {
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
        [imgView addGestureRecognizer:tap];
    }
    
    *imageView = imgView;
}
- (void)imageClick
{
    
}

- (void)addButton:(UIButton **)button frame:(CGRect)frame  title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)color borderwidth:(CGFloat)bwidth cornerRadius:(CGFloat)cornerRadius selector:(SEL)selector superView:(UIView *)superView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    btn.layer.borderWidth = bwidth;
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchDragInside];
    [superView addSubview:btn];
    *button = btn;
    
}


@end

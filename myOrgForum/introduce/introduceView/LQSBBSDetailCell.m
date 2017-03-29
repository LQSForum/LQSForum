//
//  LQSBBSDetailCell.m
//  myOrgForum
//  功能：帖子详情页cell
//  Created by XJW on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
// 这页的按钮功能是点击弹出，然后点击屏幕就自动收回。这个效果不确定要不要做。感觉不是很有必要。看情况，现在还没有实现。

#import "LQSBBSDetailCell.h"
#import "LQSAddViewHelper.h"
#import "LQSArticleContentView.h"
#import "LQSSettingViewController.h"
// 判断用户是否登录
#import "LQSUserManager.h"
#import "LQSHomePagePersonalMessageViewController.h"
// 解析评论数据
#import "LQSBBSDetailModel.h"

#define kCONTENTIMAGETAG_BEGIN 20160830
#define kGUANZHUTA @"关注TA"
#define kYIGUANZHUTA @"已关注TA"
@interface LQSBBSDetailCell ()

@property (nonatomic, assign) BOOL isCreated;
@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic,strong)UIActionSheet *myActSheet;

@property (nonatomic,strong)LQSArticleContentView *articleContentView;
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
-(void)setCellWithData:(id)modelData indexpath:(NSIndexPath *)indexpath{
    // 暂时不用写什么东西
}
- (CGRect )resultRectWithText:(NSString *)text width:(CGFloat)width{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    // 计算文字高度
    CGRect rect = [text  boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    return rect;
}
// 跳转到大赏页
- (void)postToReportPage:(UIButton *)sender{
    NSLog(@"举报按钮的点击事件");
    if ([self.delegate respondsToSelector:@selector(pushToReport)]) {
        // 让自己的代理跳转页面
        [self.delegate pushToReport];
    }
    
}
// 赏点击方法--xg
- (void)shangAct{
    NSLog(@"赏的点击方法");
    if ([self.delegate respondsToSelector:@selector(pushToDashang)]) {
        [self.delegate pushToDashang];
    }
}

#pragma mark - 帖子详情点击头像方法
- (void)sec1HeadAct{
    NSLog(@"点击头像应该弹出actionSheet,选择框");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction: [UIAlertAction actionWithTitle: @"发送私信" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 处理发送私信的点击事件
        NSLog(@"发送私信");
        // 这里应该是需要集成及时通讯.但是好像还没有集成.
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"查看主页" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        // 处理查看主页的点击事件
        NSLog(@"查看主页");
        [self pushToPersonalMainPage];
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"只看作者" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        // 处理只看作者的点击事件
        NSLog(@"只看作者");
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    [(UIViewController *)self.delegate presentViewController:alertController animated:YES completion:nil];
    
}
// 抽出的跳转到用户主页的方法，由于个人部分还没怎么写，所以该有的接口参数都没有，等有了再接入进来。
- (void)pushToPersonalMainPage{
    // 判定是否登录,没登录则跳转登录,登录后则跳转用户主页
    if (![LQSUserManager isLoging]) {
        //        跳转登陆
        LQLoginViewController *loginVc = [LQLoginViewController new];
        LQSNavigationController *navVC = [[LQSNavigationController alloc] initWithRootViewController:loginVc];
        if (self.delegate) {
            [(LQSBBSDetailViewController *) self.delegate presentViewController:navVC animated:YES completion:nil];
        }
        // [self.contentView.window.rootViewController presentViewController:navVC animated:YES completion:nil];
    }else{
        if ([LQSUserManager isLoging]) {
            LQSHomePagePersonalMessageViewController *personalVc = [LQSHomePagePersonalMessageViewController new];
            //[self.contentView.window.rootViewController.navigationController pushViewController:personalVc animated:YES];
            if (self.delegate) {
                LQSBBSDetailViewController *detailVC = (LQSBBSDetailViewController *)self.delegate;
                [detailVC.navigationController pushViewController:personalVc animated:NO];
            }
            
        }else{
            LQLoginViewController *loginVC = [LQLoginViewController new];
            LQSNavigationController *navVc = [[LQSNavigationController alloc] initWithRootViewController:loginVC];
            // [self.contentView.window.rootViewController presentViewController:navVc animated:YES completion:nil];
            if (self.delegate) {
                [(LQSBBSDetailViewController *) self.delegate presentViewController:navVc animated:YES completion:nil];
            }
        }
    }
}
// 关注点击方法
- (void)guanzhuTA:(UIButton *)sender
{
    // 关注或取关逻辑:比较现在显示的title,如果是关注则为follow,如果是已关注,则为unfollow.
    // 还有处理网络的逻辑.
    NSString *guanzhuTAUrlStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=user/useradmin";
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    // 关注功能的请求参数:uid,egnVersion,sdkVersion,apphash,type,accessToken,accessSecret,forumKey
    // 这是我抓到的参数包,暂时用这个,以后替换
    // 关注Ta:uid=217900&egnVersion=v2035.2&sdkVersion=2.4.3.0&apphash=9bd98586&type=follow&accessToken=caf68203b950537adbe1bcf6bc7ad&accessSecret=84f18779cf550aac2fce53e8eb266&forumKey=BW0L5ISVRsOTVLCTJx
    // 取消关注:uid=217900&egnVersion=v2035.2&sdkVersion=2.4.3.0&apphash=9bd98586&type=unfollow&accessToken=caf68203b950537adbe1bcf6bc7ad&accessSecret=84f18779cf550aac2fce53e8eb266&forumKey=BW0L5ISVRsOTVLCTJx
    // 关注和取关,type字段的参数为follow和unfollow
    [dict setObject:@"217900" forKey:@"uid"];
    [dict setObject:@"v2035.2" forKey:@"egnVersion"];
    [dict setObject:@"2.4.3.0" forKey:@"sdkVersion"];
    [dict setObject:@"9bd98586" forKey:@"apphash"];
    // 判断当前title,如果是关注,则发送follow,如果是已关注则发送UNfollow.
    [sender.currentTitle isEqualToString:kGUANZHUTA]?
    [dict setObject:@"follow" forKey:@"type"]:[dict setObject:@"unfollow" forKey:@"type"];
    [dict setObject:@"caf68203b950537adbe1bcf6bc7ad" forKey:@"accessToken"];
    [dict setObject:@"84f18779cf550aac2fce53e8eb266" forKey:@"accessSecret"];
    [dict setObject:@"BW0L5ISVRsOTVLCTJx" forKey:@"forumKey"];
    [session POST:guanzhuTAUrlStr parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
        NSLog(@"返回数据：%@",dict);
        // 返回参数如下:
        /*{
         "rs": 1,   rs为1时,为成功,rs为0,则弹框提示已关注过ta了.
         "errcode": "\u53d6\u6d88\u6210\u529f",
         "head": {
         "errCode": "02000024",
         "errInfo": "\u53d6\u6d88\u6210\u529f",
         "version": "2.6.0.1",
         "alert": 1
         },
         "body": {
         "externInfo": {
         "padding": ""
         }
         }
         }
         */
        if ([dict[@"rs"]integerValue] == 1) {
            [kAppDelegate showHUDMessage:dict[@"errcode"] hideDelay:1.0];
        }else if([dict[@"rs"]integerValue] == 0){
            [kAppDelegate showHUDMessage:dict[@"errcode"] hideDelay:1.0];
        }
        // 在网络请求成功的回调里,改变button的文字,如果之前是关注,则改为已关注,反之.
        [sender.currentTitle isEqualToString:kGUANZHUTA]? [sender setTitle:kYIGUANZHUTA forState:UIControlStateNormal] : [sender setTitle:kGUANZHUTA forState:UIControlStateNormal ];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    // 还有关注成功后的回调,弹框显示关注成功和取消关注成功.
    //     NSLog(@"关注的点击方法");
}

//添加text内容
- (void)addTextContentForText:(NSString *)string
{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(KLQScreenFrameSize.width - 10, 10000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    
    NSInteger nCount = [LQSAddViewHelper getCountOfString:string forCharacter:@"\n"]+[LQSAddViewHelper getCountOfString:string forCharacter:@"\r"];
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
- (void)imageView:(UIImageView *)imageView addImgWithUrlStr:(NSString *)urlStr placeHolderImg:(UIImage *)img selector:(SEL)selector{
    if (urlStr.length > 0) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(urlStr)] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!image) {
                imageView.image = img;
            }else{
                imageView.image = image;
            }
        }];
    }else{
        imageView.image = img;
    }
    
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
        [imageView addGestureRecognizer:tap];
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
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [superView addSubview:btn];
    *button = btn;
    
}
@end
#pragma mark - titleCell 帖子顶部标题

@interface LQSBBSDetailTitleCell ()
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *scanImgView;
@property (nonatomic,strong)UILabel *scanLab;
// 精华label
@property (nonatomic,strong)UIImageView *essenceImgV;
@end

@implementation LQSBBSDetailTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    // 精华imgv
    self.essenceImgV = [[UIImageView alloc]init];
    [self.contentView addSubview:self.essenceImgV];
    [self.essenceImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.width.and.height.equalTo(@30);
    }];
    self.essenceImgV.image = [UIImage imageNamed:@"marrow"];
    self.essenceImgV.hidden = YES;
    self.essenceImgV.layer.cornerRadius = 2;
    // 标题label
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@(LQSScreenW - 15-25));
        make.height.equalTo(@39);
    }];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.numberOfLines = 2;// 暂定为2，看先上版的好像是最多2行。
    // 浏览图片
    self.scanImgView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.scanImgView];
    [self.scanImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(1);
        make.width.equalTo(@12);
        make.height.equalTo(@11);
    }];
    self.scanImgView.image = [UIImage imageNamed:@"mc_forum_ico53_n"];
    // 浏览次数lable
    self.scanLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.scanLab];
    [self.scanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scanImgView.mas_right).offset(1);
        make.top.equalTo(self.scanImgView.mas_top);
        make.height.equalTo(self.scanImgView.mas_height);
    }];
    self.scanLab.font = [UIFont boldSystemFontOfSize:13];
    self.scanLab.textColor = [UIColor lightGrayColor];
    self.scanLab.textAlignment = NSTextAlignmentLeft;
    self.scanLab.numberOfLines = 1;
   
}
-(void)setTopicModel:(LQSBBSDetailTopicModel *)topicModel{
    _topicModel = topicModel;
    self.titleLabel.text = topicModel.title;
    self.scanLab.text = [NSString stringWithFormat:@"%@",topicModel.hits];
    self.essenceImgV.hidden = ![topicModel.essence isEqual:@1];
    [self layoutIfNeeded];
    topicModel.topicTitleHeight = CGRectGetMaxY(self.scanLab.frame)+3;
}
@end
#pragma  mark - contentCell 帖子内容

@interface LQSBBSDetailContentCell()<UITextViewDelegate>
// 举报警察按钮
@property (nonatomic,strong)UIButton *policeBtn;
@property (nonatomic,strong)UIImageView *userImgView;
@property (nonatomic,strong)UILabel *userNameLable;
@property (nonatomic,strong)UILabel *memberDegreeLabel;// 会员级别label
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UIButton *guanZhuBtn;// 关注按钮
@property (nonatomic,strong)LQSArticleContentView *articleView;// 内容view
@property (nonatomic,strong)UIButton *reportBtn;// 举报按钮
@end
@implementation LQSBBSDetailContentCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    self.userImgView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.userImgView];
    [self.userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.and.height.equalTo(@40);
    }];
    self.userImgView.clipsToBounds = YES;
    self.userImgView.layer.cornerRadius = 5;
    self.userNameLable = [[UILabel alloc]init];
    [self.contentView addSubview:self.userNameLable];
    [self.userNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImgView.mas_right);
        make.top.equalTo(self.userImgView.mas_top);
        make.height.equalTo(@20);
    }];
    self.userNameLable.font = [UIFont systemFontOfSize:15];
    self.userNameLable.textColor = [UIColor grayColor];
    self.userNameLable.textAlignment = NSTextAlignmentLeft;
    self.userNameLable.numberOfLines = 1;
    self.memberDegreeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.memberDegreeLabel];
    [self.memberDegreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLable.mas_right);
        make.top.equalTo(self.userNameLable.mas_top);
        make.height.equalTo(self.userNameLable.mas_height);
    }];
    self.memberDegreeLabel.textAlignment = NSTextAlignmentLeft;
    self.memberDegreeLabel.textColor = [UIColor colorWithRed:0.8 green:0.5 blue:0.3 alpha:1];
    self.memberDegreeLabel.numberOfLines = 1;
    self.memberDegreeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImgView.mas_right);
        make.top.equalTo(self.userNameLable.mas_bottom);
        make.height.equalTo(@20);
    }];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.guanZhuBtn = [[UIButton alloc]init];
    [self.contentView addSubview:self.guanZhuBtn];
    [self.guanZhuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset(9);
        make.width.equalTo(@80);
        make.height.equalTo(@25);
    }];
    [self.guanZhuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.guanZhuBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.guanZhuBtn.layer.borderWidth = 1;
    [self.guanZhuBtn addTarget:self action:@selector(guanzhuTA:) forControlEvents:UIControlEventTouchUpInside];
    self.articleView = [[LQSArticleContentView alloc]init];
    [self.contentView addSubview:self.articleView];
    [self.articleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(11);
        make.top.equalTo(self.userImgView.mas_bottom).offset(3);
        make.width.equalTo(@(LQSScreenW - 30));
    }];
    self.articleView.preferredMaxLayoutWidth = LQSScreenW - 30;
    self.articleView.delegate = self;
    self.articleView.scrollEnabled = NO;
    self.articleView.editable = NO;
    self.reportBtn = [[UIButton alloc]init];
    [self.contentView addSubview:self.reportBtn];
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.articleView.mas_bottom).offset(5);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    [self.reportBtn setImage:[UIImage imageNamed:@"dz_posts_manage_btn"] forState:UIControlStateNormal];
    [self.reportBtn addTarget:self action:@selector(reportAct:) forControlEvents:UIControlEventTouchUpInside];
    self.reportBtn.backgroundColor = [UIColor whiteColor];
    self.policeBtn = [[UIButton alloc]init];
    [self.contentView addSubview:self.policeBtn];
    [self.policeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.reportBtn.mas_left);
        make.top.equalTo(self.reportBtn.mas_top);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    _policeBtn.layer.cornerRadius = 5;
    [_policeBtn setTitle:@"举报" forState:UIControlStateNormal];
    [_policeBtn setImage:[UIImage imageNamed:@"dz_posts_manage_report"] forState:UIControlStateNormal];
    [_policeBtn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 0)];
    [self.contentView addSubview:_policeBtn];
    [self.contentView insertSubview:_policeBtn belowSubview:_reportBtn];
    _policeBtn.tintColor = [UIColor whiteColor];
    _policeBtn.backgroundColor = [UIColor grayColor];
    _policeBtn.tag = 1100;
    [_policeBtn addTarget:self action:@selector(postToReportPage:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setTopicModel:(LQSBBSDetailTopicModel *)topicModel{
    _topicModel = topicModel;
    [self imageView:self.userImgView addImgWithUrlStr:topicModel.icon placeHolderImg:[UIImage imageNamed:@"mc_forum_add_new_img.png"] selector:@selector(sec1HeadAct)];
    _userImgView.clipsToBounds = YES;
    _userImgView.layer.cornerRadius = 5;
    self.userNameLable.text = topicModel.user_nick_name;
    self.memberDegreeLabel.text = topicModel.userTitle;
    self.timeLabel.text = topicModel.create_date;
    NSString *guanZhuStr = topicModel.isFollow == 0 ? kGUANZHUTA : kYIGUANZHUTA;
    [self.guanZhuBtn setTitle:guanZhuStr forState:UIControlStateNormal];
    self.articleView.content = topicModel.content;
    [self layoutIfNeeded];
    topicModel.topicContenHeight = CGRectGetMaxY(self.reportBtn.frame)+20;
}
// 举报点击事件
- (void)reportAct:(UIButton *)sender{
    NSLog(@"此处弹出举报事件");
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:3.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.policeBtn.x == sender.x) {
            _policeBtn.x -= _policeBtn.width;
        }else{
            _policeBtn.x = sender.x;
        }
    } completion:^(BOOL finished) {
        NSLog(@"警察按扭动画完成");
    }];
    
}
#pragma mark - textviewdelegate,帖子内容的图片点击事件
-(BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    NSLog(@"textview.text.length:%zd",textView.text.length);
    NSLog(@"textview.attributetext.length:%zd",textView.attributedText.length);
    NSLog(@"textAttachment:%@",textAttachment);
    NSLog(@"rang.loc:%zd,length:%zd",characterRange.location,characterRange.length);
    // 在这里获取点击的attachment，处理弹出图片详情.但是这里使用的第三方图片浏览器没有那个分享按钮，需要解决下。
    // 1.创建浏览器对象
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    // 拿到图片URL数组
    NSMutableArray *picUrlStrArr = self.articleView.picUrlArr;
    // 2.设置浏览器对象的所有图片
    NSMutableArray *mjphotos = [NSMutableArray array];
    for (int i = 0; i< picUrlStrArr.count; i++) {
        // 创建MJPhoto模型
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        // 设置图片的url
        mjphoto.url = [NSURL URLWithString:[picUrlStrArr objectAtIndex:i]];
        // 设置图片的来源view
        mjphoto.srcImageView = [[UIImageView alloc]initWithImage:textAttachment.image] ;
        [mjphotos addObject:mjphoto];
    }
    browser.photos = mjphotos;
    // 3.设置浏览器点击显示的图片位置
//    browser.currentPhotoIndex = tap.view.tag;
   // browser.currentPhotoIndex = 0;
    // 4.显示浏览器
    [browser show];
    return YES;
}
@end
#pragma mark - voteCell 打赏cell

@interface LQSBBSDetailVoteCell ()
@property (nonatomic,strong)UILabel *dashangLabel;
@property (nonatomic,strong)UIView *vLineView;
@property (nonatomic,strong)UIButton *shangBtn;
@property (nonatomic,strong)UILabel *dashangInfoLabel;
@property (nonatomic,strong)UIImageView *dashangUserIconImgV;
@property (nonatomic,strong)NSMutableArray *voteIconArr;// 存储打赏用户头像的arr
@property (nonatomic,assign)CGFloat totalCellHeight;// 记录cell高度的变量
@end
@implementation LQSBBSDetailVoteCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}
-(NSMutableArray *)voteIconArr{
    if (!_voteIconArr) {
        _voteIconArr = [NSMutableArray array];
    }
    return _voteIconArr;
}
- (void)setupViews{
    NSLog(@"voteCellsetupViews");
    self.dashangLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.dashangLabel];
    [self.dashangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(15);
        make.width.equalTo(@(LQSScreenW - 80));
        make.height.equalTo(@75);
    }];
    self.dashangLabel.textColor = [UIColor grayColor];
    self.dashangLabel.font = [UIFont systemFontOfSize:15];
    self.dashangLabel.textAlignment = NSTextAlignmentCenter;
    self.vLineView = [[UIView alloc]init];
    [self.contentView addSubview:self.vLineView];
    [self.vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dashangLabel.mas_right);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.width.equalTo(@1);
    }];
    self.dashangLabel.text = @"内容不错就任性地打赏吧!";
    self.vLineView.backgroundColor = [UIColor grayColor];
    self.shangBtn = [[UIButton alloc]init];
    [self.contentView addSubview:self.shangBtn];
    [self.shangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vLineView.mas_right).offset(5);
        make.centerY.equalTo(self.vLineView.mas_centerY);
        make.width.and.height.equalTo(@(55));
    }];
    [self.shangBtn setBackgroundImage:[UIImage imageNamed:@"dz_posts_grade"] forState:UIControlStateNormal];
    [self.shangBtn setBackgroundImage:[UIImage imageNamed:@"dz_posts_grade"] forState:UIControlStateHighlighted];
    [self.shangBtn addTarget:self action:@selector(shangAct) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.shangBtn];
    // 几人打赏，几个微笑的展示label。
    self.dashangInfoLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.dashangInfoLabel];
    [self.dashangInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(3);
        make.height.equalTo(@15);
    }];
    self.dashangInfoLabel.hidden = YES;
    // 打赏人员的头像
    NSInteger maxCountOfIcon = 4;
    // 竖线距离右边65，两边间距10，中间间距5
    CGFloat imgVWidth = (LQSScreenW - 65 - 5*4-20)/5;
    for (NSInteger i = 0; i <= maxCountOfIcon; i ++) {
        NSLog(@"VoteCellForLoop");
        // 间距为5，每个图片大小为30*30，顶部距离为3.
        // 5个头像view。平分screenW - 赏按钮.width - 两边边距 - 空隙*4
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12.5+((imgVWidth+5)*i), 23, imgVWidth, imgVWidth)];
        imageView.layer.cornerRadius = imgVWidth/2;
        imageView.clipsToBounds = YES;
        [self.voteIconArr addObject:imageView];
        imageView.tag = 10086+i;// 用于标记不同的imgview的点击事件。
        [self.contentView addSubview:imageView];
        imageView.hidden = YES;
        // 初始化时隐藏视图，需要展示时，根据model数据展示。
    }
    // 这里其实已经可以计算出这个打赏栏的总高了，加起来就可以了。
    self.totalCellHeight = 3+15+3+imgVWidth+5;
    /*
     */

}
- (void)shangAct{
    NSLog(@"赏的点击方法");
    if ([self.delegate respondsToSelector:@selector(pushToDashangWebWithUrl:)]) {
        [self.delegate pushToDashangWebWithUrl:self.topicModel.dashangWebUrl];
    }
}
-(void)setTopicModel:(LQSBBSDetailTopicModel *)topicModel{
    NSLog(@"打赏cellsetModel");
    // 这个方法会在cell再次出现时再次调用。cell初始化时写好的东西，布局不会改变。但是这里代码中的东西会反复执行，所以这里应该写变动的东西，或者把变化性的东西反复擦除，然后重新执行。
    _topicModel = topicModel;
    if (topicModel.daShangRenShu > 0) {
        self.dashangLabel.hidden = YES;
        self.dashangInfoLabel.hidden = NO;
        self.dashangInfoLabel.attributedText = topicModel.daShangInfoStr;
        // self.voteIconArr默认存储了5个imageView.下面的代码就是比较model中的照片个数是否大于4，大于4则展示4个。
        NSInteger showCount = topicModel.daShangRenShu >= self.voteIconArr.count-1 ? self.voteIconArr.count-1:topicModel.daShangRenShu;
        for (NSInteger i = 0; i <= showCount; i ++) {
            NSLog(@"VoteCellForLoop");
            // 取出创建好的imageViewArr中的imageview展示
            UIImageView *imageView = self.voteIconArr[i];
            imageView.hidden = NO;
            if (i != showCount) {
                daShangRenInfoModel *infoModel = topicModel.dashangIconArr[i];
                [self imageView:imageView addImgWithUrlStr:[NSString stringWithFormat:@"%@",infoModel.userIcon] placeHolderImg:[UIImage imageNamed:@"dz_icon_article_default"] selector:@selector(voteUserIconClick:)];
            }else{
                // 最后一个图片不同，点击事件不同
                [self imageView:imageView addImgWithUrlStr:nil placeHolderImg:[UIImage imageNamed:@"navigationbar_more"] selector:@selector(moreImgClicked:)];
                imageView.layer.borderWidth = 1;
                imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }
        }
        
        
    }else{
        // 不做操作，默认就是显示让打赏吧的label
    }
  [self layoutIfNeeded];
    // 把cell高度传递过去
    topicModel.topicVoteheight = self.totalCellHeight;
}
// 打赏栏的更多点击事件
- (void)moreImgClicked:(UIImageView *)sender{
    //
    NSLog(@"打赏栏的更多点击事件");
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToMoreIconWebWithUrl:)]) {
        [self.delegate pushToMoreIconWebWithUrl:self.topicModel.showAllUrl];
    }
    
}
// 打赏栏的用户头像点击事件
- (void)voteUserIconClick:(UIGestureRecognizer *)gesture{
   // UIView *gestureView = gesture.view;
   // NSInteger index = gestureView.tag -10086;
    // 到时候肯定需要这个参数，但是目前用不到。
    [self pushToPersonalMainPage];

}
// 举报
- (void)postToReportPage:(UIButton *)sender{
    NSLog(@"举报按钮的点击事件");
    if ([self.delegate respondsToSelector:@selector(pushToReport)]) {
        // 让自己的代理跳转页面
        [self.delegate pushToReport];
    }
    
}
// 赏点击方法
//- (void)shangAct{
//    NSLog(@"赏的点击方法");
//    if ([self.delegate respondsToSelector:@selector(pushToDashang)]) {
//        [self.delegate pushToDashang];
//    }
//}


@end
#pragma mark - replyCell 评论列表cell

@interface LQSBBSDetailReplyCell ()
@property (nonatomic,strong)UIImageView *headerImgV;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *timeLab;
@property (nonatomic,strong)UILabel *postionLabel;
//@property (nonatomic,strong)UILabel *replyContentLabel;
@property (nonatomic,strong)LQSArticleContentView *replyContentView;
@property (nonatomic,strong)UILabel *secReplyContentLabel;
@property (nonatomic,strong)UIImageView *bgImgView;
@property (nonatomic,strong)UIButton *reportBtn;// 举报按钮
@property (nonatomic,strong)UIView *replyBottomView;// 承载两个按钮的底部view
@property (nonatomic,strong)UIButton *replyBtn;// 回复按钮
@property (nonatomic,strong)UIButton *policeBtn;// 举报警察按钮
@end

@implementation LQSBBSDetailReplyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setupViews];
    return self;
}
- (void)setupViews{
    //抬头
    // 头像
    self.headerImgV = [[UIImageView alloc]init];
    [self.contentView addSubview:self.headerImgV];
    [self.headerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    self.headerImgV.layer.cornerRadius = 5;
    self.headerImgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sec1HeadAct)];
    [self.headerImgV addGestureRecognizer:tap];
    self.headerImgV.tag = 1001;
    // 用户名
    self.nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(55);
        make.top.equalTo(self.contentView.mas_top).offset(9);
        make.height.equalTo(@20);
    }];
    self.nameLabel.numberOfLines = 1;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = [UIColor grayColor];
    // timeLabel
    self.timeLab = [[UILabel alloc]init];
    [self.contentView addSubview:self.timeLab];
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(55);
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.height.equalTo(@20);
    }];
    self.timeLab.numberOfLines = 1;
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.font = [UIFont systemFontOfSize:12];
    self.timeLab.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    // 楼层label
    self.postionLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.postionLabel];
    [self.postionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    self.postionLabel.numberOfLines = 1;
    self.postionLabel.textAlignment = NSTextAlignmentRight;
    self.postionLabel.font = [UIFont systemFontOfSize:12];
    self.postionLabel.textColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    _postionLabel.backgroundColor = [UIColor blueColor];
//    // 评论内容
//    self.replyContentLabel = [[UILabel alloc]init];
//    [self.contentView addSubview:self.replyContentLabel];
//    [self.replyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(55);
//        make.top.equalTo(self.timeLab.mas_bottom).offset(5);
////        make.width.equalTo(@(KLQScreenFrameSize.width- 55 - 78 - 10));
//        make.right.equalTo(self.contentView.mas_right).offset(-30);
//    }];
//    self.replyContentLabel.numberOfLines = 0;
//    self.replyContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    self.replyContentLabel.textAlignment = NSTextAlignmentLeft;
//    self.replyContentLabel.font = [UIFont systemFontOfSize:15];
//    self.replyContentLabel.textColor = [UIColor blackColor];
//    self.replyContentLabel.preferredMaxLayoutWidth = LQSScreenW - 85;
    // 评论内容view
    self.replyContentView = [[LQSArticleContentView alloc]init];
    [self.contentView addSubview:self.replyContentView];
    [self.replyContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView.mas_left).offset(55);
                make.top.equalTo(self.timeLab.mas_bottom).offset(5);
        //        make.width.equalTo(@(KLQScreenFrameSize.width- 55 - 78 - 10));
                make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];
    self.replyContentView.preferredMaxLayoutWidth = LQSScreenW - 85;
    self.replyContentView.scrollEnabled = NO;
    self.replyContentView.editable = NO;
// 二级回复的底部图片
    _bgImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_bgImgView];
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.replyContentView.mas_left).offset(3);
        make.top.equalTo(self.replyContentView.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
    }];
    // 二级评论
    self.secReplyContentLabel = [[UILabel alloc]init];
    [self.bgImgView addSubview:self.secReplyContentLabel];
    [self.secReplyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgImgView.mas_left).offset(3);
        make.top.equalTo(self.bgImgView.mas_top).offset(5);
        make.right.equalTo(self.bgImgView.mas_right);
    }];
    self.secReplyContentLabel.numberOfLines = 0;
    self.secReplyContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.secReplyContentLabel.textAlignment = NSTextAlignmentLeft;
    self.secReplyContentLabel.font = [UIFont systemFontOfSize:15];
    self.secReplyContentLabel.textColor = [UIColor blackColor];
    self.secReplyContentLabel.preferredMaxLayoutWidth = LQSScreenW - 85;
    // 回复按钮
    self.reportBtn = [[UIButton alloc]init];
    [self.contentView addSubview:self.reportBtn];
    [self.reportBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.bgImgView.mas_bottom).offset(5);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    [self.reportBtn setImage:[UIImage imageNamed:@"dz_posts_manage_btn"] forState:UIControlStateNormal];
    [self.reportBtn setImageEdgeInsets:UIEdgeInsetsMake(6, 10, 6, 10)];
    [self.reportBtn addTarget:self action:@selector(reportAct:) forControlEvents:UIControlEventTouchUpInside];
    self.reportBtn.backgroundColor = [UIColor whiteColor];
    // 警察和回复的底部view
    self.replyBottomView = [[UIView alloc]init];
    [self.contentView addSubview:self.replyBottomView];
    [self.replyBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self.reportBtn);
        make.width.equalTo(@160);
    }];
    [self.contentView insertSubview:self.replyBottomView belowSubview:self.reportBtn];
    self.replyBottomView.backgroundColor = [UIColor grayColor];
    self.replyBottomView.layer.cornerRadius = 5;
    // 警察按钮
    self.policeBtn = [[UIButton alloc]init];
    [self.replyBottomView addSubview:self.policeBtn];
    [self.policeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.bottom.equalTo(self.replyBottomView);
        make.right.equalTo(self.replyBottomView.mas_centerX);
    }];
    [self.policeBtn setImage:[UIImage imageNamed:@"dz_posts_manage_report"] forState:UIControlStateNormal];
    [self.policeBtn setTitle:@"举报" forState:UIControlStateNormal];
    [_policeBtn addTarget:self action:@selector(postToReportPage:) forControlEvents:UIControlEventTouchUpInside];
    //中间的竖线
    UIView *lineView = [[UIView alloc]init];
    [self.replyBottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.policeBtn.mas_right);
        make.top.equalTo(self.replyBottomView.mas_top).offset(3);
        make.bottom.equalTo(self.replyBottomView.mas_bottom).offset(-3);
        make.width.equalTo(@1);
    }];
    lineView.backgroundColor = [UIColor whiteColor];
    // 评论按钮
    self.replyBtn = [[UIButton alloc]init];
    [self.replyBottomView addSubview:self.replyBtn];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right);
        make.top.and.bottom.and.right.equalTo(self.replyBottomView);
    }];
    [self.replyBtn setImage:[UIImage imageNamed:@"dz_board_icon_reply"] forState:UIControlStateNormal];
    [self.replyBtn setTitle:@"回复" forState:UIControlStateNormal];
    [self.replyBtn addTarget:self action:@selector(pushToReply:) forControlEvents:UIControlEventTouchUpInside];
    
}
//- (void)sec1HeadAct{
//    [super sec1HeadAct];
//}
- (void)pushToReply:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pushToReply)]){
        [self.delegate pushToReply];
    }
}
// 评论列表底部的回复按钮点击事件
- (void)reportAct:(UIButton *)sender{
    [UIView animateWithDuration:0.4 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (self.replyBottomView.x == sender.x) {
            self.replyBottomView.x -= self.replyBottomView.width;
        }else{
            self.replyBottomView.x = sender.x;
        }
    } completion:nil];
}
-(void)setPinglunModel:(LQSBBSPosterModel *)pinglunModel{
    _pinglunModel = pinglunModel;
    // 根据传过来的数据配置头像
    UIImage *img = [UIImage imageNamed:@"mc_forum_add_new_img.png"];
    NSString *imgURLStr = pinglunModel.icon;
    if (imgURLStr.length > 0) {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(imgURLStr)] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!image) {
                self.headerImgV.image = img;
            }else{
                self.headerImgV.image = image;
            }
        }];
    }else{
        self.headerImgV.image = img;
    }
    //  配置昵称
    self.nameLabel.text = LQSTR(pinglunModel.reply_name);
    // 配置时间label
    self.timeLab.text = LQSTR(pinglunModel.posts_date);
    // 楼层
    self.postionLabel.text = [NSString stringWithFormat:@"%@楼",pinglunModel.position];
    // 此处的楼层label的位置是固定的，以后可以看UI设计来改。
    // 一级评论内容展示
//    NSDictionary *dic = pinglunModel.reply_content[0];
//    self.replyContentLabel.text = dic[@"infor"];
    self.replyContentView.content = self.pinglunModel.reply_content;
    if ([pinglunModel.is_quote integerValue] == 1) {
        
//        NSLog(@"二级评论内容:%@",pinglunModel.quote_content);
        CGRect rec = [pinglunModel.quote_content boundingRectWithSize:CGSizeMake(kScreenWidth - 85, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil];
        [self.bgImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(rec.size.height+10));
            
        }];
        UIImage * frameImg1 = [UIImage imageNamed:@"dz_toolbar_reply_outer_bg"];
        frameImg1 = [frameImg1 stretchableImageWithLeftCapWidth:frameImg1.size.width/2 topCapHeight:frameImg1.size.height/2];
        [_bgImgView setImage:frameImg1];
        self.secReplyContentLabel.text = pinglunModel.quote_content;
        _bgImgView.hidden = NO;
        self.secReplyContentLabel.hidden = NO;// 之前不显示竟然是因为在这里忘了设置secReplyContenLabel.hidden = NO了。。。
    }else{
        self.secReplyContentLabel.hidden = YES;
        self.bgImgView.hidden = YES;
    }
    // 强制布局
    [self layoutIfNeeded];
    pinglunModel.contentHeight = CGRectGetMaxY(self.reportBtn.frame)+20;
}

@end

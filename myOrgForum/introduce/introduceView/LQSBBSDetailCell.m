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

@implementation LQSBBSDetailTitleCell

-(void)setCellWithData:(id)modelData indexpath:(NSIndexPath *)indexpath{
    LQSBBSDetailTopicModel *model = modelData;
//    [self setCellForSection0WithModal:model];
    UILabel *titleLab;
    [LQSAddViewHelper addLable:&titleLab withFrame:CGRectMake(15, 10, KLQScreenFrameSize.width - 15 - 25, 39) text:LQSTR(model.title) textFont:[UIFont boldSystemFontOfSize:15] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineNumber:2 tag:0 superView:self.contentView];
    UIImageView *scanImgView;
    [LQSAddViewHelper addImageView:&scanImgView frame:CGRectMake(15, 50, 12, 11) tag:0 image:[UIImage imageNamed:@"mc_forum_ico53_n"] superView:self.contentView imgUrlStr:@"" selector:nil];
    UILabel *scanLab;
    [LQSAddViewHelper addLable:&scanLab withFrame:CGRectMake(32, 49, KLQScreenFrameSize.width - 32 - 25, 14) text:LQSTR(model.hits) textFont:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    if ([model.essence  isEqual: @1]) {
        UILabel *essenceLab;
        [LQSAddViewHelper addLable:&essenceLab withFrame:CGRectMake(KLQScreenFrameSize.width - 10 -16, 10, 16, 16) text:@"精" textFont:[UIFont boldSystemFontOfSize:13] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter lineNumber:1 tag:0 superView:self.contentView];
        essenceLab.layer.cornerRadius = 2;
        essenceLab.clipsToBounds = YES;
        essenceLab.backgroundColor = [UIColor redColor];
    }
    self.isCreated = YES;
}
@end
#pragma  mark - contentCell 帖子内容

@interface LQSBBSDetailContentCell()
// 举报警察按钮
@property (nonatomic,strong)UIButton *policeBtn;
@end
@implementation LQSBBSDetailContentCell

-(void)setCellWithData:(id)modelData indexpath:(NSIndexPath *)indexpath
{
    LQSBBSDetailTopicModel *model = modelData;
//    [self setCellForContentSection1WithModal:model];
    //抬头
    UIImageView *userImgView;
    // 在这个类里面又有LQSAddViewHelper的同名方法.而且目测没什么不同...但是调用LQSAddViewHelper的方法会崩,不知前面为什么这么写,现在改成用self调用自己的方法。
    //  [LQSAddViewHelper addImageView:&userImgView frame:CGRectMake(10, 10, 40, 40) tag:1001 image:[UIImage imageNamed:@"mc_forum_add_new_img.png"] superView:self.contentView imgUrlStr:self.myCtrl.bbsDetailModel.icon selector:@selector(sec1HeadAct)];
    [self addImageView:&userImgView frame:CGRectMake(10, 10, 40, 40) tag:1001 image:[UIImage imageNamed:@"mc_forum_add_new_img.png"] superView:self.contentView imgUrlStr:model.icon selector:@selector(sec1HeadAct)];
    userImgView.clipsToBounds = YES;
    userImgView.layer.cornerRadius = 5;
    
    UILabel *userNameLab;
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [model.user_nick_name  boundingRectWithSize:CGSizeMake(KLQScreenFrameSize.width - 55 - 78 - 10, 20) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    [LQSAddViewHelper addLable:&userNameLab withFrame:CGRectMake(55, 9, rect.size.width, 20) text:model.user_nick_name textFont:[UIFont systemFontOfSize:15] textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    
    UILabel *titleNamelab;
    CGFloat x = CGRectGetMaxX(userNameLab.frame);
    x += 5;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rectForTitle = [model.userTitle  boundingRectWithSize:CGSizeMake(KLQScreenFrameSize.width - 55 - 78 - 10, 20) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    [LQSAddViewHelper addLable:&titleNamelab withFrame:CGRectMake(x, 9, rectForTitle.size.width, 20) text:model.userTitle textFont:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithRed:0.8 green:0.5 blue:0.3 alpha:1] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    
    UILabel *timeLab;
    NSLog(@"createDate:%@",model.create_date);
    [LQSAddViewHelper addLable:&timeLab withFrame:CGRectMake(55, CGRectGetMaxY(userNameLab.frame), 200, 20) text:/*@"1天前"*/LQSTR(model.create_date) textFont:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    
    UIButton *guanzhuBtn;
    // isFollow:0表示未关注,1表示已关注
    NSString *isFollow = kGUANZHUTA;// 设置默认为未关注.
    if (model.isFollow) {
        NSLog(@"isfollow:%zd",model.isFollow);
        isFollow = model.isFollow == 0 ?  kGUANZHUTA : kYIGUANZHUTA;
    }
    [self addButton:&guanzhuBtn frame:CGRectMake(KLQScreenFrameSize.width - 10 - 78, 9, 78, 25) title:isFollow titleFont:[UIFont systemFontOfSize:13] titleColor:[UIColor blackColor] borderwidth:KSingleLine_Width cornerRadius:0 selector:@selector(guanzhuTA:) superView:self.contentView];
    //内容
    LQSArticleContentView *articleView = [[LQSArticleContentView alloc] initWithFrame:CGRectMake(11, 55.0f, KLQScreenFrameSize.width-22, 500)];
    articleView.preferredMaxLayoutWidth = KLQScreenFrameSize.width-30;
    articleView.content = model.content;
    articleView.scrollEnabled = NO;
    articleView.editable = NO;
    articleView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:articleView];
    [articleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(55, 15, 40, 15));// 之前是(55,15,10,15),改为40,为留出举报按钮的高度
    }];
    self.articleContentView = articleView;
    // 举报按钮,articleView距离底部为40,这里设定举报按钮高28,距离上面6,下面6
    UIButton *reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(KLQScreenFrameSize.width-40, CGRectGetMaxY(self.contentView.frame)-34, 50, 28)];
    [reportBtn setImage:[UIImage imageNamed:@"dz_posts_manage_btn"] forState:UIControlStateNormal];
    [reportBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 20)];
    [reportBtn addTarget:self action:@selector(reportAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:reportBtn];
    reportBtn.backgroundColor = [UIColor blueColor];
    
    // 警察按钮
    self.policeBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMinX(reportBtn.frame), CGRectGetMinY(reportBtn.frame), 80, 28)];
    _policeBtn.layer.cornerRadius = 5;
    [_policeBtn setTitle:@"举报" forState:UIControlStateNormal];
    [_policeBtn setImage:[UIImage imageNamed:@"dz_posts_manage_report"] forState:UIControlStateNormal];
    [_policeBtn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 0)];
    [self.contentView addSubview:_policeBtn];
    [self.contentView insertSubview:_policeBtn belowSubview:reportBtn];
    _policeBtn.tintColor = [UIColor whiteColor];
    _policeBtn.backgroundColor = [UIColor grayColor];
    _policeBtn.tag = 1100;
    [_policeBtn addTarget:self action:@selector(postToReportPage:) forControlEvents:UIControlEventTouchUpInside];
    [self setNeedsLayout];
    self.isCreated = YES;
}
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
                    LQSBBSDetailViewController *detailVC = self.delegate;
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
    }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"只看作者" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        // 处理只看作者的点击事件
        NSLog(@"只看作者");
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    [(UIViewController *)self.delegate presentViewController:alertController animated:YES completion:nil];
    
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

@end
#pragma mark - voteCell 打赏cell

@implementation LQSBBSDetailVoteCell

-(void)setCellWithData:(id)modelData indexpath:(NSIndexPath *)indexpath
{
    // 打赏文字label
    UILabel *daShangLabel;
    [LQSAddViewHelper addLable:&daShangLabel withFrame:CGRectMake(0, 0,KLQScreenFrameSize.width - 80, 75) text:@"内容不错就任性地打赏吧!" textFont:[UIFont systemFontOfSize:15] textColor:/*[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]*/[UIColor grayColor] textAlignment:NSTextAlignmentCenter lineNumber:1 tag:0 superView:self.contentView];
    // 竖线lineView
    UIView *lineView2;
    [LQSAddViewHelper addLine:&lineView2 withFrame:CGRectMake(CGRectGetMaxX(daShangLabel.frame), 15, 1, 45) superView:self.contentView color:[UIColor grayColor]];
    // 赏图标
    UIButton *shangBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView2.frame) + 10, 15, 45, 45)];
    [shangBtn setBackgroundImage:[UIImage imageNamed:@"dz_posts_grade"] forState:UIControlStateNormal];
    [shangBtn setBackgroundImage:[UIImage imageNamed:@"dz_posts_grade"] forState:UIControlStateHighlighted];
    [shangBtn addTarget:self action:@selector(shangAct) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:shangBtn];
    self.isCreated = YES;
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
@end
#pragma mark - replyCell 评论列表cell

@implementation LQSBBSDetailReplyCell

-(void)setCellWithData:(id)modelData indexpath:(NSIndexPath *)indexpath
{
    if (!self.isCreated) {
        NSLog(@"replyCell");
        
    }else{
        NSLog(@"复用错啦兄哋");
        while (self.contentView.subviews.lastObject != nil) {
            [self.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    LQSBBSPosterModel* pinglunModel = modelData;
    //    [self setCellForContentSection3WithModel:(LQSBBSPosterModel *)pinglunModel];
    // 从传过来的bbsDetailModel.list中根据index获取对应的数据。
    //抬头
    UIImageView *userImgView;
    [self addImageView:&userImgView frame:CGRectMake(10, 10, 40, 40) tag:1001 image:[UIImage imageNamed:@"mc_forum_add_new_img.png"] superView:self.contentView imgUrlStr:pinglunModel.icon selector:@selector(sec1HeadAct)];
    userImgView.clipsToBounds = YES;
    userImgView.layer.cornerRadius = 5;
    
    UILabel *userNameLab;
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect rect = [pinglunModel.reply_name  boundingRectWithSize:CGSizeMake(KLQScreenFrameSize.width - 55 - 78 - 10, 20) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
    [LQSAddViewHelper addLable:&userNameLab withFrame:CGRectMake(55, 9, rect.size.width, 20) text:pinglunModel.reply_name textFont:[UIFont systemFontOfSize:15] textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    UILabel *timeLab;
    //    NSLog(@"createDate:%@",self.myCtrl.bbsDetailModel.create_date);
    [LQSAddViewHelper addLable:&timeLab withFrame:CGRectMake(55, CGRectGetMaxY(userNameLab.frame), 200, 20) text:LQSTR(pinglunModel.posts_date) textFont:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
    // 楼层
    UILabel *postionLabel;
    // 此处的楼层label的位置是固定的，以后可以看UI设计来改。
    [LQSAddViewHelper addLable:&postionLabel withFrame:CGRectMake(self.contentView.width - 50, 5, 40, 20) text:[NSString stringWithFormat:@"%@楼",pinglunModel.position] textFont:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1] textAlignment:NSTextAlignmentRight lineNumber:1 tag:0 superView:self.contentView];
    postionLabel.backgroundColor = [UIColor blueColor];
    // 一级评论内容展示
    UILabel *replyContentLabel = [[UILabel alloc]init];
    NSDictionary *dic = pinglunModel.reply_content[0];
    //    replyContentLabel.numberOfLines = 0;
    //    replyContentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [LQSAddViewHelper addLable:&replyContentLabel withFrame:CGRectMake(55, CGRectGetMaxY(timeLab.frame)+5, KLQScreenFrameSize.width - 55 - 78 - 10, pinglunModel.contentHeight) text:dic[@"infor"] textFont:[UIFont systemFontOfSize:15] textColor:[UIColor grayColor] textAlignment:NSTextAlignmentLeft lineNumber:0 tag:0 superView:self.contentView];
    self.isCreated = YES;
}

@end

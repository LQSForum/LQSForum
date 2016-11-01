//
//  LQSintroduceMainlistCell.m
//  myOrgForum
//
//  Created by XJW on 16/8/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSintroduceMainlistCell.h"
#import "SDWebImageManager.h"
#import "LQSBBSDetailViewController.h"
#import "LQSHTMLViewController.h"

#define KBUTTON_TAG_BEGAN 2016081010
#define KXFXZBTN_TAG_BEGAN 2016081020
#define KIMGTAG_BEGAN 20160815100

@interface LQSintroduceMainlistCell()

@property (nonatomic, strong) NSTimer *adTiner;
@property (nonatomic, strong) UIScrollView *bottomScrollowA;
@property (nonatomic, strong) UIPageControl *pageCtrlA;
@property (nonatomic, strong) NSIndexPath *indexP;
@property (nonatomic, assign) BOOL isCreated;
@property (nonatomic, strong) NSArray *btnArr;//8个按钮数据

@end

@implementation LQSintroduceMainlistCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.isCreated) {
        [self setCellForIndexPath];
    }
}


- (void)setCellForIndexPath
{
    if (self) {
        NSIndexPath *indexPath = self.paramDict[@"indexPath"];
        self.indexP = indexPath;
        switch (indexPath.section) {
            case 0:{
                NSArray *dataArr = self.paramDict[@"data"];
                if (dataArr.count > 0) {
                    self.height = KLQScreenFrameSize.width *380/750;
                    [self createLunBoCellWithData:dataArr];
                    self.contentView.backgroundColor = [UIColor grayColor];
                }
                break;
            }case 1:{
                if (self.btnArr == nil) {
                    self.btnArr = self.paramDict[@"data"];
                    self.height = (self.btnArr.count/4)*(180/750);
                    [self createButtonsWithData:self.btnArr];
//                    NSLog(@"%@",self.btnArr);
                }
                
                break;
            }
    //            case 2:{
//                LQSIntroduceMainListModel *model = self.paramDict[@"data"];
//                if (model) {
//                    self.height = KLQScreenFrameSize.width *180/750;
//                    [self createLQwensixiu:model];
//                }
//                break;
//            }
            case 2:{
                NSArray *dataArr = self.paramDict[@"data"];
                if (dataArr.count > 0) {
                    self.height = KLQScreenFrameSize.width *380/750;
                    
                    [self createXuefoxiaozu:dataArr];
                }
                self.isCreated = YES;
                break;
            }case 3:{
                NSArray *dataArr = self.paramDict[@"data"];
                if (dataArr.count > 0) {
                    self.height = KLQScreenFrameSize.width *230/750;
                    [self createLunBoCellWithData:dataArr];
                }
                self.isCreated = YES;
                break;
            }case 4:{
//                图片
//                165*130
//                15
//                title
                NSArray *dataArr = self.paramDict[@"data"];
                if (dataArr[indexPath.row]) {
                    self.height = KLQScreenFrameSize.width *180/750;
                    [self createFaYuKaiShiFor:dataArr[indexPath.row]];
                }
               self.isCreated = YES;
                break;
            }
            default:
                break;
        }
       
        
    }

}

#pragma mark - 师父法语开示
- (void)createFaYuKaiShiFor:(LQSIntroduceMainListModel *)model
{
    CGFloat labX = LQSgetwidth(20);
    if (model.icon.length > 0) {
        labX += LQSgetwidth(165);
        labX += LQSgetwidth(20);
        UIImageView *imgView;
        [self addImageView:&imgView frame:CGRectMake(LQSgetwidth(20), LQSgetHeight(15), LQSgetwidth(165), LQSgetHeight(130)) tag:0 superView:self.contentView imgUrlStr:model.icon];
    }
    UILabel *titleLab;
    [self addLable:&titleLab withFrame:CGRectMake(labX, LQSgetHeight(15), self.frame.size.width - labX - LQSgetwidth(20), LQSgetHeight(100)) text:model.desc textFont:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft lineNumber:2 tag:0 superView:self.contentView];
    
    UILabel *timeLab;
    [self addLable:&timeLab withFrame:CGRectMake(labX, self.frame.size.height - LQSgetHeight(15) - 10, 100, 10) text:@"几个小时" textFont:[UIFont systemFontOfSize:11] textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
        
    UIView *line;
    [self addLine:&line withFrame:CGRectMake(0, self.frame.size.height - KSingleLine_Width, self.frame.size.width, KSingleLine_Width) superView:self.contentView color:[UIColor lightGrayColor]];

}

#pragma mark - 学佛小组
- (void)createXuefoxiaozu:(NSArray *)modelArr
{
    if (modelArr.count >= 4) {
        
        LQSIntroduceMainListModel *model1 = modelArr[0];
        UIButton *btn1;
        [self addButton:&btn1 WithModel:model1 frame:CGRectMake(0, 0, (self.frame.size.width - 4)/2 , self.frame.size.height/2) imgViewFrame:CGRectMake(0, 0, (self.frame.size.width - 2)/2 , self.frame.size.height/2) titleLabFrame:CGRectZero backgroundColor:[UIColor clearColor] superView:self.contentView tag:KXFXZBTN_TAG_BEGAN + 1 selector:@selector(xuefoxiaozuClick:)];
        UIView *line;
        [self addLine:&line withFrame:CGRectMake(btn1.frame.size.width + 1, 8, KSingleLine_Width, self.frame.size.height - 16) superView:self.contentView color:[UIColor lightGrayColor]];
        LQSIntroduceMainListModel *model2 = modelArr[1];
        UIButton *btn2;
        [self addButton:&btn2 WithModel:model2 frame:CGRectMake((self.frame.size.width - KSingleLine_Width)/2, 0, (self.frame.size.width - KSingleLine_Width)/2 , self.frame.size.height/2) imgViewFrame:CGRectMake(0, 0, (self.frame.size.width - 2)/2 , self.frame.size.height/2) titleLabFrame:CGRectZero backgroundColor:[UIColor clearColor] superView:self.contentView tag:KXFXZBTN_TAG_BEGAN + 2 selector:@selector(xuefoxiaozuClick:)];
#warning 添加上下横线
        
        
        LQSIntroduceMainListModel *model3 = modelArr[2];
        UIButton *btn3;
        [self addButton:&btn3 WithModel:model3 frame:CGRectMake(0, self.frame.size.height/2, (self.frame.size.width - 4)/2 , self.frame.size.height/2) imgViewFrame:CGRectMake(0, 0, (self.frame.size.width - 2)/2 , self.frame.size.height/2) titleLabFrame:CGRectZero backgroundColor:[UIColor clearColor] superView:self.contentView tag:KXFXZBTN_TAG_BEGAN + 3 selector:@selector(xuefoxiaozuClick:)];
        UIView *line2;
        [self addLine:&line2 withFrame:CGRectMake(btn1.frame.size.width + 1, 8+self.frame.size.height/2, KSingleLine_Width, self.frame.size.height/2 - 16) superView:self.contentView color:[UIColor lightGrayColor]];
        LQSIntroduceMainListModel *model4 = modelArr[3];
        UIButton *btn4;
        [self addButton:&btn4 WithModel:model4 frame:CGRectMake((self.frame.size.width - KSingleLine_Width)/2, self.frame.size.height/2, (self.frame.size.width - KSingleLine_Width)/2 , self.frame.size.height/2) imgViewFrame:CGRectMake(0, 0, (self.frame.size.width - 2)/2 , self.frame.size.height/2) titleLabFrame:CGRectZero backgroundColor:[UIColor clearColor] superView:self.contentView tag:KXFXZBTN_TAG_BEGAN + 4 selector:@selector(xuefoxiaozuClick:)];
    }
}


- (void)xuefoxiaozuClick:(UIButton *)sender
{
#warning 完善点击方法
    //tag值 1 2
    if (sender.tag - KXFXZBTN_TAG_BEGAN == 1) {
        //龙泉闻思修
        NSLog(@"龙泉闻思修");
    }else if(sender.tag - KXFXZBTN_TAG_BEGAN ==2){
        //贤二数据组报名
        NSLog(@"贤二数据组报名");
    }else if(sender.tag - KXFXZBTN_TAG_BEGAN ==3){
        //活动报名
        NSLog(@"活动报名");
    }else if(sender.tag - KXFXZBTN_TAG_BEGAN ==4){
        //学佛小组报名
        NSLog(@"点击学佛小组报名");
    }else{
        //不会走
    }
}
#pragma mark - 龙泉闻思修
//- (void)createLQwensixiu:(LQSIntroduceMainListModel *)model
//{
//    UIImageView *imgView;
//    [self addImageView:&imgView frame:CGRectMake(0, 0, self.width, self.height) tag:(self.indexP.section * 10 + KIMGTAG_BEGAN) superView:self.contentView imgUrlStr:model.icon];
//}

#pragma mark - 第二个 八个按钮
- (void)createButtonsWithData:(NSArray *)modeArr
{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = KLQScreenFrameSize.width/4;
    CGFloat h = KLQScreenFrameSize.width*180/750;
   
    for (NSInteger i = 0; i < modeArr.count; i++) {
        LQSIntroduceMainListModel *model = modeArr[i];
        CGRect frame = CGRectMake(x+(i%4*w), y+(i/4*h), w, h);
        UIButton *btn;
        [self addButton:&btn WithModel:model frame:frame imgViewFrame:CGRectMake((KLQScreenFrameSize.width/4 - 45)/2, 10, 45, 45) titleLabFrame:CGRectMake(0, frame.size.height - 22, frame.size.width, 20) backgroundColor:[UIColor whiteColor] superView:self.contentView tag:KBUTTON_TAG_BEGAN + i selector:@selector(buttonCilck:)];
    }
}

- (void)buttonCilck:(UIButton *)sender
{
#warning 完善点击事件
//    NSLog(@"点击8个按钮");
    switch (sender.tag - KBUTTON_TAG_BEGAN) {
        case 0:{
            NSURL *url = [NSURL URLWithString:@"http://wap.longquanzs.org"];
            LQSHTMLViewController *htmlVc = [[LQSHTMLViewController alloc]init];
            [htmlVc loadHtmlControllerWithUrl:url];
            [self.myCtrl.navigationController pushViewController:htmlVc animated:YES];
            
            break;
        }case 1:{
            NSURL *url = [NSURL URLWithString:@"http://blog.sina.cn/dpool/blog/xuecheng"];
            LQSHTMLViewController *htmlVc = [[LQSHTMLViewController alloc]init];
            [htmlVc loadHtmlControllerWithUrl:url];
            [self.myCtrl.navigationController pushViewController:htmlVc animated:YES];
            break;
        }case 2:{
            NSURL *url = [NSURL URLWithString:@"http://weibo.cn/xuecheng?&jumpfrom=weibocom"];
            LQSHTMLViewController *htmlVc = [[LQSHTMLViewController alloc]init];
            [htmlVc loadHtmlControllerWithUrl:url];
            [self.myCtrl.navigationController pushViewController:htmlVc animated:YES];
            break;
        }case 3:{
            LQSHTMLViewController *htmlVc = [[LQSHTMLViewController alloc]init];
            [htmlVc loadVideoView];
            [self.myCtrl.navigationController pushViewController:htmlVc animated:YES];
            break;
        }
            
        default:
            break;
    }

}

- (void)addButton:(UIButton **)button WithModel:(LQSIntroduceMainListModel *)model frame:(CGRect)frame imgViewFrame:(CGRect)imgFrame titleLabFrame:(CGRect)labFrame backgroundColor:(UIColor *)color superView:(UIView *)superVew tag:(NSInteger)tag selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [superVew addSubview:btn];
    btn.frame = frame;
    btn.tag = tag;
    [btn setBackgroundColor:color];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    if (!CGRectEqualToRect(imgFrame, CGRectZero)) {
        UIImageView *imgView;
        [self addImageView:&imgView frame:imgFrame tag:0 superView:btn imgUrlStr:model.icon];
    }
   
    if (!CGRectEqualToRect(labFrame, CGRectZero)) {
        UILabel *btnTitleLab;
        [self addLable:&btnTitleLab withFrame:labFrame text:model.desc textFont:[UIFont systemFontOfSize:11] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter lineNumber:1 tag:0 superView:btn];
    }
    
    *button = btn;
    
}

#pragma mark - 第一个轮播section
- (void)createLunBoCellWithData:(NSArray *)modelArr
{
    UIView *contentview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    contentview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentview];
    _bottomScrollowA = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [contentview addSubview:_bottomScrollowA];
    _bottomScrollowA.backgroundColor = [UIColor grayColor];
    _bottomScrollowA.pagingEnabled = YES;
    _bottomScrollowA.showsHorizontalScrollIndicator = NO;
    _bottomScrollowA.showsVerticalScrollIndicator = NO;
    NSInteger pageCount = modelArr.count;
    if (pageCount == 1) {
        _bottomScrollowA.contentSize = CGSizeMake(KLQScreenFrameSize.width, self.frame.size.height);
        _bottomScrollowA.contentOffset = CGPointMake(0, 0);
//        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KLQScreenFrameSize.width, self.frame.size.height)];
//        [_bottomScrollowA addSubview:imgView];
        LQSIntroduceMainListModel *model = modelArr[0];
        UIImageView *imgView;
        [self addImageView:&imgView frame:CGRectMake(0, 0, KLQScreenFrameSize.width, self.frame.size.height) tag:KIMGTAG_BEGAN + (self.indexP.section*10) + 1 superView:_bottomScrollowA imgUrlStr:LQSTR(model.icon)];
        UILabel *bgLab;
        [self addLable:&bgLab withFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20) text:nil textFont:nil textColor:nil textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];
        bgLab.backgroundColor = [UIColor blackColor];
        bgLab.alpha = 0.6;
        UILabel *titleLab;
        
        [self addLable:&titleLab withFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20) text:LQSTR(model.desc) textFont:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.contentView];

    }else{
        _bottomScrollowA.contentSize = CGSizeMake(KLQScreenFrameSize.width * (pageCount+1), self.frame.size.height);
        _bottomScrollowA.contentOffset = CGPointMake(self.frame.size.width, 0);
        for (NSInteger i = 0; i < pageCount + 1; i++) {
            CGRect imgFrame = CGRectMake(KLQScreenFrameSize.width * i, 0, KLQScreenFrameSize.width, self.frame.size.height);
            
            NSString *imgUrlStr = @"";
            NSString *titleStr = @"";
            if (i == 0) {
                imgUrlStr = ((LQSIntroduceMainListModel *)[modelArr lastObject]).icon;
                titleStr = ((LQSIntroduceMainListModel *)[modelArr lastObject]).desc;
            }else{
                imgUrlStr = ((LQSIntroduceMainListModel *)[modelArr objectAtIndex:i-1]).icon;
                titleStr = ((LQSIntroduceMainListModel *)[modelArr objectAtIndex:i-1]).desc;
            }
            
            UIImageView *imgView;
            [self addImageView:&imgView frame:imgFrame tag:KIMGTAG_BEGAN + (self.indexP.section*10) + i superView:_bottomScrollowA imgUrlStr:LQSTR(imgUrlStr)];
            //title
            UILabel *bgLab;
            [self addLable:&bgLab withFrame:CGRectMake(self.frame.size.width * i, self.frame.size.height - 20, self.frame.size.width, 20) text:nil textFont:nil textColor:nil textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.bottomScrollowA];
            bgLab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            UILabel *titleLab;
            [self addLable:&titleLab withFrame:CGRectMake(self.frame.size.width * i + 5, self.frame.size.height - 20, self.frame.size.width - 75, 20) text:LQSTR(titleStr) textFont:[UIFont systemFontOfSize:12] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft lineNumber:1 tag:0 superView:self.bottomScrollowA];
            
        }
        //添加点击事件
        
        //指示器
        _pageCtrlA = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, self.frame.size.height - 15, 65, 10)];
        _pageCtrlA.numberOfPages = pageCount;
        _pageCtrlA.userInteractionEnabled = NO;
        _pageCtrlA.backgroundColor = [UIColor clearColor];
        _pageCtrlA.currentPage = 0;
        [self addSubview:_pageCtrlA];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
            _pageCtrlA.pageIndicatorTintColor = [UIColor grayColor];
            _pageCtrlA.currentPageIndicatorTintColor = [UIColor whiteColor];
        }
        
        //添加定时器
        if (!self.adTiner) {
            self.adTiner = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changePage) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.adTiner forMode:NSRunLoopCommonModes];
        }
        
        
        
    }
}
//点击事件
#warning 完善点击事件

//定时器事件
- (void)changePage
{
    NSInteger offsetX = (NSInteger)(self.bottomScrollowA.contentOffset.x/KLQScreenFrameSize.width)*KLQScreenFrameSize.width;
    
    CGPoint currentOffset = CGPointMake(offsetX, 0);
    if (currentOffset.x<self.bottomScrollowA.contentSize.width-KLQScreenFrameSize.width) {
        currentOffset.x+=KLQScreenFrameSize.width;
        [self.bottomScrollowA setContentOffset:currentOffset animated:NO];
        
    }else{
        [self.bottomScrollowA setContentOffset:CGPointZero animated:NO];
        [self.bottomScrollowA setContentOffset:CGPointMake(KLQScreenFrameSize.width, 0) animated:NO];
        
    }
    self.pageCtrlA.currentPage = self.bottomScrollowA.contentOffset.x/KLQScreenFrameSize.width - 1;

    
    
}

- (void)addImageView:(UIImageView **)imageView frame:(CGRect)frame tag:(NSInteger)tag superView:(UIView *)superView imgUrlStr:(NSString *)urlStr
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    [superView addSubview:imgView];
    imgView.tag = tag;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(urlStr)] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        imgView.image = image;
    }];
    if (tag != 0) {
       imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick:)];
        [imgView addGestureRecognizer:tap];
    }
    
    *imageView = imgView;
}

- (void)imgClick:(UITapGestureRecognizer *)tap
{
    UIView *superView = [tap view];
    NSInteger tag = superView.tag - KIMGTAG_BEGAN;
    if (tag/10 == 0) {
        NSLog(@"点击第一轮播图第%ld个图片",(tag%10));
        NSInteger i = tag%10 - 1;
        NSIndexPath *indexPath = self.paramDict[@"indexPath"];
        if (indexPath.section == 0) {
            NSArray *dataArr = self.paramDict[@"data"];
            LQSIntroduceMainListModel *model = (LQSIntroduceMainListModel *)dataArr[i];
            if (nil != model ) {
                LQSBBSDetailViewController *bbsDetailVC = [[LQSBBSDetailViewController alloc] init];
                bbsDetailVC.selectModel = model;
                [self.myCtrl.navigationController pushViewController:bbsDetailVC animated:YES];
            }
        }
        
    }
//    else if(tag/10 == 2){
//        NSLog(@"点击龙泉闻思修");
//    }
    else if(tag/10 == 4){
        NSLog(@"点击第二轮播图第%ld个图片",(tag%10));
    }
}

- (void)addLable:(UILabel **)lable withFrame:(CGRect)frame text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment )alignment lineNumber:(NSInteger)number tag:(NSInteger)tag superView:(UIView *)supView
{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.textColor = color;
    lab.font = font;
    lab.textAlignment = alignment;
    lab.tag = tag;
    lab.numberOfLines = number;
    [supView addSubview:lab];
    if (lable) {
        *lable = lab;
    }
    lab.backgroundColor = [UIColor clearColor];
}
- (void)addLine:(UIView **)lineView withFrame:(CGRect)frame superView:(UIView *)superView color:(UIColor *)color
{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    [superView addSubview:line];
    line.backgroundColor = color;
    *lineView = line;
}


@end

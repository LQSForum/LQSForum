//
//  LQSintroduceMainlistCell.m
//  myOrgForum
//
//  Created by XJW on 16/8/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSintroduceMainlistCell.h"
#import "SDWebImageManager.h"

#define KBUTTON_TAG_BEGAN 2016081010
#define KXFXZBTN_TAG_BEGAN 2016081020

@interface LQSintroduceMainlistCell()

@property (nonatomic, strong) NSTimer *adTiner;
@property (nonatomic, strong) UIScrollView *bottomScrollowA;
@property (nonatomic, strong) UIPageControl *pageCtrlA;


@end

@implementation LQSintroduceMainlistCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    
    return self;
}

- (void)setCellForIndexPath:(NSIndexPath *)indexPath
{
    if (self) {
        switch (indexPath.section) {
            case 0:{
                self.height = KLQScreenFrameSize.width *380/750;
                NSArray *dataArr = self.paramDict[@"data"];
                [self createLunBoCellWithData:dataArr];
                self.contentView.backgroundColor = [UIColor grayColor];
                break;
            }case 1:{
                NSArray *dataArr = self.paramDict[@"data"];
                self.height = (dataArr.count/4)*(180/750);
                if (dataArr.count > 0) {
                    [self createButtonsWithData:dataArr];
                }
                
                break;
            }case 2:{
                LQSIntroduceMainListModel *model = self.paramDict[@"data"];
                if (model) {
                    self.height = KLQScreenFrameSize.width *180/750;
                    [self createLQwensixiu:model];
                }
                break;
            }case 3:{
                NSArray *dataArr = self.paramDict[@"data"];
                if (dataArr.count > 0) {
                    self.height = KLQScreenFrameSize.width *190/750;
                    [self createXuefoxiaozu:dataArr];
                }
                
                break;
            }case 4:{
                self.height = KLQScreenFrameSize.width *230/750;
                
                break;
            }case 5:{
                self.height = KLQScreenFrameSize.width *180/750;
                break;
            }
            default:
                break;
        }
       
        
    }
}
#pragma mark - 学府小组
- (void)createXuefoxiaozu:(NSArray *)modelArr
{
    if (modelArr.count >= 2) {
        LQSIntroduceMainListModel *model1 = modelArr[0];
        UIButton *btn1;
        [self addButton:&btn1 WithModel:model1 frame:CGRectMake(0, 0, (self.frame.size.width - 2)/2 , self.frame.size.height) superView:self.contentView tag:KXFXZBTN_TAG_BEGAN + 1 selector:@selector(xuefoxiaozuClick:)];
        UIView *line;
        [self addLine:&line withFrame:CGRectMake(self.frame.size.width/2 - 1, 8, 2, self.frame.size.height - 16) superView:self.contentView color:[UIColor lightGrayColor]];
        LQSIntroduceMainListModel *model2 = modelArr[1];
        UIButton *btn2;
        [self addButton:&btn2 WithModel:model2 frame:CGRectMake(self.frame.size.width/2+1, 0, (self.frame.size.width - 2)/2 , self.frame.size.height) superView:self.contentView tag:KXFXZBTN_TAG_BEGAN + 2 selector:@selector(xuefoxiaozuClick:)];
    }
}
- (void)xuefoxiaozuClick:(UIButton *)sender
{
#warning 完善点击方法
    //tag值 1 2
}
#pragma mark - 龙泉闻思修
- (void)createLQwensixiu:(LQSIntroduceMainListModel *)model
{
    UIImageView *imgView;
    [self addImageView:&imgView frame:self.frame superView:self.contentView imgUrlStr:model.icon];
#warning 添加手势，点击方法
}
- (void)lqwensixiu
{
    
}

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
        [self addButton:&btn WithModel:model frame:frame superView:self.contentView tag:KBUTTON_TAG_BEGAN + i selector:@selector(buttonCilck:)];
    }
}

- (void)buttonCilck:(UIButton *)sender
{
#warning 完善点击事件
    
}
- (void)addButton:(UIButton **)button WithModel:(LQSIntroduceMainListModel *)model frame:(CGRect)frame superView:(UIView *)superVew tag:(NSInteger)tag selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [superVew addSubview:btn];
    btn.frame = frame;
    btn.tag = tag;
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIImageView *imgView;
    [self addImageView:&imgView frame:CGRectMake((KLQScreenFrameSize.width/4 - 45)/2, 10, 45, 45) superView:btn imgUrlStr:model.icon];
    UILabel *btnTitleLab;
    [self addLable:&btnTitleLab withFrame:CGRectMake(0, frame.size.height - 22, frame.size.width, 20) text:model.desc textFont:[UIFont systemFontOfSize:11] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter tag:0 superView:btn];
    *button = btn;
    
}

#pragma mark - 第一个轮播section
- (void)createLunBoCellWithData:(NSArray *)modelArr
{
    UIView *contentview = [[UIView alloc] initWithFrame:self.frame];
    contentview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentview];
    _bottomScrollowA = [[UIScrollView alloc] initWithFrame:self.frame];
    [contentview addSubview:_bottomScrollowA];
    _bottomScrollowA.backgroundColor = [UIColor grayColor];
    _bottomScrollowA.pagingEnabled = YES;
    NSInteger pageCount = modelArr.count;
    if (pageCount == 1) {
        _bottomScrollowA.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        _bottomScrollowA.contentOffset = CGPointMake(0, 0);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
        [_bottomScrollowA addSubview:imgView];
        UILabel *bgLab;
        [self addLable:&bgLab withFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20) text:nil textFont:nil textColor:nil textAlignment:NSTextAlignmentLeft tag:0 superView:self.contentView];
        bgLab.backgroundColor = [UIColor blackColor];
        bgLab.alpha = 0.6;
        UILabel *titleLab;
        LQSIntroduceMainListModel *model = modelArr[0];
        [self addLable:&titleLab withFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20) text:LQSTR(model.desc) textFont:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft tag:0 superView:self.contentView];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(model.icon)] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            imgView.image = image;
        }];
    }else{
        _bottomScrollowA.contentSize = CGSizeMake(self.frame.size.width * (pageCount+1), self.frame.size.height);
        _bottomScrollowA.contentOffset = CGPointMake(self.frame.size.width, 0);
        for (NSInteger i = 0; i < pageCount + 1; i++) {
            CGRect imgFrame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
            
            NSString *imgUrlStr = @"";
            NSString *titleStr = @"";
            if (i == 0) {
                imgUrlStr = ((LQSIntroduceMainListModel *)[modelArr lastObject]).icon;
                titleStr = ((LQSIntroduceMainListModel *)[modelArr lastObject]).desc;
            }else{
                imgUrlStr = ((LQSIntroduceMainListModel *)[modelArr objectAtIndex:i-1]).icon;
                titleStr = ((LQSIntroduceMainListModel *)[modelArr objectAtIndex:i-1]).desc;
            }
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
            imgView.backgroundColor = [UIColor redColor];
            [_bottomScrollowA addSubview:imgView];
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(imgUrlStr)] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                imgView.image = image;
            }];
            //title
            UILabel *bgLab;
            [self addLable:&bgLab withFrame:CGRectMake(self.frame.size.width * i, self.frame.size.height - 20, self.frame.size.width, 20) text:nil textFont:nil textColor:nil textAlignment:NSTextAlignmentLeft tag:0 superView:self.bottomScrollowA];
            bgLab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            UILabel *titleLab;
            [self addLable:&titleLab withFrame:CGRectMake(self.frame.size.width * i + 5, self.frame.size.height - 20, self.frame.size.width - 75, 20) text:LQSTR(titleStr) textFont:[UIFont systemFontOfSize:12] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft tag:0 superView:self.bottomScrollowA];
            
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
    self.pageCtrlA.currentPage = self.bottomScrollowA.contentOffset.x/KLQScreenFrameSize.width;

    
    
}

- (void)addImageView:(UIImageView **)imageView frame:(CGRect)frame superView:(UIView *)superView imgUrlStr:(NSString *)urlStr
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    [superView addSubview:imgView];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(urlStr)] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        imgView.image = image;
    }];
    *imageView = imgView;
}

- (void)addLable:(UILabel **)lable withFrame:(CGRect)frame text:(NSString *)text textFont:(UIFont *)font textColor:(UIColor*)color textAlignment:(NSTextAlignment )alignment tag:(NSInteger)tag superView:(UIView *)supView
{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = text;
    lab.textColor = color;
    lab.font = font;
    lab.textAlignment = alignment;
    lab.tag = tag;
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

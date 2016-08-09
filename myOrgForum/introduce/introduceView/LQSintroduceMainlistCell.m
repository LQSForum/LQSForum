//
//  LQSintroduceMainlistCell.m
//  myOrgForum
//
//  Created by XJW on 16/8/6.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSintroduceMainlistCell.h"
#import "SDWebImageManager.h"

@implementation LQSintroduceMainlistCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    
    
    return self;
}

- (void)setCell
{
    if (self) {
        
        NSArray *dataArr = self.paramDict[@"data"];
        [self createLunBoCellWithData:dataArr];
        
    }
}

- (void)createLunBoCellWithData:(NSArray *)modelArr
{
    UIView *contentview = [[UIView alloc] initWithFrame:self.frame];
    contentview.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentview];
    UIScrollView *bottomScrollow = [[UIScrollView alloc] initWithFrame:self.frame];
    [contentview addSubview:bottomScrollow];
    bottomScrollow.backgroundColor = [UIColor grayColor];
    NSInteger pageCount = modelArr.count;
    if (pageCount == 1) {
        bottomScrollow.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        bottomScrollow.contentOffset = CGPointMake(0, 0);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.frame];
        [bottomScrollow addSubview:imgView];
        UILabel *bgLab;
        [self addLable:&bgLab withFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20) text:nil textFont:nil textColor:nil textAlignment:NSTextAlignmentLeft tag:nil superView:self.contentView];
        bgLab.backgroundColor = [UIColor blackColor];
        bgLab.alpha = 0.6;
        UILabel *titleLab;
        LQSIntroduceMainListModel *model = modelArr[0];
        [self addLable:&titleLab withFrame:CGRectMake(0, self.frame.size.height - 20, self.frame.size.width, 20) text:LQSTR(model.desc) textFont:[UIFont systemFontOfSize:14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft tag:nil superView:self.contentView];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(model.icon)] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            imgView.image = image;
        }];
    }else{
        bottomScrollow.contentSize = CGSizeMake(self.frame.size.width * (pageCount+2), self.frame.size.height);
        bottomScrollow.contentOffset = CGPointMake(self.frame.size.width, 0);
        for (NSInteger i = 0; i < pageCount + 2; i++) {
            CGRect imgFrame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
            
            NSString *imgUrlStr = @"";
            if (i == 0) {
                imgUrlStr = ((LQSIntroduceMainListModel *)[modelArr lastObject]).icon;
            }else if (i == pageCount + 1){
                imgUrlStr = ((LQSIntroduceMainListModel *)[modelArr firstObject]).icon;
            }else{
                imgUrlStr = ((LQSIntroduceMainListModel *)[modelArr objectAtIndex:i-1]).icon;
            }
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
            imgView.backgroundColor = [UIColor redColor];
            [bottomScrollow addSubview:imgView];
            [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:LQSTR(imgUrlStr)] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                
            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                imgView.image = image;
            }];
        }
        
        
        
        
    }
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

@end

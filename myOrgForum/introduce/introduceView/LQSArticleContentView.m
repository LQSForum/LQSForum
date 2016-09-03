//
//  LQSArticleContentView.m
//  mybaby
//
//  Created by 阿凡树 on 16/8/31.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSArticleContentView.h"
#import "NSTextAttachment+ArticleContent.h"

@interface LQSArticleContentView(){
    NSMutableArray       *_attachmentArray;
}
@end
@implementation LQSArticleContentView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _attachmentArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (CGSize)intrinsicContentSize {
    if (!self.attributedText.length) {
        return CGSizeZero;
    }
    CGSize size = [self sizeThatFits:CGSizeMake(self.preferredMaxLayoutWidth ?: self.width, MAXFLOAT)];
    return CGSizeMake(self.preferredMaxLayoutWidth ?: self.width, ceilf(size.height));
}
- (void)setContent:(NSArray<LQSBBSContentModel *> *)content{
    NSMutableAttributedString* resultString = [[NSMutableAttributedString alloc] init];
    for (LQSBBSContentModel *model in content) {
        if ([model.type isEqualToString:@"0"]) {
            [resultString appendAttributedString:[[NSAttributedString alloc] initWithString:model.infor attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor darkGrayColor]}]];
        }
        else if ([model.type isEqualToString:@"1"]){
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            CGFloat width = self.preferredMaxLayoutWidth?:self.width;
            attachment.bounds = CGRectMake(0, 0, width, width*470/690+20);
            attachment.image = [[UIImage alloc] init];
            __weak typeof(self) weakSelf = self;
            [attachment sd_setImageWithURL:[NSURL URLWithString:model.infor] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weakSelf setNeedsDisplay];
            }];
            [resultString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        }
        else{}
    }
    self.attributedText = resultString;
}
@end
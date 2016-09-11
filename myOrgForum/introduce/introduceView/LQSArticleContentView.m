//
//  LQSArticleContentView.m
//  mybaby
//
//  Created by 阿凡树 on 16/8/31.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSArticleContentView.h"
#import "NSTextAttachment+ArticleContent.h"

static NSString * const kPatternPhiz = @"\\[mobcent_phiz=(http[s]?://[\\w./]*)\\]";
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
- (void)layoutSubviews
{
    [super layoutSubviews];
    for (LQSTextAttachment* item in _attachmentArray) {
        UIImageView* view = item.imageView;
        view.frame = [self p_boundingRectForCharacterRange:item.range];
        NSLog(@"%@\n%@",NSStringFromCGRect(view.frame),NSStringFromRange(item.range));
    }
}
- (void)setContent:(NSArray<LQSBBSContentModel *> *)content{
    NSMutableAttributedString* resultString = [[NSMutableAttributedString alloc] init];
    for (LQSTextAttachment* item in _attachmentArray) {
        [item.imageView removeFromSuperview];
    }
    [_attachmentArray removeAllObjects];
    for (LQSBBSContentModel *model in content) {
        if ([model.type isEqualToString:@"0"]) {
            NSMutableAttributedString* textString = [[NSMutableAttributedString alloc] initWithString:model.infor attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kPatternPhiz options:0 error:NULL];
            while (YES) {
                NSTextCheckingResult *result = [regex firstMatchInString:textString.string options:0 range:NSMakeRange(0, textString.string.length)];
                if (result != nil) {
                    LQSTextAttachment *attachment = [[LQSTextAttachment alloc] init];
                    attachment.image = [[UIImage alloc] init];
                    attachment.bounds = CGRectMake(0, 0, 14,14);
                    attachment.range = NSMakeRange([result rangeAtIndex:0].location, 1);
                    attachment.imageView = [[UIImageView alloc] init];
                    attachment.imageView.contentMode = UIViewContentModeScaleAspectFill;
                    [self addSubview:attachment.imageView];
                    [attachment.imageView sd_setImageWithURL:[NSURL URLWithString:[textString.string substringWithRange:[result rangeAtIndex:1]]]];
                    [_attachmentArray addObject:attachment];
                    [textString replaceCharactersInRange:[result rangeAtIndex:0] withAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
                }
                else{
                    break;
                }
            }
            
            [resultString appendAttributedString:textString];
        }
        else if ([model.type isEqualToString:@"1"]){
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            CGFloat width = self.preferredMaxLayoutWidth?:self.width;
            attachment.bounds = CGRectMake(0, 0, width, width*470/690+20);
            attachment.image = [UIImage imageNamed:@"mc_forum_add_new_img"];
            __weak typeof(self) weakSelf = self;
            [attachment sd_setImageWithURL:[NSURL URLWithString:model.infor] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weakSelf setNeedsDisplay];
            }];
            [resultString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        }
        else{}
    }
    self.attributedText = resultString;
    [self setNeedsLayout];
}
- (CGRect)p_boundingRectForCharacterRange:(NSRange)range
{
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.preferredMaxLayoutWidth ?: self.width, MAXFLOAT)];
    [layoutManager addTextContainer:textContainer];
//    textContainer.lineFragmentPadding = 0;
    NSRange glyphRange = NSMakeRange(0, 0);
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    return [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
}
@end
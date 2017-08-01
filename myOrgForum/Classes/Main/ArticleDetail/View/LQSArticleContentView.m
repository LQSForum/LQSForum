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
static NSString *regex_emoji =@"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";//匹配表情
@interface LQSArticleContentView(){
    NSMutableArray       *_attachmentArray;
}
@property (nonatomic,strong)NSArray *faceArr;// 表情数组
@end
@implementation LQSArticleContentView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _attachmentArray = [[NSMutableArray alloc] init];
        _picUrlArr = [[NSMutableArray alloc]init];
    }
    return self;
}
-(NSArray *)faceArr{
    if (!_faceArr) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"lqsemoji" ofType:@"plist"];
        _faceArr = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _faceArr;
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
//        NSLog(@"%@\n%@",NSStringFromCGRect(view.frame),NSStringFromRange(item.range));
    }
}
- (void)setContent:(NSArray<LQSBBSContentModel *> *)content{
    NSMutableAttributedString* resultString = [[NSMutableAttributedString alloc] init];
    for (LQSTextAttachment* item in _attachmentArray) {
        [item.imageView removeFromSuperview];
    }
    [_attachmentArray removeAllObjects];
    [_picUrlArr removeAllObjects];
    for (LQSBBSContentModel *model in content) {
        if ([model.type isEqualToString:@"0"]) {
            NSMutableAttributedString* textString = [[NSMutableAttributedString alloc] initWithString:model.infor attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kPatternPhiz options:0 error:NULL];
            NSRegularExpression *emojiRegex = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:0 error:NULL];
            while (YES) {
                NSTextCheckingResult *result = [regex firstMatchInString:textString.string options:0 range:NSMakeRange(0, textString.string.length)];
                if (result != nil) {
                    LQSTextAttachment *attachment = [[LQSTextAttachment alloc] init];
                    attachment.image = [[UIImage alloc] init];
                    attachment.bounds = CGRectMake(0, -8, 14,14);
                    attachment.range = NSMakeRange([result rangeAtIndex:0].location, 1);
                    attachment.imageView = [[UIImageView alloc] init];
                    attachment.imageView.contentMode = UIViewContentModeScaleAspectFill;
                    [self addSubview:attachment.imageView];
                    [attachment.imageView sd_setImageWithURL:[NSURL URLWithString:[textString.string substringWithRange:[result rangeAtIndex:1]]]];
                    [_attachmentArray addObject:attachment];
                    [textString replaceCharactersInRange:[result rangeAtIndex:0] withAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
                }else{
                    break;
                }
                // 判断是否有emoji
                NSArray *emojiResultArr = [emojiRegex matchesInString:textString.string options:0 range:NSMakeRange(0, textString.string.length)];
                //
                NSMutableArray *emojiArr = [NSMutableArray arrayWithCapacity:emojiResultArr.count];
                if (emojiResultArr != nil) {
                    for (NSTextCheckingResult *match in emojiResultArr) {
                        // 获取数组元素中的range
                        NSRange range = [match range];
                        // 获取原字符串中对应的值
                        NSString *subStr = [textString.string substringWithRange:range];
                        for (NSInteger i = 0; i < self.faceArr.count; i ++) {
                            if ([_faceArr[i][@"chs"] isEqualToString:subStr]) {
                                NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
                                textAttachment.image = [UIImage imageNamed:_faceArr[i][@"png"]];
                                //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                                textAttachment.bounds=CGRectMake(0, -8, textAttachment.image.size.width, textAttachment.image.size.height);
                                
                                NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
                                // 把图片和图片对应位置存入字典中
                                NSMutableDictionary *imgDict = [NSMutableDictionary dictionaryWithCapacity:2];
                                [imgDict setObject:imgStr forKey:@"image"];
                                [imgDict setObject:[NSValue valueWithRange:range] forKey:@"range"];
                                // 存入数组
                                [emojiArr addObject:imgDict];
                            }
                        }
                    }
                    for (NSInteger i = emojiArr.count - 1; i >= 0; i --) {
                        NSRange range;
                        [emojiArr[i][@"range"] getValue:&range];
                        // 进行替换
                        [textString replaceCharactersInRange:range withAttributedString:emojiArr[i][@"image"]];
                    }
                }else{
                    break;
                }
            }
            
            [resultString appendAttributedString:textString];
        }// type为1表示是图片信息
        else if ([model.type isEqualToString:@"1"]){
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            CGFloat width = self.preferredMaxLayoutWidth?:self.width;
            attachment.bounds = CGRectMake(0, 0, width, width*470/690+20);
            attachment.image = [UIImage imageNamed:@"mc_forum_add_new_img"];
            __weak typeof(self) weakSelf = self;
            NSString *picUrlStr = model.infor;
            NSURL *picUrl = [NSURL URLWithString:picUrlStr];
            [attachment sd_setImageWithURL:picUrl completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weakSelf setNeedsDisplay];
            }];
            [resultString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
            // 每次检查到type = 1的信息，就保存图片地址。
            [_picUrlArr addObject:picUrlStr];
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

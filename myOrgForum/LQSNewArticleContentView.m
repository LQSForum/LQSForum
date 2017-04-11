//
//  LQSNewArticleContentView.m
//  myOrgForum
//
//  Created by g x on 2017/4/11.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSNewArticleContentView.h"
#import "NSTextAttachment+ArticleContent.h"
#import <WebKit/WebKit.h>
static NSString * const kPatternPhiz = @"\\[mobcent_phiz=(http[s]?://[\\w./]*)\\]";
static NSString * const regex_emoji =@"\\[[a-zA-Z0-9\\/\\u4e00-\\u9fa5]+\\]";//匹配表情
@interface LQSNewArticleContentView ()
@property (nonatomic,strong)NSArray *faceArr;// 表情数组

@end
@implementation LQSNewArticleContentView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _picUrlArr = [[NSMutableArray alloc]init];
        _ImgArr = [[NSMutableArray alloc]init];
    }
    return self;
}
-(instancetype)init{
    if (self = [super init]) {
        _picUrlArr = [[NSMutableArray alloc]init];
        _ImgArr = [[NSMutableArray alloc]init];
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
    
    CGSize size = [self sizeThatFits:CGSizeMake(self.preferredMaxLayoutWidth ?: self.width, MAXFLOAT)];
    return CGSizeMake(self.preferredMaxLayoutWidth ?: self.width, ceilf(size.height));
}
-(void)setContent:(NSArray<LQSBBSContentModel *> *)content{
    CGRect frame = CGRectMake(0, 0, self.preferredMaxLayoutWidth, 0);
    [_picUrlArr removeAllObjects];
    [_ImgArr removeAllObjects];
    for (LQSBBSContentModel *model in content) {
        if ([model.type isEqualToString:@"0"]) {
            UILabel *label = [self createLabelWithText:model.infor preferedWidth:self.preferredMaxLayoutWidth originY:frame.size.height];
            frame.size.height +=label.height;
            [self addSubview:label];
            
        }else if ([model.type isEqualToString:@"1"]){
            UIImageView *imageView = [self createImageViewWithImageUrlStr:model.infor preferredWidth:self.preferredMaxLayoutWidth];
            imageView.origin = CGPointMake(0, frame.size.height);
            frame.size.height += imageView.height;
            [self addSubview:imageView];
        }else if ([NSString stringWithFormat:@"%@",model.extParams[@"videoType"]].length > 0){
            WKWebView *webView = [self createWebViewWithUrlStr:model.infor preferredWidth:self.preferredMaxLayoutWidth];
            webView.origin = CGPointMake(0, frame.size.height);
            frame.size.height += webView.height;
            //webView.scrollView.scrollEnabled = NO;
            [self addSubview:webView];
        }
    }
    self.height = frame.size.height;
    [self layoutIfNeeded];
    self.totalH = self.height;
}
// 根据地址创建webView
- (WKWebView *)createWebViewWithUrlStr:(NSString *)urlStr preferredWidth:(CGFloat)preferredWidth{
    NSURL *Url = [NSURL URLWithString:urlStr];
    WKWebView *webView = [[WKWebView alloc]init];
    [webView loadRequest:[NSURLRequest requestWithURL:Url]];
    webView.bounds = CGRectMake(0, 0, preferredWidth, preferredWidth*0.7);// 这里瞎写一个比例系数。
    //webView.autoresizesSubviews = NO;
    return webView;
}
// 根据文字创建imageView
- (UIImageView *)createImageViewWithImageUrlStr:(NSString *)urlStr preferredWidth:(CGFloat)preferredWidth{
    NSString *picUrlStr = urlStr;
    NSURL *picUrl = [NSURL URLWithString:picUrlStr];
   // NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"mc_forum_add_new_img"];
    [[SDWebImageManager sharedManager] downloadImageWithURL:picUrl options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (error == nil) {
            imageView.image = image;
        }
    }];
    // 先拿到图片，然后求出原图的高宽比，然后按原图比例渲染。
    CGFloat width = self.preferredMaxLayoutWidth?:self.width;
    CGFloat gaoKuanBi = imageView.image.size.height / imageView.image.size.width;
    imageView.bounds = CGRectMake(0, 0, width, width*gaoKuanBi );
    // 每次检查到type = 1的信息，就保存图片地址。
    [_picUrlArr addObject:picUrlStr];
    [_ImgArr addObject:imageView];
    imageView.tag = 10085+_ImgArr.count;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
    [imageView addGestureRecognizer:tapGesture];
    return imageView;
}
// 根据文字创建label
- (UILabel *)createLabelWithText:(NSString *)text preferedWidth:(CGFloat)preferedWidth originY:(CGFloat)originY{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, originY, self.preferredMaxLayoutWidth, 0)];
    label.numberOfLines = 0;
    if (!text) {
        return label;
      //  size = CGSizeMake(preferedWidth, 20);
    }else{
        
         NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
         paraStyle.lineSpacing = 10;// 行间距
         paraStyle.paragraphSpacing = 10;//段间距
         NSMutableAttributedString* textString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor darkGrayColor],NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@2}];
         NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:kPatternPhiz options:0 error:NULL];
         NSRegularExpression *emojiRegex = [NSRegularExpression regularExpressionWithPattern:regex_emoji options:0 error:NULL];
         while (YES) {
         
             NSTextCheckingResult *result = [regex firstMatchInString:textString.string options:0 range:NSMakeRange(0, textString.string.length)];
             NSTextCheckingResult *emojiResult = [emojiRegex firstMatchInString:textString.string options:0 range:NSMakeRange(0, textString.string.length)];
             
             if (result != nil) {
                 LQSTextAttachment *attachment = [[LQSTextAttachment alloc] init];
                 attachment.image = [[UIImage alloc] init];
                 attachment.bounds = CGRectMake(0, 0, 14,14);
                 attachment.range = NSMakeRange([result rangeAtIndex:0].location, 1);
                 attachment.imageView = [[UIImageView alloc] init];
                 attachment.imageView.contentMode = UIViewContentModeScaleAspectFill;
                 [self addSubview:attachment.imageView];
                 [attachment.imageView sd_setImageWithURL:[NSURL URLWithString:[textString.string substringWithRange:[result rangeAtIndex:1]]]];
                 //  [_attachmentArray addObject:attachment];
                 [textString replaceCharactersInRange:[result rangeAtIndex:0] withAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
             }else if (emojiResult != nil) {
                 NSRange range = [emojiResult range];
                 // 获取原字符串中对应的值
                 NSString *subStr = [textString.string substringWithRange:range];
                 for (NSInteger i = 0; i < self.faceArr.count; i++) {
                     if ([self.faceArr[i][@"chs"] isEqualToString:subStr]) {
                         NSTextAttachment *textAttachment = [[NSTextAttachment alloc]init];
                         textAttachment.image = [UIImage imageNamed:self.faceArr[i][@"png"]];
                         textAttachment.bounds = CGRectMake(0, 0, 20, 20);
                         // [self addSubview:textAttachment.image];
                         //调整一下图片的位置,如果你的图片偏上或者偏下，调整一下bounds的y值即可
                         //textAttachment.bounds=CGRectMake(0, -8, textAttachment.image.size.width, textAttachment.image.size.height);
                         [textString replaceCharactersInRange:[emojiResult rangeAtIndex:0] withAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
                     }
                 }
             }
             else{
                 break;
             }
         }
         //[resultString appendAttributedString:textString];
        label.attributedText = textString;
        [label sizeToFit];
    }
    return label;
    
}
// 图片点击手势
- (void)photoTap:(UITapGestureRecognizer *)tap
{
    // 1.创建浏览器对象
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置浏览器对象的所有图片
    NSMutableArray *mjphotos = [NSMutableArray array];
    for (int i = 0; i<_ImgArr.count; i++) {
        // 创建MJPhoto模型
        MJPhoto *mjphoto = [[MJPhoto alloc] init];
        // 设置图片的url
        mjphoto.url = [NSURL URLWithString:[_picUrlArr objectAtIndex:i]];
        // 设置图片的来源view
        mjphoto.srcImageView = _ImgArr[i];
        [mjphotos addObject:mjphoto];
    }
    browser.photos = mjphotos;
    // 3.设置浏览器默认显示的图片位置
    browser.currentPhotoIndex = tap.view.tag-10086;
    // 4.显示浏览器
    [browser show];
}
@end

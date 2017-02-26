//
//  LQSPluginListView.m
//  myOrgForum
//
//  Created by Queen_B on 2016/11/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPluginListView.h"

@interface LQSPluginListView()<UIScrollViewDelegate>
/** 显示所有表情的UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 显示页码的UIPageControl */
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation LQSPluginListView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.显示所有表情的UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        // 滚动条是UIScrollView的子控件
        // 隐藏滚动条，可以屏蔽多余的子控件
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        //        scrollView.backgroundColor = [UIColor redColor];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.显示页码的UIPageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
#warning 当单页的时候，自动隐藏UIPageControl
        pageControl.hidesForSinglePage = YES;
        //        pageControl.backgroundColor = [UIColor blueColor];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageWithName:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        // 初始化数组
        self.plugins = [NSMutableArray array];
    }
    return self;
}
-(void)addPlugBtn:(UIButton *)btn WithBtnNormImg:(NSString *)normImgName andhightlightImgName:(NSString *)heightlightImgName{
    UIButton *tempBtn = btn;
    if (normImgName) {
        
        [tempBtn setImage:[UIImage imageNamed:normImgName] forState:UIControlStateNormal];
    }
    if (heightlightImgName) {
        [tempBtn setImage:[UIImage imageNamed:heightlightImgName] forState:UIControlStateHighlighted];
    }
    [self.plugins addObject:btn];
    [self.scrollView addSubview:btn];
    // 设置总页数
    NSInteger totalPages = (self.plugins.count ) / 8 + 1;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    // 重新布局子控件
    [self setNeedsLayout];
    
    // plugin滚动到最前面
    self.scrollView.contentOffset = CGPointZero;

    
}
//-(void)setPlugins:(NSArray *)plugins{
//        _plugins = plugins;
//        
//        // 设置总页数
//        NSInteger totalPages = (plugins.count + LQSEmotionMaxCountPerPage - 1) / LQSEmotionMaxCountPerPage;
//        NSInteger currentGridViewCount = self.scrollView.subviews.count;
//        self.pageControl.numberOfPages = totalPages;
//        self.pageControl.currentPage = 0;
//        
//    
//        // 隐藏后面的不需要用到的gridView
//        for (int i = totalPages; i<currentGridViewCount; i++) {
//            LQSEmotionGridView *gridView = self.scrollView.subviews[i];
//            gridView.hidden = YES;
//        }
//        
//        // 重新布局子控件
//        [self setNeedsLayout];
//        
//        // plugin滚动到最前面
//        self.scrollView.contentOffset = CGPointZero;
//        
//        //    LQSLog(@"setEmotions---%d", self.scrollView.subviews.count);
//    
//}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.UIPageControl的frame
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    
    // 2.UIScrollView的frame
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    
    // 3.设置UIScrollView内部控件的尺寸
    NSInteger count = self.plugins.count;
    NSInteger pageCount = count / 8;// 页数
    CGFloat gridW = self.scrollView.width;
    CGFloat gridH = self.scrollView.height;
    // 这里需要做一个函数,根据调用方法填入的pluginBtn的个数,自动推断出有多少页,每页的个数,先不做了,以后做.
    self.scrollView.contentSize = CGSizeMake(count * gridW, 0);
    for (int i = 0; i<pageCount; i++) {
        UIButton *pluginBtn = self.scrollView.subviews[i];
        pluginBtn.width = (gridW - 15 * 5)/(count/4);
        pluginBtn.height = gridH;
        pluginBtn.x = i * gridW;
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.width + 0.5);
}
@end

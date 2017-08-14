//
//  LQSRotationPictureView.m
//  myOrgForum
//
//  Created by wangbo on 2017/7/19.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LQSRotationPictureView.h"

@interface LQSRotationPictureView ()

@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray<LQSRecommendItemModel> *imageArray;

@end

@implementation LQSRotationPictureView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self configView];
    }
    
    return self;
}

- (instancetype)initWithImageArray:(NSMutableArray<LQSRecommendItemModel> *)imageArray {
    self = [super init];
    if (self) {
        self.imageArray = imageArray;
        
        NSInteger count = [self.imageArray count];
        if (count > 0) {
            self.bgScrollView.contentSize = CGSizeMake(self.width * count, self.height);
        }
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)configView {
    self.backgroundColor = [UIColor grayColor];
    
    self.bgScrollView.frame = self.bounds;
    [self addSubview:self.bgScrollView];
}

#pragma mark - getter
- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] init];
        _bgScrollView.backgroundColor = [UIColor clearColor];
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        _bgScrollView.showsVerticalScrollIndicator = NO;
    }
    
    return _bgScrollView;
}

@end

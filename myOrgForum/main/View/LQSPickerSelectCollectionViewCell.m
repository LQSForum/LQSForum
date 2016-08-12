//
//  LQSPickerSelectCollectionViewCell.m
//  myOrgForum
//
//  Created by 宋小宇Mac pro on 16/8/11.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPickerSelectCollectionViewCell.h"

@interface LQSPickerSelectCollectionViewCell ()

@property (nonatomic, strong) UIButton * imgBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@end


@implementation LQSPickerSelectCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupImgBtn];
        
                            
    }
    return self;
}


- (void)setupImgBtn
{
    UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imgBtn = imgBtn;
    
    NSLog(@"+++++++%f",self.height);
    imgBtn.frame = self.bounds;
    
    [imgBtn setBackgroundImage:[UIImage imageNamed:@"newFeature1"] forState:UIControlStateNormal];
    
    
    [self addSubview:imgBtn];
}

- (void)setipDeleteBtn
{
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn = deleteBtn;
    
    [self.imgBtn addSubview:deleteBtn];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
}

@end

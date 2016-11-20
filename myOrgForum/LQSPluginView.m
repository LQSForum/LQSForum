//
//  LQSPluginView.m
//  myOrgForum
//
//  Created by Queen_B on 2016/11/20.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPluginView.h"

@implementation LQSPluginView

+(instancetype)pluginView{
    return [[self alloc]init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"emoticon_keyboard_background"]];
        
        
            }
    return self;
}
-(void)addPlugBtn:(UIButton *)btn WithBtnNormImg:(NSString *)normImgName andhightlightImgName:(NSString *)heightlightImgName{
    
    
    
}

@end

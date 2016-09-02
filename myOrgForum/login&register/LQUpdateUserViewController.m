//
//  LQUpdateUserViewController.m
//  myOrgForum
//
//  Created by su on 16/8/9.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQUpdateUserViewController.h"
#define MainBlueColor  [UIColor colorWithRed:0.529 green:0.765 blue:0.898 alpha:1.000]
@implementation LQUpdateUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    CGFloat screenWidht = self.view.width;
    IsSelectSecretBtn = YES;
    IsSelectManBtn = NO;
    IsSelectWomanBtn = NO;
    //恭喜，注册成功
    UILabel *regSuccessLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidht - 200)/2,80, 200, 30)];
    regSuccessLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    regSuccessLabel.text = @"恭喜，注册成功!";
    regSuccessLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:regSuccessLabel];
    //完善资料
    UILabel *completeDataLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidht - 200)/2,130, 200, 30)];
    completeDataLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    completeDataLabel.text = @"完善资料";
    completeDataLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:completeDataLabel];
    
    //用户名
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,200, 80, 30)];
    userNameLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    userNameLabel.text = @"用户名";
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userNameLabel];
    
    UITextField * userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(100,200, screenWidht-120, 40)];
    userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    userNameTextField.placeholder = @"请输入用户名";
    userNameTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    userNameTextField.textAlignment = UITextAlignmentLeft;
    userNameTextField.keyboardType = UIKeyboardTypeDefault;
    userNameTextField.delegate = self;
    [self.view addSubview:userNameTextField];
    //头像
    UILabel *headSculptureLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,270, 80, 30)];
    headSculptureLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    headSculptureLabel.text = @"头像";
    headSculptureLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:headSculptureLabel];
    
    UIButton * takePhotoBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(90, 270, (screenWidht -130)/2, 40.0)];
    takePhotoBtn.titleLabel.font              = [UIFont systemFontOfSize:15];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [takePhotoBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [takePhotoBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:takePhotoBtn];
    
    UIButton * fromPhotoBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(100 + (screenWidht -120)/2, 270, (screenWidht -130)/2, 40.0)];
    fromPhotoBtn.titleLabel.font              = [UIFont systemFontOfSize:15];
    [fromPhotoBtn addTarget:self action:@selector(fromPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [fromPhotoBtn setTitle:@"本地上传" forState:UIControlStateNormal];
    [fromPhotoBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [fromPhotoBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:fromPhotoBtn];
    
    //性别
    UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,340, 200, 30)];
    sexLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    sexLabel.text = @"性别";
    sexLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:sexLabel];
    
    //Radio按钮保密
    secretBtn = [[UIButton alloc]initWithFrame:CGRectMake(80,340, 20, 20)];
    UIImageView *Radio1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
    Radio1ImageView.image = [UIImage imageNamed:@"selectRadio.png"];
    [secretBtn addSubview:Radio1ImageView];
    [secretBtn addTarget:self action:@selector(secretBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secretBtn];
    //保密
    UILabel *secretLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,340, 40, 20)];
    secretLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    secretLabel.text = @"保密";
    secretLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:secretLabel];

    //Radio按钮男
    manBtn = [[UIButton alloc]initWithFrame:CGRectMake(145,340, 20, 20)];
    UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
    Radio2ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
    [manBtn addSubview:Radio2ImageView];

    [manBtn addTarget:self action:@selector(manBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manBtn];
    //男
    UILabel *manLabel = [[UILabel alloc]initWithFrame:CGRectMake(165,340, 40, 20)];
    manLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    manLabel.text = @"男";
    manLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:manLabel];
    
    //Radio按钮女
    womanBtn = [[UIButton alloc]initWithFrame:CGRectMake(210,340, 20, 20)];
    UIImageView *Radio3ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
    Radio3ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
    [womanBtn addSubview:Radio3ImageView];
    [womanBtn addTarget:self action:@selector(womanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:womanBtn];
    //女
    UILabel *womanLabel = [[UILabel alloc]initWithFrame:CGRectMake(230,340, 40, 20)];
    womanLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    womanLabel.text = @"女";
    womanLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:womanLabel];
    
    
    //以后再说按钮
    UIButton * noSubmitBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(40, 410, 90, 50.0)];
    noSubmitBtn.titleLabel.font              = [UIFont systemFontOfSize:15];
    [noSubmitBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [noSubmitBtn setTitle:@"以后再说" forState:UIControlStateNormal];
    [noSubmitBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [noSubmitBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:noSubmitBtn];
    //保存资料按钮
    UIButton * submitDataBtn                    = [[UIButton alloc]initWithFrame:CGRectMake((screenWidht - 130), 410, 90, 50.0)];
    submitDataBtn.titleLabel.font              = [UIFont systemFontOfSize:15];
    [submitDataBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [submitDataBtn setTitle:@"保存资料" forState:UIControlStateNormal];
    [submitDataBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [submitDataBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:submitDataBtn];
}

//选择性别保密
-(void)secretBtnClick
{
    NSLog(@"secretBtnClick");
    if(IsSelectSecretBtn == YES)
    {
        IsSelectSecretBtn  = NO;
        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [secretBtn addSubview:Radio2ImageView];
    }
    else
    {
        IsSelectSecretBtn  = YES;
        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"selectRadio.png"];
        [secretBtn addSubview:Radio2ImageView];
    }

}
//选择性别男
-(void)manBtnClick
{
    NSLog(@"secretBtnClick");
    if(IsSelectManBtn == YES)
    {
        IsSelectManBtn  = NO;
        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [manBtn addSubview:Radio2ImageView];
    }
    else
    {
        IsSelectManBtn  = YES;
        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"selectRadio.png"];
        [manBtn addSubview:Radio2ImageView];
    }
}

//选择性别女
-(void)womanBtnClick
{
    NSLog(@"womanBtnClick");
    if(IsSelectWomanBtn == YES)
    {
        IsSelectWomanBtn  = NO;
        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [womanBtn addSubview:Radio2ImageView];
    }
    else
    {
        IsSelectWomanBtn  = YES;
        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"selectRadio.png"];
        [womanBtn addSubview:Radio2ImageView];
    }

}
//相机选取照片
-(void)takePhotoBtnClick
{
      NSLog(@"takePhotoBtnClick");
}
//本地选取照片
-(void)fromPhotoBtnClick
{
    NSLog(@"fromPhotoBtnClick");
}
@end

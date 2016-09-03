//
//  LQLoginViewController.m
//  myOrgForum
//
//  Created by su on 16/8/9.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQLoginViewController.h"
#import "LQRegisterViewController.h"
#import "LQSUserManager.h"

#define userNameTFTag					12
#define passwordTFTag					13
#define MainBlueColor  [UIColor colorWithRed:0.529 green:0.765 blue:0.898 alpha:1.000]

@interface LQLoginViewController()<UITextFieldDelegate,LQSUserAuthDelegate>

/** 用户名*/
@property (nonatomic, strong) UITextField *userNameTextField;
/** 密码 */
@property (nonatomic, strong) UITextField *passWordTextField;

@end

@implementation LQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelLogin)];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenWidht = self.view.width;
    //CGFloat screenHeight = self.view.height;
    //初始化textfield并设置位置及大小
    if (/* DISABLES CODE */ (YES)) {
        _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(40,80, screenWidht-80, 50)];
    }
    else
    {
        _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(40,200, screenWidht-80, 50)];
    }
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextField.placeholder = @"请输入用户名/手机号";
    _userNameTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    _userNameTextField.backgroundColor = [UIColor clearColor];
    _userNameTextField.textAlignment = NSTextAlignmentLeft;
    _userNameTextField.keyboardType = UIKeyboardTypeAlphabet;
    _userNameTextField.tag = userNameTFTag;
    _userNameTextField.delegate = self;
    
    [self.view addSubview:_userNameTextField];
    
    //初始化textfield并设置位置及大小
     if (YES) {
    _passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 150, screenWidht-80, 50)];
     }
    else
    {
        _passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 270, screenWidht-80, 50)];
    }
    _passWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextField.placeholder = @"请输入密码";
    _passWordTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passWordTextField.textAlignment = UITextAlignmentLeft;
    _passWordTextField.keyboardType = UIKeyboardTypeAlphabet;
    _passWordTextField.tag = passwordTFTag;
    _passWordTextField.delegate = self;
    _passWordTextField.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_passWordTextField];
    
    //登录按钮
    UIButton * _loginButton                    = [[UIButton alloc]initWithFrame:CGRectMake(40, 250, screenWidht-80, 50.0)];
    _loginButton.titleLabel.font              = [UIFont systemFontOfSize:15];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_loginButton];
    
    //注册按钮
    UIButton * _registerButton                    = [[UIButton alloc]initWithFrame:CGRectMake(40, 330, screenWidht-80, 50.0)];
    _registerButton.titleLabel.font              = [UIFont systemFontOfSize:15];
    [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [_registerButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_registerButton];
    
 
}

- (void)cancelLogin{

    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];


}
/**
 *  登录按钮的响应函数
 *
 *  @param
 *
 *  @return
 */
-(void)loginAction
{
    
    inputUserName = _userNameTextField.text;
    inputPSW      = _passWordTextField.text;
    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    if (inputUserName.length < 1 || inputPSW.length < 1)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                          message:@"用户名或者密码不能为空"
                                                         delegate:self
                                                cancelButtonTitle:@"好"
                                                otherButtonTitles:nil, nil];
        [alertView show];
        return;
    
    }
    LQSUserManager* userLogin = [[LQSUserManager alloc]init];
    [userLogin loginUserByUsername:inputUserName withPWD:inputPSW completionBlock:^(id result, NSError *error){
        if(nil == error)
        {
//            [self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
        else
        {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                              message:@"登录失败"
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
            [alertView show];
            return;

        }
        
    }];


    
}
/**
 *  注册按钮的响应函数
 *
 *  @param
 *
 *  @return
 */
-(void)registerAction
{
    NSLog(@"registerAction");
    //lhb add for test
    LQRegisterViewController * registerViewController =  [[LQRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:NO];
    //end ad  for test
   
}

#pragma mark - UITextFieldDelegate
// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    
    NSInteger tfTag = textField.tag;
    
    switch (tfTag)
    {
        case userNameTFTag:
        {
            inputUserName = _userNameTextField.text;
            [_userNameTextField becomeFirstResponder];
        }
            break;
        case passwordTFTag:
        {
            inputPSW      = _passWordTextField.text;
            [_passWordTextField resignFirstResponder];
        }
            break;
        default:
            break;
    }
    return YES;
}
/**
 *  TextField的代理方法，通过点击键盘的returnKey来触发
 *
 *  @param textField 触发的textField
 *
 *  @return 返回YES,才有效
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger tfTag = textField.tag;
    
    switch (tfTag)
    {
        case userNameTFTag:
        {
            [_userNameTextField becomeFirstResponder];
        }
            break;
        case passwordTFTag:
        {
            
            [_passWordTextField resignFirstResponder];
        }
            break;
        default:
            break;
    }
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // 通过点击空白处，收回键盘
    inputUserName = _userNameTextField.text;
    inputPSW      = _passWordTextField.text;
    NSLog(@"inputUserName = %@,inputPSW = %@",inputUserName,inputPSW);
    if ([_userNameTextField isFirstResponder])
    {
        [_userNameTextField resignFirstResponder];
    }
    if ([_passWordTextField isFirstResponder])
    {
        [_passWordTextField resignFirstResponder];
    }
}

#pragma mark - LQSUserAuthDelegate

/**
 *  @brief  登录成功
 *
 *  @param  返回的userinfo
 */
- (void)didAuthSuccess:(LQSUserInfo *)userinfo
{
    NSLog(@"didAuthSuccess");
}
/**
 *  @brief  登录
 *
 *  @param error 返回的错误
 */
- (void)didAuthFailed:(NSError *)error
{
    NSLog(@"didAuthFailed");
}

/**
 *  @brief  退出登录成功
 *
 *  @param  返回退出登录成功的userinfo
 */
- (void)didLogoutSuccess:(LQSUserInfo *)userinfo
{
     NSLog(@"didLogoutSuccess");
}
/**
 *  @brief  退出登录失败
 *
 *  @param error 退出登录失败
 */
- (void)didLogoutFailed:(NSError *)error
{
      NSLog(@"didLogoutFailed");
}

@end

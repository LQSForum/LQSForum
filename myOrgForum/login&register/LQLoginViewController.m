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
#import "LQFoundPSWViewController.h"

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
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenWidht = self.view.width;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backHistory)];
    //CGFloat screenHeight = self.view.height;
    //初始化textfield并设置位置及大小
    if (YES) {
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
    _userNameTextField.textAlignment = UITextAlignmentLeft;
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
    UIButton * forgetPSWButton                    = [[UIButton alloc]initWithFrame:CGRectMake(screenWidht/2+20, 250, screenWidht/2-40, 50.0)];
    forgetPSWButton.titleLabel.font              = [UIFont systemFontOfSize:15];
    [forgetPSWButton addTarget:self action:@selector(forgetPSWAction) forControlEvents:UIControlEventTouchUpInside];
    [forgetPSWButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [forgetPSWButton setTitleColor:MainBlueColor forState:UIControlStateNormal];
    
    [self.view addSubview:forgetPSWButton];
    
    //登录按钮
    UIButton * _loginButton                    = [[UIButton alloc]initWithFrame:CGRectMake(40, 300, screenWidht-80, 50.0)];
    _loginButton.titleLabel.font              = [UIFont systemFontOfSize:15];
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [_loginButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_loginButton];
    
    //注册按钮
    UIButton * _registerButton                    = [[UIButton alloc]initWithFrame:CGRectMake(40, 390, screenWidht-80, 50.0)];
    _registerButton.titleLabel.font              = [UIFont systemFontOfSize:15];
    [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [_registerButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_registerButton];
    
    
}

//返回按钮
-(void)backHistory
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    //    LQSUserManager* userLogin = [[LQSUserManager alloc]init];
    //    [userLogin loginUserByUsername:inputUserName withPWD:inputPSW completionBlock:^(id result, NSError *error){
    //        if(nil == error)
    //        {
    //            [self.navigationController popViewControllerAnimated:YES];
    //        }
    //        else
    //        {
    //            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
    //                                                              message:@"登录失败"
    //                                                             delegate:self
    //                                                    cancelButtonTitle:@"好"
    //                                                    otherButtonTitles:nil, nil];
    //            [alertView show];
    //            return;
    //
    //        }
    //
    //    }];
    
    //add for test
    //获取输入的账号密码
    
    //请求的参数
    NSDictionary *parameters = @{
                                 @"type":@"login",
                                 @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                 @"username":inputUserName,
                                 @"password":inputPSW,
                                 @"accessSecret":@"cd090971f3f83391cd4ddc034638c",
                                 @"accessToken":@"f9514b902a334d6c0b23305abd46d",
                                 @"apphash":@"85eb3e4b"
                                 };
    
    
    //请求的url
    NSString *urlString = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=user/login";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    managers.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //申明请求的数据是json类型
    
    managers.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //如果报接受类型不一致请替换一致text/html或别的
    
    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    UIAlertView *waitAlertView=[[UIAlertView alloc] initWithTitle:nil
                                                          message:@"登录中请稍后"
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:nil, nil];
    waitAlertView.tag = 110;
    
    [waitAlertView show];
    //请求的方式：POST
    [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [waitAlertView dismissWithClickedButtonIndex:0 animated:NO];
        NSDictionary *dic = responseObject;
        NSLog(@"请求成功，服务器返回的信息%@",dic);
        NSString * errCodeString = [[dic objectForKey:@"head"]objectForKey:@"errCode"];
        NSString * errInfoString = [[dic objectForKey:@"head"]objectForKey:@"errInfo"];
        NSLog(@"errorInfo = %@",errCodeString);
        
        if (errCodeString !=nil &&  [errCodeString isEqualToString:@"00000000"]) {
            NSLog(@"aaadddd");
            [LQSUserManager user] ;
            //将当前的用户名和密码保存起来
            [LQSUserManager userWithDict:dic];//存储用户信息
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:inputUserName forKey:@"userName"];
            [user setObject:inputPSW forKey:@"userPassWord"];
            //[user setObject:@"TRUE" forKey:@"userLoginState"];
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                              message:@"登录成功"
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
            alertView.tag = 100;
            [alertView show];
        }
        else
        {
            NSLog(@"ddddd");
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"FALSE" forKey:@"userLoginState"];
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"登录失败"
                                                              message:errInfoString
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
            alertView.tag = 101;
            [alertView show];
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        [waitAlertView dismissWithClickedButtonIndex:0 animated:NO];
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:@"FALSE" forKey:@"userLoginState"];
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                          message:@"登录失败"
                                                         delegate:self
                                                cancelButtonTitle:@"好"
                                                otherButtonTitles:nil, nil];
        alertView.tag = 102;
        [alertView show];
        return;
    }];
    //end add for test
    
}

/**
 *  注册按钮的响应函数
 *
 *  @param
 *
 *  @return
 */
-(void)forgetPSWAction
{
    NSLog(@"forgetPSWAction");
    
    LQFoundPSWViewController * foundPSWViewController =  [[LQFoundPSWViewController alloc] init];
    [self.navigationController pushViewController:foundPSWViewController animated:NO];
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
-(void)userLogOut
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * userName = [user objectForKey:@"userName"];
    NSString * userPSW  = [user objectForKey:@"userPassWord"];
    
    //请求的参数
    NSDictionary *parameters = @{
                                 @"type":@"logout",
                                 @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                 @"accessSecret":@"cd090971f3f83391cd4ddc034638c",
                                 @"accessToken":@"f9514b902a334d6c0b23305abd46d",
                                 @"apphash":@"85eb3e4b",
                                 @"sdkVersion":@"2.4.0",
                                 @"username":userName,
                                 @"password":userPSW
                                 };
    
    
    //请求的url
    NSString *urlString = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=user/login";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    managers.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //申明请求的数据是json类型
    
    managers.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //如果报接受类型不一致请替换一致text/html或别的
    
    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    UIAlertView *waitAlertView=[[UIAlertView alloc] initWithTitle:nil
                                                          message:@"登出中请稍后"
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:nil, nil];
    waitAlertView.tag = 110;
    
    [waitAlertView show];
    //请求的方式：POST
    [managers POST:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [waitAlertView dismissWithClickedButtonIndex:0 animated:NO];
        NSDictionary *dic = responseObject;
        NSLog(@"请求成功，服务器返回的信息%@",dic);
        NSString * errCodeString = [[dic objectForKey:@"head"]objectForKey:@"errCode"];
        NSString * errInfoString = [[dic objectForKey:@"head"]objectForKey:@"errInfo"];
        NSLog(@"errorInfo = %@",errCodeString);
        
        if (errCodeString !=nil &&  [errCodeString isEqualToString:@"00000000"]) {
            NSLog(@"rrrrrr");
            //删除当前的用户名和密码
            [user removeObjectForKey:@"userName"];
            [user removeObjectForKey:@"userPassWord"];
            [user setObject:@"FALSE" forKey:@"userLoginState"];
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                              message:@"登出成功"
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
            alertView.tag = 200;
            [alertView show];
        }
        else
        {
            NSLog(@"gggggg");
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"登出失败"
                                                              message:errInfoString
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
            alertView.tag = 101;
            [alertView show];
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        [waitAlertView dismissWithClickedButtonIndex:0 animated:NO];
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                          message:@"登出失败"
                                                         delegate:self
                                                cancelButtonTitle:@"好"
                                                otherButtonTitles:nil, nil];
        alertView.tag = 102;
        [alertView show];
        return;
    }];
    //end add for test
    
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(100==alertView.tag)
    {
        //如果弹出提示成功弹出发帖页面应该不在这里处理（zss）
        //        LQSComposeViewController *vc = [[LQSComposeViewController alloc] init];
        //        LQSNavigationController *navVc = [[LQSNavigationController alloc] initWithRootViewController:vc];
        //        [self presentViewController:navVc animated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
        
    }
    
}

@end

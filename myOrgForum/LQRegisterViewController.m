//
//  LQRegisterViewController.m
//  myOrgForum
//
//  Created by su on 16/8/9.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//


#define userNameTFTag					12
#define passwordTFTag					13
#define mailboxTFTag					13
#define MainBlueColor  [UIColor colorWithRed:0.529 green:0.765 blue:0.898 alpha:1.000]


#import "LQRegisterViewController.h"
#import "LQSUserManager.h"
#import "LQUpdateUserViewController.h"

@interface LQRegisterViewController()<UITextFieldDelegate,LQSUserAuthDelegate,UIAlertViewDelegate>
/** 用户名*/
@property (nonatomic, strong) UITextField *userNameTextField;
/** 密码 */
@property (nonatomic, strong) UITextField *passWordTextField;
/** 邮箱 */
@property (nonatomic, strong) UITextField *mailboxTextField;
@end

@implementation LQRegisterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    inputUserName = nil;
    inputPSW = nil;
    inputMailbox = nil;
    self.title = @"登录";
    CGFloat screenWidht = self.view.width;
    //CGFloat screenHeight = self.view.height;
    //请输入用户名
    self.view.backgroundColor = [UIColor whiteColor];
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(40,80, screenWidht-80, 50)];
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextField.placeholder = @"请输入用户名(不要使用手机号)";
    _userNameTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    _userNameTextField.textAlignment = UITextAlignmentLeft;
    _userNameTextField.backgroundColor = [UIColor clearColor];
    _userNameTextField.keyboardType = UIKeyboardTypeTwitter;
    _userNameTextField.delegate = self;
    
    [self.view addSubview:_userNameTextField];
    
    //请输入密码
    _passWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 150, screenWidht-80, 50)];
    _passWordTextField.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTextField.placeholder = @"请输入密码";
    _passWordTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _passWordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passWordTextField.textAlignment = UITextAlignmentLeft;
    _passWordTextField.keyboardType = UIKeyboardTypeTwitter;
    _passWordTextField.backgroundColor = [UIColor clearColor];
    _passWordTextField.delegate = self;
    [self.view addSubview:_passWordTextField];
    
    //请输入邮箱
    _mailboxTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 220, screenWidht-80, 50)];
    _mailboxTextField.borderStyle = UITextBorderStyleRoundedRect;
    _mailboxTextField.placeholder = @"请输入邮箱";
    _mailboxTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _mailboxTextField.clearButtonMode = UITextFieldViewModeAlways;
    _mailboxTextField.textAlignment = UITextAlignmentLeft;
    _mailboxTextField.keyboardType = UIKeyboardTypeEmailAddress;
    _mailboxTextField.backgroundColor = [UIColor clearColor];
    _mailboxTextField.delegate = self;
    [self.view addSubview:_mailboxTextField];
    

    //注册按钮
    UIButton * _registerButton                    = [[UIButton alloc]initWithFrame:CGRectMake(40, 330, screenWidht-80, 50.0)];
    _registerButton.titleLabel.font              = [UIFont systemFontOfSize:15];
    [_registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [_registerButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:_registerButton];
    
    
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
    
    //add for test
    LQUpdateUserViewController * updateViewController =  [[LQUpdateUserViewController alloc] init];
    [self.navigationController pushViewController:updateViewController animated:NO];
    return;
    //end add for test
    inputUserName = _userNameTextField.text;
    inputPSW      = _passWordTextField.text;
    inputMailbox  = _mailboxTextField.text;
    
    [_userNameTextField becomeFirstResponder];
    [_passWordTextField resignFirstResponder];
    if (inputUserName.length < 1 || inputPSW.length < 1)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                          message:@"用户名或者密码或者邮箱不能为空"
                                                         delegate:self
                                                cancelButtonTitle:@"好"
                                                otherButtonTitles:nil, nil];
        [alertView show];
        return;
        
    }

   
//    LQSUserManager* userLogin = [[LQSUserManager alloc]init];
//    [userLogin registerUserByEmail:inputMailbox withPWD:inputPSW withUserName:inputUserName completionBlock:^(id result, NSError *error){
//        if (nil == error) {
//            LQUpdateUserViewController * updateViewController =  [[LQUpdateUserViewController alloc] init];
//            [self.navigationController pushViewController:updateViewController animated:NO];
//        }
//        else
//        {
//            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
//                                                              message:@"注册失败"
//                                                             delegate:self
//                                                    cancelButtonTitle:@"好"
//                                                    otherButtonTitles:nil, nil];
//            [alertView show];
//            return;
//        }
//    }];




  
    //请求的参数
    NSDictionary *parameters = @{
                                 @"forumKey":@"BW0L5ISVRsOTVLCTJx",
                                 @"isValidation":@"1",
                                 @"username":inputUserName,
                                 @"password":inputPSW,
                                 @"email":inputMailbox,
                                 @"accessSecret":@"",
                                 @"accessToken":@"",
                                 @"apphash":@"85eb3e4b",
                                 @"sdkVersion":@"2.4.0"
                                 };
    
    
    //请求的url
    NSString *urlString = @"http://forum.longquanzs.org/mobcent/app/web/index.php?r=user/register";
    //请求的managers
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    managers.responseSerializer = [AFJSONResponseSerializer serializer];
   
    //申明请求的数据是json类型
    
    managers.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //如果报接受类型不一致请替换一致text/html或别的
    
    managers.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    UIAlertView *waitAlertView=[[UIAlertView alloc] initWithTitle:nil
                                                      message:@"注册中请稍后"
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:nil, nil];
    
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
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                              message:@"注册成功"
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
            alertView.tag = 100;
            [alertView show];
        }
        else
        {
            NSLog(@"ddddd");
            [waitAlertView dismissWithClickedButtonIndex:0 animated:NO];
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"注册失败"
                                                              message:errInfoString
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
            alertView.tag = 101;
            [alertView show];
        }
        
        

    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        NSLog(@"请求失败,服务器返回的错误信息%@",error);
        [waitAlertView dismissWithClickedButtonIndex:0 animated:NO];
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                          message:@"注册失败"
                                                         delegate:self
                                                cancelButtonTitle:@"好"
                                                otherButtonTitles:nil, nil];
        alertView.tag = 101;
        [alertView show];
       
    }];
    //end add for test

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(100==alertView.tag)
    {
        //如果弹出提示成功
        LQUpdateUserViewController * updateViewController =  [[LQUpdateUserViewController alloc] init];
        [self.navigationController pushViewController:updateViewController animated:NO];
        return;

    }
}
@end

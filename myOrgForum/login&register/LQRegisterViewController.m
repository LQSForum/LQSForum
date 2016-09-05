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

@interface LQRegisterViewController()<UITextFieldDelegate,LQSUserAuthDelegate>
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
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenWidht = self.view.width;
    //CGFloat screenHeight = self.view.height;
    //请输入用户名
    _userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(40,80, screenWidht-80, 50)];
    _userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _userNameTextField.placeholder = @"请输入用户名(不要使用手机号)";
    _userNameTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    _userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    _userNameTextField.textAlignment = NSTextAlignmentLeft;
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
    _passWordTextField.textAlignment = NSTextAlignmentLeft;
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
    _mailboxTextField.textAlignment = NSTextAlignmentLeft;
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
//    LQUpdateUserViewController * updateViewController =  [[LQUpdateUserViewController alloc] init];
//    [self.navigationController pushViewController:updateViewController animated:NO];
//    return;
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

   
    LQSUserManager* userLogin = [[LQSUserManager alloc]init];
    [userLogin registerUserByEmail:inputMailbox withPWD:inputPSW withUserName:inputUserName completionBlock:^(id result, NSError *error){
        if (nil == error) {
            LQUpdateUserViewController * updateViewController =  [[LQUpdateUserViewController alloc] init];
            [self.navigationController pushViewController:updateViewController animated:NO];
        }
        else
        {
            UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:nil
                                                              message:@"注册失败"
                                                             delegate:self
                                                    cancelButtonTitle:@"好"
                                                    otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
    }];
}
@end

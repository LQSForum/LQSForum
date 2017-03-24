//
//  LSKChangePasswordVC.m
//  myOrgForum
//
//  Created by lsm on 17/3/24.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LSKChangePasswordVC.h"

@interface LSKChangePasswordVC ()<UITextFieldDelegate>
{
    int width;
    int height;
    UITableView * listView;
    //
    UITextField * oldPasswordTextField;
    UITextField * newPasswordTextField;
    UITextField * ensurePasswordTextField;
    MBProgressHUD *_HUD;
}

@end

@implementation LSKChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - customMethods
- (void)initMethod
{
    //自定义tablebar
    UILabel * label = [[UILabel alloc]init];
    [label setText:@"修改密码"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setFrame:CGRectMake(0, 0, 100, 40)];
    [label setFont:[UIFont systemFontOfSize:18 weight:20]];
    self.navigationItem.titleView = label;
    
    //tablebar背景色
    [self.navigationController.navigationBar setBarTintColor:LQSColor(21, 194, 251, 1)];
    [self.tabBarController.tabBar setHidden:YES];
    
    [self addContentView];
}
- (void)addContentView
{
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    int headerHeight = 0;
    UILabel * addLabel1 = [[UILabel alloc]init];
    [addLabel1 setFrame:CGRectMake(10, headerHeight, 140, 40)];
    [addLabel1 setText:@"账号："];
    //    [addLabel1 setTextColor:[UIColor hexStringToColor:@"666666"]];
    UITextField * addTextField1 = [[UITextField alloc]init];
    [addTextField1 setFrame:CGRectMake(150, headerHeight, width-150, 40)];
//    [addTextField1 setText:[SingletonFun sharedInstanceMethod].loginResponse.memberEntity.memName];
    [addTextField1 setEnabled:NO];
    [self.view addSubview:addLabel1];
    [self.view addSubview:addTextField1];
    
    UILabel * addLabel2 = [[UILabel alloc]init];
    [addLabel2 setFrame:CGRectMake(10, headerHeight+50, 140, 40)];
    [addLabel2 setText:@"请输入原密码："];
    oldPasswordTextField = [[UITextField alloc]init];
    [oldPasswordTextField setFrame:CGRectMake(150, headerHeight+50, width-150, 40)];
    [oldPasswordTextField setPlaceholder:@"请输入原密码"];
    [oldPasswordTextField setEnabled:YES];
    oldPasswordTextField.secureTextEntry = YES;
    oldPasswordTextField.delegate = self;
    [self.view addSubview:addLabel2];
    [self.view addSubview:oldPasswordTextField];
    
    UILabel * addLabel3 = [[UILabel alloc]init];
    [addLabel3 setFrame:CGRectMake(10, headerHeight+50*2, 140, 40)];
    [addLabel3 setText:@"请输入新密码："];
    newPasswordTextField = [[UITextField alloc]init];
    [newPasswordTextField setFrame:CGRectMake(150, headerHeight+50*2, width-150, 40)];
    [newPasswordTextField setPlaceholder:@"请输入新密码"];
    [newPasswordTextField setEnabled:YES];
    newPasswordTextField.secureTextEntry = YES;
    newPasswordTextField.delegate = self;
    [self.view addSubview:addLabel3];
    [self.view addSubview:newPasswordTextField];
    
    UILabel * addLabel4 = [[UILabel alloc]init];
    [addLabel4 setFrame:CGRectMake(10, headerHeight+50*3, 140, 40)];
    [addLabel4 setText:@"请输入确认密码："];
    ensurePasswordTextField = [[UITextField alloc]init];
    [ensurePasswordTextField setFrame:CGRectMake(150, headerHeight+50*3, width-150, 40)];
    [ensurePasswordTextField setPlaceholder:@"请输入确认密码"];
    [ensurePasswordTextField setEnabled:YES];
    ensurePasswordTextField.secureTextEntry = YES;
    ensurePasswordTextField.delegate = self;
    [self.view addSubview:addLabel4];
    [self.view addSubview:ensurePasswordTextField];
    
    UIButton * addButton = [[UIButton alloc]init];
    [addButton setFrame:CGRectMake(10, headerHeight+50*4, width-20, 40)];
    [addButton setTitle:@"保存" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addButton setBackgroundColor:LQSColor(21, 194, 251, 1)];
    [addButton.layer setCornerRadius:5];
    [addButton addTarget:self action:@selector(changePasswordMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addButton];
}
- (void)backBtnMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) viewDidLayoutSubviews {
    CGRect viewBounds = self.view.bounds;
    CGFloat topBarOffset = self.topLayoutGuide.length;
    viewBounds.origin.y = topBarOffset*-1;
    self.view.bounds = viewBounds;
}
- (void)changePasswordMethod
{
    NSLog(@"修改密码");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

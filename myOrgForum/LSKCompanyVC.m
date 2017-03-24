//
//  LSKCompanyVC.m
//  myOrgForum
//
//  Created by lsm on 17/3/24.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LSKCompanyVC.h"

@interface LSKCompanyVC ()<UITextViewDelegate>
{
    int width;
    int height;
    UITextView * adviceTextView;
    UILabel * _messageLabel;
    MBProgressHUD *_HUD;
}


@end

@implementation LSKCompanyVC

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
    [label setText:@"公司"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setFrame:CGRectMake(0, 0, 100, 40)];
    [label setFont:[UIFont systemFontOfSize:18 weight:20]];
    self.navigationItem.titleView = label;
    
    //右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(0, 0, 60, 30);
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(commitButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    NSArray * buttonAry = [[NSArray alloc]initWithObjects:rightItem,nil];
    [self.navigationItem setRightBarButtonItems:buttonAry];
    //tablebar背景色
    [self.navigationController.navigationBar setBarTintColor:LQSColor(21, 194, 251, 1)];
    [self addContentView];
}

- (void)backBtnMethod
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addContentView
{
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    adviceTextView = [[UITextView alloc]init];
    [adviceTextView setFrame:CGRectMake(10, 10, width-20, 200)];
    [adviceTextView.layer setBorderColor:LQSColor(22, 191, 251, 1).CGColor];
    [adviceTextView.layer setBorderWidth:1.0];
    [adviceTextView.layer setCornerRadius:4.0];
    [adviceTextView setFont:[UIFont systemFontOfSize:16]];
    adviceTextView.delegate = self;
    
    UILabel * placeLabel = [[UILabel alloc]init];
    [placeLabel setTag:1];
    [placeLabel setFrame:CGRectMake(8, 8, width-20, 20)];
    [placeLabel setNumberOfLines:0];
    [placeLabel setFont:[UIFont systemFontOfSize:16]];
    [placeLabel setAdjustsFontSizeToFitWidth:YES];
    [placeLabel setTextColor:[UIColor grayColor]];
    [placeLabel setText:@""];
    [adviceTextView addSubview:placeLabel];
    
    
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //设置style
    [topView setBarStyle:UIBarStyleBlack];
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem * button1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * button2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //定义完成按钮
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard)];
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [adviceTextView setInputAccessoryView:topView];
    //取消iOS7的边缘延伸效果（例如导航栏，状态栏等等）
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    
    [self.view addSubview:adviceTextView];
    
    
    _messageLabel = [[UILabel alloc] init];
    [_messageLabel setFrame:CGRectMake(adviceTextView.frame.size.width-300, adviceTextView.frame.size.height-10, 300, 20)];
    _messageLabel.text = @"";
    _messageLabel.textColor = [UIColor lightGrayColor];
    _messageLabel.textAlignment = NSTextAlignmentRight;
    _messageLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_messageLabel];
    //    [self.view addSubview:commitButton];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)resignKeyboard
{
    
    [adviceTextView resignFirstResponder];
}
- (void)commitButtonMethod
{
    NSLog(@"提交");
}

#pragma mark - 点击屏幕收键盘

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [adviceTextView resignFirstResponder];
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

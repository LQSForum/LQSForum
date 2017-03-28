//
//  LQSHuiFuPingLunViewController.m
//  myOrgForum
//
//  Created by bhsj_imac on 2017/3/22.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//  左上角按钮为取消，右上角为发布。中间标题为回复。一个textview,placeholder为：说两句吧。。。，下面一栏为添加图片的按钮。再下面是显示所在位置。

#import "LQSHuiFuPingLunViewController.h"
#import "LQSTextView.h"
@interface LQSHuiFuPingLunViewController ()
@property (nonatomic,strong)UIButton *cancleBtn;
@property (nonatomic,strong)UIButton *sendBtn;
@property (nonatomic,strong)LQSTextView *saySomethingTV;
@property (nonatomic,strong)UIButton *addPicBtn;
@property (nonatomic,strong)UIButton *locateBtn;
@property (nonatomic,strong)UIScrollView *containerScrollView;
@end

@implementation LQSHuiFuPingLunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 布局左边的取消按钮
    self.cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancleBtn addTarget:self action:@selector(cancleReply:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:self.cancleBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    // 布局右边发布按钮
    self.sendBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [self.sendBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendReply:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.sendBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - custom methods
- (void)setupViews{
    self.view.backgroundColor = [UIColor whiteColor];
        // 布局scrollView
    self.containerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    self.containerScrollView.contentSize = CGSizeMake(0, kScreenHeight *1.2);
    self.containerScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.containerScrollView];
    // 布局textview
    self.saySomethingTV = [[LQSTextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    self.saySomethingTV.backgroundColor = [UIColor whiteColor];
    self.saySomethingTV.placehoder = @"说两句吧...";
    [self.containerScrollView addSubview:self.saySomethingTV];
    // 布局添加照片按钮
    UIView *addPicContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.saySomethingTV.frame)+5,kScreenWidth, 80)];
    addPicContainerView.backgroundColor = [UIColor whiteColor];
    [self.containerScrollView addSubview:addPicContainerView];
    self.addPicBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
    [self.addPicBtn setImage:[UIImage imageNamed:@"dz_publish_add_picture_n"] forState:UIControlStateNormal];
    [self.addPicBtn setImage:[UIImage imageNamed:@"dz_publish_add_picture_h"] forState:UIControlStateSelected];
    [addPicContainerView addSubview:self.addPicBtn];
    // 旁边的添加照片label
    UILabel *addPicLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.addPicBtn.frame)+5, 0, kScreenWidth - 100, 80)];
    addPicLabel.text = @"添加照片";
    [addPicContainerView addSubview:addPicLabel];
    
    // 定位按钮
    self.locateBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(addPicContainerView.frame)+10, 120, 50)];
    [self.containerScrollView addSubview:self.locateBtn];
    [self.locateBtn setImage:[UIImage imageNamed:@"dz_toolbar_reply_location_n"] forState:UIControlStateNormal];
    [self.locateBtn addTarget:self action:@selector(locateAct:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.navigationItem.rightBarButtonItem = 
}
- (void)locateAct:(UIButton *)sender{
    NSLog(@"定位按钮点击事件");
}
- (void)sendReply:(UIButton *)sender{
    NSLog(@"发布按钮的点击事件，在这里确定发送回复消息");
}
- (void)cancleReply:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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

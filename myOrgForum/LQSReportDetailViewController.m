//
//  LQSReportDetailViewController.m
//  myOrgForum
//  功能:举报详情页,由帖子详情页push过来.
//  Created by Queen_B on 2016/11/13.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSReportDetailViewController.h"
#import "LQSAddViewHelper.h"
#import "YBPopupMenu.h"
#import "LQSTextView.h"
// 标题
#define kNAVITitle @"举报主题"
#define TITLES @[@"成人内容", @"政治内容", @"粗俗内容",@"其他原因"]
@interface LQSReportDetailViewController ()<YBPopupMenuDelegate>
@property (nonatomic,weak)UILabel *selectedLabel;
@end

@implementation LQSReportDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = kNAVITitle;
    self.view.backgroundColor = [UIColor whiteColor];
    // 隐藏右边的更多按钮.
    self.navigationItem.rightBarButtonItem = nil;
    [self setupJuBaoYuanYinView];
    
}

- (void)setupJuBaoYuanYinView{
    // 整个横条view，包括举报原因label和按钮，和右边不知道干嘛的那块。（这块好像可以用来撤销键盘。。。）
    UIView *yuanYinView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, LQSScreenW, 60)];
    yuanYinView.backgroundColor = [UIColor redColor];
    [self.view addSubview:yuanYinView];
    // 中间分割线
    UIView *Vline;
    [LQSAddViewHelper addLine:&Vline withFrame:CGRectMake(yuanYinView.centerX, 0, 1, yuanYinView.height) superView:yuanYinView color:[UIColor blackColor]];
    UIView *Hline;
    [LQSAddViewHelper addLine:&Hline withFrame:CGRectMake(0, yuanYinView.height - 1, LQSScreenW, 1) superView:yuanYinView color:[UIColor blackColor]];
    // 选择按钮
    UIButton *pickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pickBtn setImage:[UIImage imageNamed:@"dz_board_top_more"] forState:UIControlStateNormal];
    [yuanYinView addSubview:pickBtn];
    [pickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Vline.mas_right).offset(-5);
        make.top.equalTo(yuanYinView.mas_top).offset(5);
        make.bottom.equalTo(yuanYinView.mas_bottom).offset(-5);
        make.width.equalTo(@50);
    }];
    [pickBtn addTarget:self action:@selector(pickBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *yuanYinLabel = [[UILabel alloc]init];
    [yuanYinView addSubview:yuanYinLabel];
    [yuanYinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yuanYinView.mas_left).offset(5);
        make.right.equalTo(pickBtn.mas_right).offset(-5);
        make.top.equalTo(yuanYinView.mas_top).offset(5);
        make.bottom.equalTo(yuanYinView.mas_bottom).offset(-5);
    }];
    yuanYinLabel.text = @"请选择举报原因";
    self.selectedLabel = yuanYinLabel;
    // 意见textview
    LQSTextView *yiJianTextView = [[LQSTextView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(yuanYinView.frame), LQSScreenW - 10, 120)];
    yiJianTextView.placehoder = @"举报这个主题，您还想提点什么意见？";
    [self.view addSubview:yiJianTextView];
    // 举报按钮
    UIButton *reportBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(yiJianTextView.frame)+20, LQSScreenW - 20, 40)];
    reportBtn.layer.cornerRadius = 5;
    [self.view addSubview:reportBtn];
    [reportBtn setTitle:@"举报" forState:UIControlStateNormal];
    reportBtn.backgroundColor = [UIColor blueColor];
    [reportBtn addTarget:self action:@selector(reportBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)reportBtnClick:(UIButton *)sender{
    NSLog(@"举报按钮的点击事件");
}
- (void)pickBtnClick:(UIButton *)sender{
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:nil menuWidth:120 delegate:self];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    NSString *selectedStr =TITLES[index];
    self.selectedLabel.text = selectedStr;
    NSLog(@"点击了 %@ 选项",TITLES[index]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

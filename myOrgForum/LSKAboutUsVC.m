//
//  LSKAboutUsVC.m
//  myOrgForum
//
//  Created by lsm on 17/3/24.
//  Copyright © 2017年 SkyAndSea. All rights reserved.
//

#import "LSKAboutUsVC.h"
#import "LSKAboutUsModel.h"
#import "LSKWebVC.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
@interface LSKAboutUsVC ()<UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate>{
    int width;
    int height;
    UITableView * listView;
    NSMutableArray * array;
}

@end

@implementation LSKAboutUsVC

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
    [label setText:@"关于我们"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setFrame:CGRectMake(0, 0, 100, 40)];
    [label setFont:[UIFont systemFontOfSize:18 weight:20]];
    self.navigationItem.titleView = label;
    
    //tablebar背景色
    [self.navigationController.navigationBar setBarTintColor:LQSColor(21, 194, 251, 1)];
    [self.tabBarController.tabBar setHidden:YES];
    
    [self addContentView];
    
    //
    array = [[NSMutableArray alloc] init];
    LSKAboutUsModel * model1 = [[LSKAboutUsModel alloc] init];
    model1.title = @"应用介绍";
    model1.url = @"北京龙泉寺官方论坛";
    
    LSKAboutUsModel * model2 = [[LSKAboutUsModel alloc] init];
    model2.title = @"反馈邮箱";
    model2.url = @"longquanluntan@163.com";
    
    LSKAboutUsModel * model3 = [[LSKAboutUsModel alloc] init];
    model3.title = @"官方网站";
    model3.url = @"http://forum.longquanzs.org/";
    
    LSKAboutUsModel * model4 = [[LSKAboutUsModel alloc] init];
    model4.title = @"腾讯微博";
    model4.url = @"http://t.qq.com/xuechengfashi";
    
    LSKAboutUsModel * model5 = [[LSKAboutUsModel alloc] init];
    model5.title = @"新浪微博";
    model5.url = @"http://weibo.com/xuecheng";
    
    [array addObject:model1];
    [array addObject:model2];
    [array addObject:model3];
    [array addObject:model4];
    [array addObject:model5];
    
}
- (void)addContentView
{
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    listView = [[UITableView alloc]init];
    [listView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    listView.dataSource = self;
    listView.delegate = self;
    [self.view addSubview:listView];
    [listView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


#pragma listView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = [NSString stringWithFormat:@"cell%ld",(long)indexPath.section];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellStyleValue1;
    }
    LSKAboutUsModel * model = array[indexPath.row];
    [cell.textLabel setText:model.title];
    [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    [cell.textLabel setTextColor:[UIColor blackColor]];
    [cell.detailTextLabel setText:model.url];
    [cell.detailTextLabel setTextColor:LQSColor(21, 194, 251, 1)];
   
 
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
#pragma - mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSKAboutUsModel * model = array[indexPath.row];
//    if (![model.title isEqualToString:@"龙泉寺官方论坛"]) {
//        LSKWebVC * webVC = [[LSKWebVC alloc] init];
//        webVC.urlString = model.url;
//        webVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:webVC animated:YES];
//    }
    if ([model.title isEqualToString:@"反馈邮箱"]) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://admin@hzlzh.com"]];
        
//        LSKWebVC * webVC = [[LSKWebVC alloc] init];
//        webVC.urlString = @"mailto://admin@hzlzh.com";
//        webVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:webVC animated:YES];
        
        if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
            [self openEmailMethod]; // 调用发送邮件的代码
        }
    }
}

- (void)openEmailMethod
{
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"我是邮件主题"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"1147626297@qq.com"]];
    // 设置抄送人
    [mailCompose setCcRecipients:@[@"1229436624@qq.com"]];
    // 设置密抄送
    [mailCompose setBccRecipients:@[@"shana_happy@126.com"]];
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = @"我是邮件内容";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    //	[mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];
//    /**
//     *  添加附件
//     */
//    UIImage *image = [UIImage imageNamed:@"image"];
//    NSData *imageData = UIImagePNGRepresentation(image);
//    [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"custom.png"];
//    NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
//    NSData *pdf = [NSData dataWithContentsOfFile:file];
//    [mailCompose addAttachmentData:pdf mimeType:@"" fileName:@"7天精通IOS233333"];
    // 弹出邮件发送视图
    [self presentViewController:mailCompose animated:YES completion:nil];
}
//打开邮箱的代理方法
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result

                        error:(NSError*)error

{
    
    switch (result){
            
        case MFMailComposeResultCancelled:  NSLog(@"Mail send canceled…");
            
            break;
            
        case MFMailComposeResultSaved:    NSLog(@"Mail saved…");
            
            break;
            
        case MFMailComposeResultSent:             NSLog(@"Mail sent…");
            
            break;
            
        case MFMailComposeResultFailed:  NSLog(@"Mail send errored: %@…", [error localizedDescription]);
            
            break;
            
        default:             break;
            
    }
    
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
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

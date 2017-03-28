
//
//  LQSDetailSettingViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/4/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSDetailSettingViewController.h"
#import "LQSChangePasswordVC.h"
#import "LQSAboutUsVC.h"
#import <UShareUI/UShareUI.h>
@interface LQSDetailSettingViewController ()<UITableViewDelegate , UITableViewDataSource>
{
    LQSUITableView *_tableView;

}

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LQSDetailSettingViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        LQSSettingPersonalSettingDataModel *model1 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model1.imageName = @"";
        model1.title = @"修改密码";
        LQSSettingPersonalSettingDataModel *model2 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model2.imageName = @"";
        model2.title = @"回复提示通知";

        LQSSettingPersonalSettingDataModel *model3 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model3.imageName = @"";
        model3.title = @"@提示通知";

        LQSSettingPersonalSettingDataModel *model4 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model4.imageName = @"";
        model4.title = @"提示音";

        LQSSettingPersonalSettingDataModel *model5 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model5.imageName = @"";
        model5.title = @"位置信息";
        model5.subTitle = @"关闭后，您则不会出现在周边用户和周边帖子";
        LQSSettingPersonalSettingDataModel *model6 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model6.imageName = @"";
        model6.title = @"分享";

        LQSSettingPersonalSettingDataModel *model7 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model7.imageName = @"";
        model7.title = @"清理缓存";

        LQSSettingPersonalSettingDataModel *model8 = [[LQSSettingPersonalSettingDataModel alloc] init];
        model8.imageName = @"";
        model8.title = @"关于";

        [self.dataSource addObject:model1];
        [self.dataSource addObject:model2];
        [self.dataSource addObject:model3];
        [self.dataSource addObject:model4];
        [self.dataSource addObject:model5];
        [self.dataSource addObject:model6];
        [self.dataSource addObject:model7];
        [self.dataSource addObject:model8];
    }

    return _dataSource;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人设置";
    [self createTableView];
}
#pragma mark - customMethods
- (void)createTableView
{
    _tableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - LQSNavBarBottom) style:UITableViewStylePlain];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];


}
- (void)shareMethod
{
    //    [self popToRootViewControllerAnimated:YES];
    //    U-Share
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage* thumbURL =  [UIImage imageNamed:@"icon.png"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"测试分享功能" descr:@"龙泉寺论坛" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://forum.longquanzs.org/forum.php?tid=32335";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}


#pragma mark - tableViewDelegate & tableViewDasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"settingPersonalSettingIdentifier";
    LQSSettingPersonalSettingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LQSSettingPersonalSettingViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell pushesSettingPersonalSettingModel:[self.dataSource objectAtIndex:indexPath.row]];
    if (indexPath.row == 1 || indexPath.row == 2 ||indexPath.row == 3||indexPath.row == 4) {

    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(50, 100, 20, 10)];
            [switchButton setOn:YES];
        cell.accessoryView = switchButton;
    }
        return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     LQSSettingPersonalSettingDataModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if ([model.title isEqualToString:@"修改密码"]) {
        //
        LQSChangePasswordVC * changePasswordVC = [[LQSChangePasswordVC alloc] init];
        changePasswordVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changePasswordVC animated:YES];
    }
    if ([model.title isEqualToString:@"关于"]) {
        //
        LQSAboutUsVC * aboutUsVC = [[LQSAboutUsVC alloc] init];
        aboutUsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
    if ([model.title isEqualToString:@"分享"]) {
        //
        [self shareMethod];
    }
}
@end

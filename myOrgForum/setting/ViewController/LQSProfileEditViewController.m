//
//  LQSProfileEditViewController.m
//  myOrgForum
//
//  Created by 周双 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSProfileEditViewController.h"
#define kavarTag 111
#define kxueliTag 222
#define kxingbieTag 333
@interface LQSProfileEditViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>{
    
    LQSUITableView *_tableView;
    UIActionSheet *_avarSheet;
    UIActionSheet *_xueliSheet;
    UIActionSheet *_xingbieSheet;
    NSMutableArray *_userProfileArr;
    NSMutableArray *_userProfileArray;
}

@end

@implementation LQSProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userProfileArr = [NSMutableArray array];
    _userProfileArray = [NSMutableArray array];
    [self requestData];
    self.title = @"编辑";
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self loadTableView];
}

- (void)requestData{
    
    NSString *baseStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    paramDic[@"r"] = @"user/getprofilegroup";
    paramDic[@"egnVersion"] = @"v2035.2";
    paramDic[@"sdkVersion"] = @"2.4.3.0";
    paramDic[@"apphash"] = @"276399a6";
    paramDic[@"type"] = @"userInfo";
    paramDic[@"accessToken"] = @"83e1f2e3b07cc0629ac89ed355920";
    paramDic[@"accessSecret"] = @"a742cf58f0d3c28e164f9d9661b6f";
    paramDic[@"forumKey"] = @"BW0L5ISVRsOTVLCTJx";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) weakSelf = self;
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        
        
        
        
        LQSLog(@"success_____");
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
        kNetworkNotReachedMessage;
    }];
    
    
}

- (void)loadTableView{
    _tableView = [[LQSUITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark - tableViewDelegate&tableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 ) {
        return 20;
    }
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }else{
        return 40;
    }
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if (section == 1){
        
        return 3;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 2;
    }else{
        
        return 4;
        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"bianjiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"头像";
        //        创建头像imageView
        UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30 - 70, 5, 70, 70)];
        imagView.layer.cornerRadius = 35;
        [imagView sd_setImageWithURL:nil  placeholderImage:nil ];//接口上传头像
        imagView.backgroundColor = [UIColor greenColor];
        cell.contentView.backgroundColor = [UIColor blueColor];
        [cell.contentView addSubview:imagView];
    }else if (indexPath.section == 0 && indexPath.row == 1)
        
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (_avarSheet) {
            [_avarSheet removeFromSuperview];
            _avarSheet = nil;
        }
        _avarSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        _avarSheet.tag = kavarTag;
        [_avarSheet showInView:self.view];
    }else if (indexPath.section == 2 && indexPath.row == 1){
        //    选择学历
        if (_xueliSheet) {
            [_xueliSheet removeFromSuperview];
            _xueliSheet = nil;
        }
        _xueliSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"其他",@"小学",@"中学",@"专科",@"本科",@"硕士",@"博士", nil];
        _xueliSheet.tag = kxueliTag;
        [_xueliSheet showInView:self.view];
    }else if (indexPath.section == 4 && indexPath.row == 1){
        //    性别选择
        if (_xingbieSheet) {
            [_xingbieSheet removeFromSuperview];
            _xingbieSheet = nil;
        }
        
        _xingbieSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女",@"保密", nil];
        _xingbieSheet.tag = kxingbieTag;
        [_xingbieSheet showInView:self.view];
        
    }
    
    
    
    
}

#pragma mark ActionSheetDelegate&datasource

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
        return;
    }
    if ([actionSheet isEqual: _avarSheet]) {
        switch (buttonIndex) {
            case 0:
                [self pickerImageFromCameraWithTag:_avarSheet.tag];
                break;
            case 1:
                [self pickerImageFromAlbumWithTag:_avarSheet.tag];
                break;
        }
    }else if ([actionSheet isEqual:_xueliSheet]){
        
    }
    
    
    
    
    
    
}

@end

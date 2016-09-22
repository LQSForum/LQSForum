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
    LQSProfileEditDataModel *_editModel;
    NSMutableArray *_dataArr;
    NSMutableArray *_fieldAtaArr;//默认信息
    NSMutableArray *_contactArr;//联系信息
    NSMutableArray *_educateArr;//教育信息
    NSMutableArray *_workArr;//工作信息
    NSMutableArray *_personalArr;//个人信息

    LQSProfileEditDetailDataModel *_detailModel;
    NSMutableArray *_countArr;
}

@end

@implementation LQSProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _detailModel = [LQSProfileEditDetailDataModel new];
    _userProfileArr = [NSMutableArray array];
    _userProfileArray = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    _fieldAtaArr = [NSMutableArray array];//defautlt组
    _contactArr = [NSMutableArray array];
    _educateArr = [NSMutableArray array];
    _workArr = [NSMutableArray array];
    _personalArr = [NSMutableArray array];
    
    
    
    
    
    _countArr = [NSMutableArray array];
    
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
    [manager POST:baseStr parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"sucess");
        _dataArr = responseObject[@"list"];
        //获取返回的数据模型
        for (NSDictionary *dict in _dataArr) {
        if ([[dict objectForKey:@"name"] isEqualToString:@"default"]) {
                //获取name是default的的分组的cell的数据模型数组
            _fieldAtaArr = [LQSProfileEditDetailDataModel mj_objectArrayWithKeyValuesArray:dict[@"field"]];
            }
            if ([[dict objectForKey:@"name"] isEqualToString:@"联系方式"]) {
                //获取name是default的的分组的cell的数据模型数组
                _contactArr = [LQSProfileEditDetailDataModel mj_objectArrayWithKeyValuesArray:dict[@"field"]];
            }
            
            if ([[dict objectForKey:@"name"] isEqualToString:@"教育情况"]) {
                //获取name是default的的分组的cell的数据模型数组
                _educateArr = [LQSProfileEditDetailDataModel mj_objectArrayWithKeyValuesArray:dict[@"field"]];
            }
            if ([[dict objectForKey:@"name"] isEqualToString:@"工作情况"]) {
                //获取name是default的的分组的cell的数据模型数组
                _workArr = [LQSProfileEditDetailDataModel mj_objectArrayWithKeyValuesArray:dict[@"field"]];
            }
            
            if ([[dict objectForKey:@"name"] isEqualToString:@"个人信息"]) {
                //获取name是default的的分组的cell的数据模型数组
                _personalArr = [LQSProfileEditDetailDataModel mj_objectArrayWithKeyValuesArray:dict[@"field"]];
            }
        }
        
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
    
    return _dataArr.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{//获取数组里面相应组的里面的字典对应field字典数组的个数
    NSUInteger sectionCount;
    if ([[_dataArr[section] objectForKey:@"name"] isEqualToString:@"default"]) {
        sectionCount = _fieldAtaArr.count;
    }else if ([[_dataArr[section] objectForKey:@"name"] isEqualToString:@"联系方式"]){
        sectionCount = _contactArr.count;
    }else if ([[_dataArr[section] objectForKey:@"name"] isEqualToString:@"教育情况"]){
        sectionCount = _educateArr.count;
    }else if ([[_dataArr[section] objectForKey:@"name"] isEqualToString:@"工作情况"]){
        sectionCount = _workArr.count;
    }else if ([[_dataArr[section] objectForKey:@"name"] isEqualToString:@"个人信息"]){
        sectionCount = _personalArr.count;
    }
    return sectionCount;
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
//    说明是第一组
    if ([[_dataArr[indexPath.section] objectForKey:@"name"] isEqualToString:@"default"]) {
        LQSProfileEditDetailDataModel *detailModel = _fieldAtaArr[indexPath.row];
//        获取第一组的详情模型
        if (indexPath.row == 0) {//如果是第一组的第一行
            cell.textLabel.text = detailModel.name;
            //        创建头像imageView
            UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 30 - 70, 5, 70, 70)];
            imagView.layer.cornerRadius = 35;
            NSString *imagName = detailModel.nowSet;
            [imagView sd_setImageWithURL:[NSURL URLWithString:imagName]  placeholderImage:nil ];//接口上传头像
            imagView.backgroundColor = [UIColor greenColor];
            cell.contentView.backgroundColor = [UIColor blueColor];
            [cell.contentView addSubview:imagView];
        }else{
            cell.textLabel.text = detailModel.name;
            cell.detailTextLabel.text = detailModel.nowSet;
        }
    }
    
    if ([[_dataArr[indexPath.section] objectForKey:@"name"] isEqualToString:@"联系方式"]) {
        //获取第二组的每一行
        LQSProfileEditDetailDataModel *detailModel = _contactArr[indexPath.row];
        cell.textLabel.text = detailModel.name;
        cell.detailTextLabel.text = detailModel.nowSet;
    }if ([[_dataArr[indexPath.section] objectForKey:@"name"] isEqualToString:@"教育情况"]) {
        //获取第二组的每一行
        LQSProfileEditDetailDataModel *detailModel = _educateArr[indexPath.row];
        cell.textLabel.text = detailModel.name;
        cell.detailTextLabel.text = detailModel.nowSet;
    }
    if ([[_dataArr[indexPath.section] objectForKey:@"name"] isEqualToString:@"工作情况"]) {
        //获取第二组的每一行
        LQSProfileEditDetailDataModel *detailModel = _workArr[indexPath.row];
        cell.textLabel.text = detailModel.name;
        cell.detailTextLabel.text = detailModel.nowSet;
    }
    if ([[_dataArr[indexPath.section] objectForKey:@"name"] isEqualToString:@"个人信息"]) {
        //获取第二组的每一行
        LQSProfileEditDetailDataModel *detailModel = _personalArr[indexPath.row];
        cell.textLabel.text = detailModel.name;
        cell.detailTextLabel.text = detailModel.nowSet;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_dataArr[indexPath.section] objectForKey:@"name"] isEqualToString:@"default"]) {//第一组条件下判断第一行
        if (indexPath.row == 0) {
            if (_avarSheet) {
                [_avarSheet removeFromSuperview];
                _avarSheet = nil;
            }
            _avarSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
            _avarSheet.tag = kavarTag;
            [_avarSheet showInView:self.view];
        }
        if ([[_dataArr[indexPath.section] objectForKey:@"name"] isEqualToString:@"教育情况"]) {//第二组条件下判断第二行
//            获取当前组所在的详情模型
            LQSProfileEditDetailDataModel *detailModel = _educateArr[indexPath.row];
            if ([detailModel.name isEqualToString:@"学历"]) {
                //    选择学历
                if (_xueliSheet) {
                    [_xueliSheet removeFromSuperview];
                    _xueliSheet = nil;
                }
                _xueliSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"其他",@"小学",@"中学",@"专科",@"本科",@"硕士",@"博士", nil];
                _xueliSheet.tag = kxueliTag;
                [_xueliSheet showInView:self.view];
            }
        }
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

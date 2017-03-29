//
//  LQSBBSDetailViewController.m
//  myOrgForum
//  功能 ： 论坛详情页
//  Created by 徐经纬 on 16/8/25.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBBSDetailViewController.h"
#import "LQSHttpsRequest.h"
#import "LQSBBSDetailCell.h"
#import "LQSAddViewHelper.h"
#import "LQSArticleContentView.h"
#import "LQSHTMLViewController.h"
// 跳转举报页
#import "LQSReportDetailViewController.h"
// 跳转打赏页
#import "LQSDaShangTableViewController.h"
// 跳转评论页
#import "LQSHuiFuPingLunViewController.h"
// baseManager,获取apphash等信息
#import "LQSBaseManager.h"
// 输入框
#import "LQSTextView.h"
#import "LQSEmotionTextView.h"
#import "LQSEmotionKeyboard.h"
#import "LQSPluginView.h"
@interface LQSBBSDetailViewController ()<UITableViewDataSource,UITableViewDelegate,LQSBBSDetailCellDelegate,UITextViewDelegate,LQSPluginViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
}

@property (nonatomic, strong) UITableView *mainList;
@property (nonatomic,strong)UIView *inputView;
@property (nonatomic,strong)LQSEmotionTextView *inputTV;
@property (nonatomic,assign)BOOL textFieldIsShowing;
@property (nonatomic,strong)UIButton *shildBtn;
// 临时keyboardFrame
@property (nonatomic,assign)CGRect tempKBF;
// 用于判断是否显示表情,yes为显示,no为不显示.
@property (nonatomic,assign)BOOL emotionIsShowing;
// 拷贝过来的表情view
@property (nonatomic, strong) LQSEmotionKeyboard *emotionKeyBoard;
// pluginBoardView
@property (nonatomic,strong)LQSPluginView *pluginBoardView;
@property (nonatomic,strong)NSMutableArray *replysArr;

@end

@implementation LQSBBSDetailViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 下面这行代码解决pop回本页时tableView自动下移问题.
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSLog(@"详情页boardID：%@",self.selectModel.board_id);
    [self setupInputbtn];
    [self setUpInputView];
    [self postForData];
    
}
// 在这里处理一下自动刷新操作。
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)setUpInputView{

        _inputView = [[UIView alloc]init];
        [self.view addSubview:_inputView];
        _inputView.backgroundColor = [UIColor greenColor];
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom).offset(44);
            make.height.equalTo(@44);
        }];
        self.textFieldIsShowing = NO;
        // 加号btn
        UIButton *plusBtn = [[UIButton alloc]init];
        [_inputView addSubview:plusBtn];
        [plusBtn setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_more_n"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_more_h"] forState:UIControlStateHighlighted];
        [plusBtn addTarget:self action:@selector(plusBtnAct) forControlEvents:UIControlEventTouchUpInside];
        [plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inputView.mas_left).offset(5);
            make.top.equalTo(_inputView.mas_top).offset(7);
            make.height.equalTo(@30);
            make.width.equalTo(@30);
        }];
        // 笑脸btn
        UIButton *faceBtn = [[UIButton alloc]init];
        [_inputView addSubview:faceBtn];
        self.emotionIsShowing = NO;
        [faceBtn setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_face_n"] forState:UIControlStateNormal];
        [faceBtn setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_face_h"] forState:UIControlStateHighlighted];
        [faceBtn addTarget:self action:@selector(faceBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        [faceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(plusBtn.mas_right).offset(5);
            make.top.equalTo(_inputView.mas_top).offset(7);
            make.height.equalTo(@30);
            make.width.equalTo(@30);
        }];
    // 输入textView
    self.inputTV = [[LQSEmotionTextView alloc]init];
    self.inputTV.delegate = self;
    [self.inputView addSubview:self.inputTV];
    self.inputTV.maxNumberOfLines = 5;
    __weak typeof(self) weakSelf = self;
    self.inputTV.lqs_textHeightChangeBlock = ^(NSString *text,CGFloat textHeight){
        // 文本框文字高度改变会自动执行这个【block】，可以在这【修改底部View的高度】
        // 设置底部条的高度 = 文字高度 + textView距离上下间距约束
        // 为什么添加10 ？（10 = 底部View距离上（5）底部View距离下（5）间距总和）
        [weakSelf changeF:textHeight];
//        _bottomHCons.constant = textHeight + 10;
    };

    [self.inputTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(faceBtn.mas_right).offset(5);
                    make.top.equalTo(_inputView.mas_top).offset(7);
                    make.bottom.equalTo(_inputView.mas_bottom).offset(-7);
                    make.right.equalTo(_inputView.mas_right).offset(-40);
//                    make.height.equalTo(@30);

    }];
        // 发送按钮
        UIButton *sendBtn = [[UIButton alloc]init];
        [_inputView addSubview:sendBtn];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_inputTV.mas_right);
            make.top.equalTo(_inputView.mas_top).offset(5);
            make.right.equalTo(_inputView.mas_right);
//            make.bottom.equalTo(_inputView.mas_bottom);
            make.height.equalTo(@30);
        }];
        [sendBtn addTarget:self action:@selector(sendMsgAct) forControlEvents:UIControlEventTouchUpInside];

}
- (void)changeF:(NSInteger)height{
    NSLog(@"输入文字后计算出的高度:%zd",height);
//    if (height >40) {
        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view.mas_bottom).offset(-(kScreenHeight - self.tempKBF.origin.y) - 44 -height);
            make.height.equalTo(@(height+10));
        }];

//    }
}

// 输入按钮
- (void)setupInputbtn{
//    self.inputView.backgroundColor = [UIColor blueColor];
    // 输入栏的底层view
    UIView *inputView = [[UIView alloc]init];
    inputView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@44);
    }];
    // 回个话鼓励下楼主
    UIButton *guliBtn = [[UIButton alloc]init];
    [inputView addSubview:guliBtn];
    guliBtn.layer.cornerRadius = 5;
    guliBtn.layer.masksToBounds = YES;
    guliBtn.backgroundColor = [UIColor lightGrayColor];
    [guliBtn setImage:[UIImage imageNamed:@"dz_toolbar_reply_icon_pen"] forState:UIControlStateNormal];
    
    guliBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    [guliBtn setTitle:@"回个话鼓励下楼主" forState:UIControlStateNormal];
    [guliBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(inputView.mas_left).offset(10);
                make.top.equalTo(inputView.mas_top).offset(5);
                make.bottom.equalTo(inputView.mas_bottom).offset(-5);
                make.right.equalTo(inputView.mas_right).offset(-54);
    }];
    [guliBtn.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guliBtn.mas_left).offset(10);
        make.top.equalTo(guliBtn.mas_top).offset(5);
        make.bottom.equalTo(guliBtn.mas_bottom).offset(-5);
        
    }];
    [guliBtn.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(guliBtn.imageView.mas_right).offset(5);
        make.top.equalTo(guliBtn.mas_top).offset(5);
        make.bottom.equalTo(guliBtn.mas_bottom).offset(-5);
    }];
    // *条评论label
    UILabel *comontCountLabel = [[UILabel alloc]init];
    [guliBtn addSubview:comontCountLabel];
    // 评论条数.参数由接口提供
    NSInteger i = 1;
    comontCountLabel.text = [NSString stringWithFormat:@"%zd条评论",i];
    [comontCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(guliBtn.mas_right).offset(-8);
        make.top.equalTo(guliBtn.mas_top).offset(5);
        make.bottom.equalTo(guliBtn.mas_bottom).offset(-5);
    }];
    [guliBtn addTarget:self action:@selector(guliAct) forControlEvents:UIControlEventTouchUpInside];
    // 由点击鼓励按钮,触发弹出输入框事件,在这里注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // 分享btn
    UIButton *shareBtn = [[UIButton alloc]init];
    [inputView addSubview:shareBtn];
    [shareBtn setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_share_n"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_share_h"] forState:UIControlStateHighlighted];
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(inputView.mas_right);
        make.top.equalTo(inputView.mas_top);
        make.bottom.equalTo(inputView.mas_bottom);
        make.width.equalTo(@44);
    }];
    [shareBtn addTarget:self action:@selector(toolbarShareAct) forControlEvents:UIControlEventTouchUpInside];
    }
#pragma mark - 点击输入框的按钮事件
// 表情键盘的初始化
- (LQSEmotionKeyboard *)emotionKeyBoard
{
    if (!_emotionKeyBoard) {
        self.emotionKeyBoard = [LQSEmotionKeyboard keyboard];
        self.emotionKeyBoard.width = LQSScreenW;
        self.emotionKeyBoard.height = 216;
        // 监听表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:LQSEmotionDidSelectedNotification object:nil];
        // 监听删除按钮点击的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:LQSEmotionDidDeletedNotification object:nil];
    }
    return _emotionKeyBoard;
}
// + 号点击栏的初始化
-(LQSPluginView *)pluginBoardView{
    if (!_pluginBoardView) {
        _pluginBoardView = [LQSPluginView pluginView];
        _pluginBoardView.width = LQSScreenW;
        _pluginBoardView.height = 216;
        [_pluginBoardView setupSubViews];
        _pluginBoardView.lqsPluginViewDelegate = self;
    }
    return _pluginBoardView;
}
// 分享按钮事件
- (void)toolbarShareAct{
    NSLog(@"点击分享");
}
// 鼓励事件,触发输入框
- (void)guliAct{
    NSLog(@"点击鼓励按钮,触发键盘弹出事件");
    [self.inputTV becomeFirstResponder];
}
// 加号按钮的点击事件
- (void)plusBtnAct{
    NSLog(@"加号按钮的点击事件");
    if ([self.inputTV.inputView isEqual:self.pluginBoardView]) {
        NSLog(@"现在键盘是+键盘");
        self.inputTV.inputView = nil;
        [self.inputTV reloadInputViews];
    }else{
        NSLog(@"现在键盘是正常键盘");
        //        [self.inputTV resignFirstResponder];
        self.inputTV.inputView = self.pluginBoardView;
        [self.inputTV reloadInputViews];
    }
    if (![self.inputTV isFirstResponder]) {
        [self.inputTV becomeFirstResponder];
    }
}
// 笑脸的点击事件
- (void)faceBtnAct:(UIButton *)sender{
    
    if ([self.inputTV.inputView isEqual:self.emotionKeyBoard]) {
        NSLog(@"现在键盘是表情键盘");
        [sender setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_face_n"] forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_face_h"] forState:UIControlStateHighlighted];
        self.inputTV.inputView = nil;
        [self.inputTV reloadInputViews];
    }else{
        NSLog(@"现在键盘是正常键盘");
        [sender setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_keyboard_n"] forState:UIControlStateNormal];
                [sender setImage:[UIImage imageNamed:@"dz_toolbar_reply_outer_keyboard_h"] forState:UIControlStateHighlighted];
//        [self.inputTV resignFirstResponder];
        self.inputTV.inputView = self.emotionKeyBoard;
        [self.inputTV reloadInputViews];
    }
    if (![self.inputTV isFirstResponder]) {
        [self.inputTV becomeFirstResponder];
    }
    
}
// 发送按钮的点击事件
- (void)sendMsgAct{
    NSLog(@"发送按钮的点击事件");
}
#pragma mark - 表情选中的通知事件
/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    LQSEmotion *emotion = note.userInfo[LQSSelectedEmotion];
    
    // 1.拼接表情
    [self.inputTV appendEmotion:emotion];
    
}
/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    // 往回删
    [self.inputTV deleteBackward];
}
#pragma mark -pluginView的代理事件
-(void)didSelectBtnAtIndex:(UIButton *)selectedBtn{
    switch (selectedBtn.tag) {
        case 10010:
            NSLog(@"添加图片按钮的点击事件");
            [self openPhotoLibrary];
            break;
        case 10011:
            NSLog(@"添加拍照按钮的点击事件");
            [self openCamera];
            break;
        case 10012:
            NSLog(@"添加定位按钮的点击事件");
            break;
        default:
            break;
    }
}
#pragma mark - 调用照相机和相册和delegate
- (void)openCamera{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    // 判断能否打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 摄像头
        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerController animated:YES completion:nil];
    }else{
        NSLog(@"没有摄像头");
    }
}
// 打开相册
- (void)openPhotoLibrary{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    pickerController.delegate = self;
    pickerController.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerController animated:YES completion:nil];
        NSLog(@"代开相册");
        // 接下来的操作还没写.
    }else{
        NSLog(@"未能打开相册");
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        NSLog(@"拿到照片进行下一步操作.这里先不做");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 取消事件
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark -键盘通知的监听处理
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 由于是键盘每次改变frame后都会触发这个方法,每次改变都会创建一个不同的shieldbtn,所以需要判断是否之前有一个shield,如果有,则移除,然后添加新的.
    if (self.shildBtn) {
        [self.shildBtn removeFromSuperview];
        self.shildBtn = nil;
    }
    // 键盘显示\隐藏完毕的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 用拿到的键盘的frame.origin.y与屏幕高度对比,如果相等则为隐藏,否则就是显示键盘,显示则要输入栏和键盘高度匹配
    self.tempKBF = frame;
    [self.view bringSubviewToFront:self.inputView];
    if (!(frame.origin.y == LQSScreenH)) {
        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-(kScreenHeight - frame.origin.y));
            // 添加透明遮罩层,阻挡下面的触摸事件.
            UIButton *shieldbtn = [[UIButton alloc]init];
            [self.view addSubview:shieldbtn];
            // 这里遮罩层没有隐藏navigationBar的点击事件,但是线上版本是有隐藏的.
            [shieldbtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top);
                make.bottom.equalTo(self.inputView.mas_top);
                make.left.equalTo(self.view.mas_left);
                make.right.equalTo(self.view.mas_right);
            }];
            [shieldbtn addTarget:self action:@selector(hideKeyBoard) forControlEvents:UIControlEventTouchUpInside];
            shieldbtn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            self.shildBtn = shieldbtn;
            self.textFieldIsShowing = YES;
        }];
    }else{
        [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(44);
        }];
        [self.shildBtn removeFromSuperview];
//        self.textFieldIsShowing = NO;
    }
        // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)hideKeyBoard{
    // 这里线上版的功能是,点击遮罩层,然后自动发送输入框内的内容.然后就隐藏输入框,展示输入btn...所以这里暂时模仿线上功能.将来需要讨论这个设计.
    // 先假装发送内容.实际是直接清空数据
    self.inputTV.text = nil;
    [self.inputTV resignFirstResponder];
}
- (void)creatTableViewList
{
    [self.view addSubview:self.mainList];
    self.view.backgroundColor = [UIColor redColor];
//    self.mainList.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.mainList.backgroundColor = [UIColor yellowColor];
}

- (UITableView *)mainList
{
    if (!_mainList) {
        _mainList = [[UITableView alloc] initWithFrame:CGRectMake(0, 64/*0*/, self.view.width, self.view.height - 64-44) style:UITableViewStylePlain];
        _mainList.showsVerticalScrollIndicator = NO;
        _mainList.showsHorizontalScrollIndicator = YES;
        _mainList.delegate = self;
        _mainList.dataSource = self;
        _mainList.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _mainList.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _mainList;
}
#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numOfRow = 0;
    switch (section) {
        case 0:{
            numOfRow =1;
            break;
        }
        case 1:{
            numOfRow =1;
            break;
        }
        case 2:{
            numOfRow =1;
            break;
        }case 3:{
            numOfRow =  self.replysArr.count;
            // 这里的行数，可以加上最后一个“没有更多了”作为最后一个cell。
            break;
        }
            
        default:
            break;
    }
    return numOfRow;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 使用先注册cell，然后dequeueReusableCellWithIdentifier withIndexPath的方法会出问题，执行顺序是先height，再cell，然后这里的赋值就没把高度赋值过去。就出现高度问题。还是得用这个!cell,创建cell。
//    NSLog(@"CELLForRowAtIndexPath,section:%zd,row:%zd",indexPath.section,indexPath.row);
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            if (!cell) {
                cell = [[LQSBBSDetailTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
            }
             [(LQSBBSDetailTitleCell *)cell setTopicModel:self.bbsDetailTopicModel];
            break;
        }case 1:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
            if (!cell) {
                cell = [[LQSBBSDetailContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contentCell"];
            }
            [(LQSBBSDetailContentCell *)cell setTopicModel:self.bbsDetailTopicModel];
            break;
        }case 2:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"voteCell"];
            if (!cell) {
                cell = [[LQSBBSDetailVoteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"voteCell"];
            }
             [(LQSBBSDetailVoteCell *)cell setTopicModel:self.bbsDetailTopicModel];
            break;
        }case 3:{
            cell = [tableView dequeueReusableCellWithIdentifier:@"posterCell" ];
            if (!cell) {
                cell = [[LQSBBSDetailReplyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"posterCell"];
            }
//            cell.contentView.backgroundColor = [UIColor orangeColor];
            [(LQSBBSDetailReplyCell *)cell setPinglunModel:self.replysArr[indexPath.row]];
            break;
        }
        default:
            break;
    }
    // 让controller成为cell的代理
    ((LQSBBSDetailCell*)cell).delegate = self;
//    NSLog(@"cellForRowAtIndexPath,section:%zd,row:%zd",indexPath.section,indexPath.row);
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 写上这个预估高度后，也并没有先运行cell再计算高度啊。还是先heightForRow,再cellForRow。。。
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1){
        return 500;
    }else if(indexPath.section == 2){
        return 80;
    }else{
        return 100.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"heightForRowAtIndexPath,section:%zd,row:%zd",indexPath.section,indexPath.row);
    
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:{
            height = self.bbsDetailTopicModel.topicTitleHeight;
            break;
        }case 1:{
            height = self.bbsDetailTopicModel.topicContenHeight;
            break;
        }case 2:{
            height = self.bbsDetailTopicModel.topicVoteheight;
            break;
        }case 3:{
            LQSBBSPosterModel *model = self.replysArr[indexPath.row];
            height = model.contentHeight ;//待定
            break;
        }
        default:
            break;
    }
    return height;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

#pragma mark -  cell的代理任务
// 举报
-(void)pushToReport{
    LQSReportDetailViewController *reportVC = [[LQSReportDetailViewController alloc]init];
    [self.navigationController pushViewController:reportVC animated:YES];
}
// 打赏,不用这个了。因为线上版的是个网页打赏。而不是原生页面。
//-(void)pushToDashang{
//    LQSDaShangTableViewController *dashangVC = [[LQSDaShangTableViewController alloc]init];
//    [self.navigationController pushViewController:dashangVC animated:YES];
//}
// 跳转到网页打赏页
-(void)pushToDashangWebWithUrl:(NSString *)url{
    if (url.length > 0) {
        LQSHTMLViewController *htmlVC = [[LQSHTMLViewController alloc]init];
        htmlVC.title = @"打赏";
        [self.navigationController pushViewController:htmlVC animated:YES];
        [htmlVC loadHtmlControllerWithUrl:[NSURL URLWithString:url]];
    }
}
// 跳转到显示更多打赏人的页面
-(void)pushToMoreIconWebWithUrl:(NSString *)url{
    if (url.length > 0) {
        LQSHTMLViewController *htmlVC = [[LQSHTMLViewController alloc]init];
        htmlVC.title = @"全部打赏";
        [self.navigationController pushViewController:htmlVC animated:YES];
        [htmlVC loadHtmlControllerWithUrl:[NSURL URLWithString:url]];
    }
}
// 评论
- (void)pushToReply{
    LQSHuiFuPingLunViewController *huiFuVC = [[LQSHuiFuPingLunViewController alloc]init];
    [self.navigationController pushViewController:huiFuVC animated:YES];
}
#pragma mark -  获取数据
- (void)postForData
{
    // 请求参数:pageSize=10&egnVersion=v2035.2&order=0&sdkVersion=2.4.3.0&apphash=abe0fdef&boardId=320&topicId=64994&accessToken=caf68203b950537adbe1bcf6bc7ad&page=1&accessSecret=84f18779cf550aac2fce53e8eb266&forumKey=BW0L5ISVRsOTVLCTJx
    //pageSize,egnVersion,order,sdkVersion,apphash,boardId,accessToken,page,accessSecret,forumKey
    // 其中boardid,和topicId用来标记出不同的帖子.
    // NSString *loginUrlStr = @"http://forum.longquanzs.org/mobcent/app/web/index.php?";
    NSString *loginUrlStr = @"http://forum.longquanzs.org//mobcent/app/web/index.php?";
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"forum/postlist" forKey:@"r"];
    [dict setObject:@"10" forKey:@"pageSize"];// 每一页要显示的楼层数
    [dict setObject:@"v2035.2" forKey:@"egnVersion"];
    [dict setObject:@"0" forKey:@"order"];
    [dict setObject:@"2.4.3.0" forKey:@"sdkVersion"];//待变
    //[dict setObject:@"a15172f4" forKey:@"apphash"];//待变
    // ---------------接口文档2.0中的参数改变>>>>>>>-------------------//
    // 接口文档2.0中的apphash:004f025c
    // 获取存储的apphash
    NSString *appHash =  [LQSBaseManager defaultManager].appHash;
    if (appHash) {
        [dict setObject:appHash forKey:@"apphash"];
    }else{
        [dict setObject:@"004f025c" forKey:@"apphash"];}//待变
    
    //  [dict setObject:LQSTR(self.selectModel.board_id) forKey:@"boardId"];//待变
    // 接口文档2.0的boardId:538
    if (!self.boardID) {
        [dict setObject:@"538" forKey:@"boardId"];
    }
    else{[dict setObject:self.boardID forKey:@"boardId"];}
    // NSLog(@"传入的boardid:%@",self.selectModel.board_id);
    // [dict setObject:LQSTR(self.selectModel.topicId) forKey:@"topicId"];//待变
    // 接口文档2.0的topicID:63006
    if (!self.topicID) {
        [dict setObject:@"63006" forKey:@"topicId"];
    }else{
        [dict setObject:self.topicID forKey:@"topicId"];}
    // NSLog(@"传入的topicID:%@",self.selectModel.topicId);
    // -----------<<<<<<<接口文档2.0中的参数改变----------------------//
    NSString *accessToken = [LQSBaseManager defaultManager].token;
    if (accessToken ) {
        [dict setObject:accessToken forKey:@"accessToken"];
    }else{
        [dict setObject:@"7e3972a7a729e541ee373e7da3d06" forKey:@"accessToken"];}// 每个人登陆后会有固定的accessToken,但是每次登陆的token都不同.需要在一个固定的位置保存起来.现在暂时用这个.
    [dict setObject:@"1" forKey:@"page"];//待变
    NSString *accessSecret = [LQSBaseManager defaultManager].secret;
    if (accessSecret) {
        [dict setObject:accessSecret forKey:@"accessSecret"];
    }else{
        [dict setObject:@"39a68e4d5473e75669bce2d70c4b9" forKey:@"accessSecret"];}
    [dict setObject:@"BW0L5ISVRsOTVLCTJx" forKey:@"forumKey"];
    
    [session POST:loginUrlStr parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功");
        //        [self cleanData];
        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];//[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"返回数据：%@",dict);
        [self getBBSDetailModelFrom:dict];
        [self creatTableViewList];
        self.title = self.bbsDetailModel.forumName;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    /*
     //    LQSHttpsRequest *request = [[LQSHttpsRequest alloc] init];
     //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
     //    [dict setObject:@"forum/postlist" forKey:@"r"];
     //    [dict setObject:@"10" forKey:@"pageSize"];
     //    [dict setObject:@"v2035.2" forKey:@"egnVersion"];
     //    [dict setObject:@"0" forKey:@"order"];
     //    [dict setObject:@"2.4.3.0" forKey:@"sdkVersion"];//待变
     //    [dict setObject:@"a15172f4" forKey:@"apphash"];//待变
     //    [dict setObject:LQSTR(self.selectModel.board_id) forKey:@"boardId"];//待变
     //    [dict setObject:LQSTR(self.selectModel.topicId) forKey:@"topicId"];//待变
     //    [dict setObject:@"7e3972a7a729e541ee373e7da3d06" forKey:@"accessToken"];
     //    [dict setObject:@"1" forKey:@"page"];//待变
     //    [dict setObject:@"39a68e4d5473e75669bce2d70c4b9" forKey:@"accessSecret"];
     //    [dict setObject:@"BW0L5ISVRsOTVLCTJx" forKey:@"forumKey"];
     //
     //    [request POST:@"http://forum.longquanzs.org//mobcent/app/web/index.php?" parameters:dict success:^(id responseObject) {
     //        LQSLog(@"请求成功");
     //
     //        NSDictionary *dict = [NSDictionary dictionaryWithDictionary:responseObject];
     //        LQSBBSModel *model = [LQSBBSModel mj_objectWithKeyValues:dict];
     //
     //        LQSLog(@"%@",dict);
     //    } failure:^(NSError *error) {
     //        LQSLog(@"请求失败");
     //
     //
     //    }];
     */
    
}
- (LQSBBSDetailModel *)bbsDetailModel
{
    if (nil == _bbsDetailModel) {
        _bbsDetailModel = [[LQSBBSDetailModel alloc] init];
    }
    return _bbsDetailModel;
}
-(LQSBBSDetailTopicModel *)bbsDetailTopicModel{
    if (!_bbsDetailTopicModel) {
        _bbsDetailTopicModel = [[LQSBBSDetailTopicModel alloc]init];
    }
    return _bbsDetailTopicModel;
}
-(NSMutableArray *)replysArr{
    if (!_replysArr) {
        _replysArr = [NSMutableArray array];
    }
    return _replysArr;
}
- (void)getBBSDetailModelFrom:(NSDictionary *)dict
{
    //帖子信息
    if(nil != dict){
        self.bbsDetailModel.forumName = LQSTR(dict[@"forumName"]);
        self.bbsDetailModel.rs = LQSTR(dict[@"rs"]);
        self.bbsDetailModel.total_num = LQSTR(dict[@"total_num"]);
        self.bbsDetailModel.has_next = LQSTR(dict[@"has_next"]);
        [self.bbsDetailTopicModel ModelWithDict:dict[@"topic"]];
    }
    // 回复列表
    if (nil != dict[@"list"]) {
//        self.bbsDetailModel.list = [NSMutableArray array];
        for (NSDictionary *listDict in dict[@"list"]) {
            LQSBBSPosterModel *model = [[LQSBBSPosterModel alloc] init];
            [model modelWithDict:listDict];
//            model.location = LQSTR(listDict[@"location"]);
//            model.mobileSign = LQSTR(listDict[@"mobileSign"]);
//            model.position = LQSTR(listDict[@"position"]);
//            model.status = LQSTR(listDict[@"status"]);
//            model.title = LQSTR(listDict[@"title"]);
//            model.delThread = LQSTR(listDict[@"delThread"]);
//            model.icon = LQSTR(listDict[@"icon"]);
//            model.reply_status = LQSTR(listDict[@"reply_status"]);
//            model.role_num = LQSTR(listDict[@"role_num"]);
//            model.level = LQSTR(listDict[@"level"]);
//            model.reply_id = LQSTR(listDict[@"reply_id"]);
//            model.reply_type = LQSTR(listDict[@"reply_type"]);
//            model.reply_name = LQSTR(listDict[@"reply_name"]);
//            model.reply_posts_id = LQSTR(listDict[@"reply_posts_id"]);
//            model.role_num = LQSTR(listDict[@"role_num"]);
//            model.is_quote = LQSTR(listDict[@"is_quote"]);
            // is_quote,如果是0，表示没有回复，如果是1，表示有对原来评论的引用，也就是TA评论了这个引用的评论。
//            model.userTitle = LQSTR(listDict[@"userTitle"]);
//            model.quote_pid = LQSTR(listDict[@"quote_pid"]);
//            model.posts_date = LQSTR(listDict[@"posts_date"]);
//            model.quote_content = LQSTR(listDict[@"quote_content"]);
//            //quote_content，二级评论的内容。也就是他评论的是那个评论的，而且，发现，二级评论的层数只有一层，就是不能直接回复楼中楼。不知道为什么做成这样的效果。和微信等主流效果并不相同。
//            // 如果做成线上版的这种效果，就不需要处理成一级回复为sectionheader，二级回复等是cell的效果。直接用cell，以及cell内置的一个label就可以了。
//            model.quote_user_name = LQSTR(listDict[@"quote_user_name"]);
            [self.replysArr addObject:model];
            
        }
    }
}
//- (CGFloat)caculateCellHeightWithWidth:(CGFloat)width contentStr:(NSString *)str{
//    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
//    // 计算文字高度
//    CGRect rect = [str  boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dict context:nil];
//    return rect.size.height;
//
//}

/*
 {
 body = {
 externInfo = {
 padding = ;
 };
 };
 forumName = 仁爱慈善;
 rs = 1;
 total_num = 16;
 head = {
 errInfo = 调用成功,没有任何错误;
 alert = 0;
 errCode = 00000000;
 version = 2.5.0.0;
 };
 has_next = 1;
 errcode = ;
 img_url = ;
 topic = {
 hits = 526;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=208291&size=middle;
 poll_info = <null>;
 level = 2;
 replies = 16;
 isFollow = 0;
 managePanel = ();
 hot = 0;
 essence = 1;
 location = ;
 reward = {
 score = (
 {
 value = 20;
 info = 微笑;
 }
 ,
 );
 userList = (
 {
 uid = 215083;
 userIcon = http://forum.longquanzs.org/uc_server/avatar.php?uid=215083&size=middle;
 userName = 朱丽安;
 }
 ,
 {
 uid = 216752;
 userIcon = http://forum.longquanzs.org/uc_server/avatar.php?uid=216752&size=middle;
 userName = 君宝;
 }
 ,
 );
 showAllUrl = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/ratelistview&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=&pid=331950;
 userNumber = 2;
 };
 reply_status = 1;
 flag = 0;
 vote = 0;
 type = normal_complex;
 delThread = 0;
 create_date = 1472246535000;
 activityInfo = <null>;
 is_favor = 0;
 rateList = {
 body = (
 {
 field3 = ;
 field2 = +10;
 field1 = 朱丽安;
 }
 ,
 {
 field3 = ;
 field2 = +10;
 field1 = 君宝;
 }
 ,
 );
 showAllUrl = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/ratelistview&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=&pid=331950;
 total = {
 field3 = ;
 field2 = 20;
 field1 = 2;
 }
 ;
 head = {
 field3 = ;
 field2 = 微笑;
 field1 = 参与人数;
 }
 ;
 }
 ;
 top = 0;
 status = 1;
 user_nick_name = 净土莲开;
 extraPanel = (
 {
 extParams = {
 beforeAction = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topicrate&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=331950&type=check;
 }
 ;
 title = 评分;
 type = rate;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topicrate&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=331950&type=view;
 }
 ,
 );
 content = (
 {
 infor =           昨晚小组聚餐，在餐前自由交流的时候，一位师兄说在今天奉粥的时候，一位阿姨今天连续拿了3杯粥，她产生了一些烦恼，觉得老人有些贪心了，这时候周冬彩老师给我们分享了一个别的心栈发生的故事：曾经有一位女士每天都到心栈拿3杯粥，一拿就拿了三个月没有间断过，这期间心栈的一些家人有很多人都看不惯，觉得她贪心太重了，因此产生了烦恼，不过还是每天给她3杯粥，3个月后，这位女士突然不来拿粥了，几天后这位女士来到心栈面对大家说以后不会再拿粥了，因为他爱人得了绝症，吃不下东西，一次她路过心栈随意的从心栈给爱人那了一杯粥，她爱人说这粥好香啊！从那天起女士每天从心栈拿3杯粥，让他爱人早中晚各喝一杯粥，一拿就拿了3个月，现在她爱人离世了，她不再麻烦大家了，她今天过来是感谢大家的。听了她的话在场的好多家人都哭了，家人们宁愿她每天都过来拿3杯粥，也不希望她爱人离她而去。还有一位良乡心栈的老粥客，拿个碗每天也是要好几杯粥，后来了解到，这位老人一生没成过家，没有收入，良乡心栈没成立前他每天早上都是不吃饭的，饿了只是喝点水～～
 听到这些我的眼圈红了，我们只是每天观察别人的过错，看看别人有没有做的不好，没有看到真正的原因，在她们“错误”的背后都是有原因的，我们怎样才能真正利益到更多的人，看看我们的心缘在哪里？而不是看他们每天过来拿几杯杯粥。其实每一个接我们粥的人，都是成就我们的人，没有他们怎么成就我们的爱心，心栈这个平台太好了，能让我们每个人对境练心，从善行的实践中提高自己。感恩仁爱慈善基金会！感恩周冬彩老师的分享！感恩每天来喝粥的粥客们！
 良乡心栈 李立新;
 type = 0;
 }
 ,
 {
 infor = http://forum.longquanzs.org/data/appbyme/thumb/0/11/16/xgsize_bd8c5fb641dd0adf46ada1e5cd732a01.jpg;
 type = 1;
 originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/27/052215y4v4j2hgg2pjghhj.jpg;
 aid = 138543;
 }
 ,
 {
 infor = http://forum.longquanzs.org/data/attachment/forum/201608/27/052215q4nj3394033j34g4.jpg;
 type = 1;
 originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/27/052215q4nj3394033j34g4.jpg;
 aid = 138544;
 }
 ,
 {
 infor = http://forum.longquanzs.org/data/attachment/forum/201608/27/052215s00rr7rdm4eemmml.jpg;
 type = 1;
 originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/27/052215s00rr7rdm4eemmml.jpg;
 aid = 138545;
 }
 ,
 {
 infor = http://forum.longquanzs.org/data/attachment/forum/201608/27/052215vtr05e8zwtj59qtr.jpeg;
 type = 1;
 originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/27/052215vtr05e8zwtj59qtr.jpeg;
 aid = 138546;
 }
 ,
 );
 user_id = 208291;
 userTitle = 初级会员;
 gender = 1;
 mobileSign = 来自龙泉论坛手机客户端;
 reply_posts_id = 331950;
 topic_id = 64434;
 title = [仁爱心栈]每天拿走3杯粥却让我落泪～～;
 zanList = (
 );
 sortId = 0;
 };
 boardId = 259;
 icon_url = ;
 list = (
 {
 reply_content = (
 {
 infor = [mobcent_phiz=http://forum.longquanzs.org/static/image/smiley/xianer/xianer01.gif];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = ;
 position = 2;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=193868&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 福德;
 reply_posts_id = 332019;
 role_num = 1;
 level = 6;
 reply_id = 193868;
 is_quote = 0;
 userTitle = 金牌会员;
 quote_pid = 0;
 posts_date = 1472259831000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=332019&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 一些家人有很多人都看不惯，觉得她贪心太重了，因此产生了烦恼
 
 那位女士估计察觉了，不然不会来说的[mobcent_phiz=http://forum.longquanzs.org/static/image/smiley/QQ/004.gif];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = ;
 position = 3;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=216430&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 第十一次握手;
 reply_posts_id = 332111;
 role_num = 1;
 level = 4;
 reply_id = 216430;
 is_quote = 0;
 userTitle = 高级会员;
 quote_pid = 0;
 posts_date = 1472279155000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=332111&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 感动。;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 4;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=204183&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 麓安;
 reply_posts_id = 332128;
 role_num = 1;
 level = 4;
 reply_id = 204183;
 is_quote = 0;
 userTitle = 高级会员;
 quote_pid = 0;
 posts_date = 1472282739000;
 quote_content = ;
 extraPanel = (
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 是呀，哎，我也是老找别人不是，却不知道别人的经历;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 5;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=211494&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 小小沙弥僧;
 reply_posts_id = 332138;
 role_num = 1;
 level = 3;
 reply_id = 211494;
 is_quote = 0;
 userTitle = 中级会员;
 quote_pid = 0;
 posts_date = 1472283804000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=332138&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 感动，惭愧;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 6;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=215413&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 文殊座下一沙弥;
 reply_posts_id = 332146;
 role_num = 1;
 level = 2;
 reply_id = 215413;
 is_quote = 0;
 userTitle = 初级会员;
 quote_pid = 0;
 posts_date = 1472284523000;
 quote_content = ;
 extraPanel = (
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = [good][good][good];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 7;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=145029&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 韩影;
 reply_posts_id = 332150;
 role_num = 1;
 level = 2;
 reply_id = 145029;
 is_quote = 0;
 userTitle = 初级会员;
 quote_pid = 0;
 posts_date = 1472285044000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=332150&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 学佛真的是要忘掉我缘众生啊。真难做到。还是要做，要学。;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 8;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=212816&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 净琉璃;
 reply_posts_id = 332155;
 role_num = 1;
 level = 2;
 reply_id = 212816;
 is_quote = 0;
 userTitle = 初级会员;
 quote_pid = 0;
 posts_date = 1472285526000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=332155&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 感动，阿弥陀佛。希望我的孩子也有机会奉粥。;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 9;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=216709&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 嘻嘻140707;
 reply_posts_id = 332261;
 role_num = 1;
 level = 1;
 reply_id = 216709;
 is_quote = 0;
 userTitle = 新手上路;
 quote_pid = 0;
 posts_date = 1472296430000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=332261&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = “还有一位良乡心栈的老粥客，拿个碗每天也是要好几杯粥，后来了解到，这位老人一生没成过家，没有收入，良乡心栈没成立前他每天早上都是不吃饭的，饿了只是喝点水～～”
 阿弥陀佛，感恩。;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = ;
 position = 10;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=207581&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 铃子;
 reply_posts_id = 332265;
 role_num = 1;
 level = 3;
 reply_id = 207581;
 is_quote = 0;
 userTitle = 中级会员;
 quote_pid = 0;
 posts_date = 1472297247000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=332265&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 感恩所以拿粥的菩萨
 随喜赞叹同行善友[送花][送花][送花];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 11;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=207134&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 高莹霞;
 reply_posts_id = 332273;
 role_num = 1;
 level = 6;
 reply_id = 207134;
 is_quote = 0;
 userTitle = 金牌会员;
 quote_pid = 0;
 posts_date = 1472299818000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64434&pid=332273&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 );
 page = 1;
 forumTopicUrl = http://forum.longquanzs.org/forum.php?mod=viewthread&tid=64434;
 }
 */
/*
 {
 body = {
 externInfo = {
 padding = ;
 }
 ;
 }
 ;
 forumName = 聚焦龙泉;
 rs = 1;
 total_num = 15;
 head = {
 errInfo = 调用成功,没有任何错误;
 alert = 0;
 errCode = 00000000;
 version = 2.5.0.0;
 }
 ;
 has_next = 1;
 errcode = ;
 img_url = ;
 topic = {
 hits = 201;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=216574&size=middle;
 poll_info = <null>;
 level = 2;
 replies = 15;
 isFollow = 0;
 managePanel = (
 );
 hot = 0;
 essence = 1;
 location = ;
 reward = {
 score = (
 {
 value = 10;
 info = 微笑;
 }
 ,
 );
 userList = (
 {
 uid = 212816;
 userIcon = http://forum.longquanzs.org/uc_server/avatar.php?uid=212816&size=middle;
 userName = 净琉璃;
 }
 ,
 );
 showAllUrl = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/ratelistview&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=&pid=329531;
 userNumber = 1;
 }
 ;
 reply_status = 1;
 flag = 0;
 vote = 0;
 type = normal_complex;
 delThread = 0;
 create_date = 1471903513000;
 activityInfo = <null>;
 is_favor = 0;
 rateList = {
 body = (
 {
 field3 = ;
 field2 = +10;
 field1 = 净琉璃;
 }
 ,
 );
 showAllUrl = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/ratelistview&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=&pid=329531;
 total = {
 field3 = ;
 field2 = 10;
 field1 = 1;
 }
 ;
 head = {
 field3 = ;
 field2 = 微笑;
 field1 = 参与人数;
 }
 ;
 }
 ;
 top = 0;
 status = 1;
 user_nick_name = 论坛报道;
 extraPanel = (
 {
 extParams = {
 beforeAction = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topicrate&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329531&type=check;
 }
 ;
 title = 评分;
 type = rate;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/topicrate&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329531&type=view;
 }
 ,
 );
 content = (
 {
 infor = 部组档案
 慈幼组：目前隶属于教化部项目处，日常主要在周六承担班长、讲师或其他骨干义工在寺学修期间，孩子的临时看护，使得师兄们可以不受孩子“打扰”，安心学修。
 在重大节日或活动，慈幼组的老师们还带领孩子排演节目，为大家带来萌萌的欢乐。
 我是一位孩子的妈妈，也是慈幼组的义工。
 当提笔写这篇文章时，眼前浮现出齐师兄那一双笑起来眯成月牙状的眼睛，高师兄分享带动时平和谦卑的笑容，吴师兄的幽默与严谨，孙师兄抓拍镜头的认真，李师兄默默及时的补位，周师兄一讲故事就变身为表情帝的模样，马老师带领着小朋友翩翩起舞，小朋友身穿绿马甲在寺院穿梭、玩耍……;
 type = 0;
 }
 ,
 {
 infor = http://forum.longquanzs.org/data/attachment/forum/201608/23/055521nno046oy1w4ipzmn.jpg.thumb.jpg;
 type = 1;
 originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/055521nno046oy1w4ipzmn.jpg;
 aid = 137123;
 }
 ,
 {
 infor = （周老师讲故事）
 
 这一幅幅画面是如此温馨，让我一想起来就倍感温暖，躁动的心就会安静。
 每次上山看到这些师兄们在，就像是有了依靠一样。虽然慈幼组很缺人，但当我一边做义工看其他师兄的孩子，自家孩子过来黏糊的时候，师兄们都接纳我及孩子当时的状态，等着我和孩子成长。
 
 初识齐师兄，是在九品莲花路的走廊下，她说动漫中心需要小朋友给贤二配音，问我家姑娘愿不愿意去？她总是能见缝插针的给大家寻找机会承担。
 说起动漫，小朋友都喜欢，所以每当六一儿童节的时候，动漫中心都会和慈幼组一起联合举办亲子法会，捏个贤二、赵小翠，看看贤二系列电影，好运气的时候还会有法师慈悲的给小朋友在额头点个圆圆的朱砂。动漫中心也会把小朋友配音的动漫片拿到慈幼组，让小朋友在快乐中学习佛法。
 
 提起高师兄，我就想起宝宝稚嫩的声音：“妈妈，高兴阿姨为什么是快乐阿姨呢”？就忍不住扑哧一乐。是呀，高兴阿姨可不就是快乐阿姨嘛。
 高师兄虽然年龄小，但她对佛法的行持让我深深的震撼。她最常说的一句话就是“我们要发和师长一样的心”。
 高师兄的依师是“无我”的状态。这表现在她对上位及法师的安排从来都是不打折扣的执行，遇到困难就自己默默的在部组里带领大家努力的解决。用朝娜师兄的话来说，她不会想为我的部组争取什么利益，而是想师长需要这个部组怎么做、这个部组需要我怎么做。
 
 慈幼组大部分都是女众，当8、9岁的男孩儿们躁动起来打闹时，女众很难hold住场面，这时吴师兄就救星般的出现了，他淡定的对惊慌失措的女众师兄说：把他们几个交给我吧，用斋的时候给你带回来。很奇怪，吴师兄一声招呼，刚才还躁动的几个男孩像被施了魔法一样，兴奋的但规矩地跟着吴老师身后出去玩了，等玩一圈回来时，几个孩子开始安静的拼乐高了。
 
 马老师，是慈幼组的舞蹈专家啦。每次举行茶话会或者晚会，如果有小朋友演出的话，基本都是马老师带领小义工们加班排练出来的啦。
 因为慈幼组周六需要看护孩子，无法参加班长班课。于是师兄们就善巧的排班，隔周承担：需要上讲师课的师兄在上班长班课时参加慈幼组看护活动，需要上班长班课的师兄就在上讲师班课时参加看护活动，大家互相帮助，成就各自闻法的因缘。
 
 此外，为了拉拔既不是讲师也无法听班长班课的师兄，慈幼组开设了自己的YY共修平台，每天都有不同的内容。谭姥姥每天坚持带动大家背诵楞严咒，牛师兄、展师兄每天中午12:20——13:20带动大家拜忏、学习师父开示，每周四为本周六的承担开会。在义工群里每天都会有师兄发整理好的、师父当天微博答疑，YY平台学修内容如百法，最新版贤二漫画，让大家在学修中进步。
 
 慈幼组无论什么时候都是一个整体，这是我在慈幼组最强烈的一个感受。不但是在看护活动中，即使是法会期间，慈幼组总是作为一个部组去共同承担其中的一部分工作，不论是上班长班课还是讲师班课，大家都尽量聚在一起或者出坡或者讨论活动方案，不但积累了丰厚的资粮，还切实的拉近了大家的业缘。
 
 近期，慈幼组教室腾给了其他部组，场地变不稳定且没有室内场地，即使这样，师兄们仍然满心欢喜的承担。从马老师7月17日雨中看护活动的分享中，我们就能体会到这份欢喜。
 
 周六，阴有雨。 上午，小树林中，孩子们闭眼静坐，静听古筝独奏，欣赏古诗‘与赵莒茶宴’，慢慢的饮茶，甜甜的吃着茶点。当老师询问小朋友听古筝时，脑海里，眼前呈现的是什么时，小朋友们的分享让我赞叹。
 
 “我听到了蝉鸣”、“我听到了鸟叫”、“我听到了脚步声”、“我闻到了茶的清香”、 “我来做首诗”……
 我又一次感动，我对天气的担心，是多余的。
 
 下雨了，孩子们笑着，说着，在他们心中，那不是雨，那是甘露。在三宝地，树林中，蝉鸣，鸟叫，饮茶，赏诗，作诗，品尝甜品，享受着天降甘露……好美呀！感恩孩子们！让我感受到户外活动的快乐！下周六见！爱你们。;
 type = 0;
 originalInfo = http://forum.longquanzs.org/data/attachment/forum/201608/23/055521nno046oy1w4ipzmn.jpg;
 aid = 137123;
 }
 ,
 {
 infor = http://forum.longquanzs.org/data/appbyme/thumb/0/27/0/xgsize_a42b0c0f2487aab3a4aa07b661e38a83.gif;
 type = 1;
 originalInfo = http://forum.longquanzs.org/static/image/hrline/2.gif;
 aid = 0;
 }
 ,
 {
 infor =  你是不是看得心动了呢？也想把孩子送到慈幼组呢？
 噢，那就发心承担吧，因为慈幼组看护范围是班长、副班长、讲师及骨干义工的孩子呢。赶快承担起来，让你的孩子有机会加入我们吧。 ;
 type = 0;
 originalInfo = http://forum.longquanzs.org/static/image/hrline/2.gif;
 aid = 0;
 }
 ,
 );
 user_id = 216574;
 userTitle = 初级会员;
 gender = 1;
 mobileSign = ;
 reply_posts_id = 329531;
 topic_id = 64054;
 title = [教化部]部组故事02 | 一想起来就倍感温暖：我眼中的慈幼组;
 zanList = (
 );
 sortId = 0;
 }
 ;
 boardId = 502;
 icon_url = ;
 list = (
 {
 reply_content = (
 {
 infor = 随喜赞叹师兄分享！[good][good][good];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 2;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=195349&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 丁烨;
 reply_posts_id = 329696;
 role_num = 1;
 level = 6;
 reply_id = 195349;
 is_quote = 0;
 userTitle = 金牌会员;
 quote_pid = 0;
 posts_date = 1471929834000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329696&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 成就他人就是成就自己！随喜赞叹师兄们[good][good][good];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 3;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=207267&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 贤英@;
 reply_posts_id = 329747;
 role_num = 1;
 level = 6;
 reply_id = 207267;
 is_quote = 0;
 userTitle = 金牌会员;
 quote_pid = 0;
 posts_date = 1471937721000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329747&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 对慈幼组的师兄们除了赞叹，还是赞叹。
 对高师兄的印象也是如此，平和谦卑，微笑淡然。
 
 阿弥陀佛！;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = ;
 position = 4;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=165485&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 人间的面;
 reply_posts_id = 329796;
 role_num = 1;
 level = 8;
 reply_id = 165485;
 is_quote = 0;
 userTitle = 超级版主;
 quote_pid = 0;
 posts_date = 1471942903000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329796&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 是的 感恩他们！;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = ;
 position = 5;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=141111&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 贤写;
 reply_posts_id = 329829;
 role_num = 1;
 level = 8;
 reply_id = 141111;
 is_quote = 1;
 userTitle = 超级版主;
 quote_pid = 0;
 posts_date = 1471945781000;
 quote_content = 人间的面 发表于 2016-8-23 17:01
 对慈幼组的师兄们除了赞叹，还是赞叹。
 对高师兄的印象也是如此，平和谦卑，微笑淡然。;
 extraPanel = (
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 慈幼组的师兄们都棒棒哒！[good][good][good];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 6;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=205804&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 贤从;
 reply_posts_id = 329999;
 role_num = 1;
 level = 3;
 reply_id = 205804;
 is_quote = 0;
 userTitle = 中级会员;
 quote_pid = 0;
 posts_date = 1471960827000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=329999&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 感恩随喜[mobcent_phiz=http:/ /forum.longquanzs.org/static/image/smiley/QQ/080.gif];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = ;
 position = 7;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http:/ /forum.longquanzs.org/uc_server/avatar.php?uid=141074&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = bathar;
 reply_posts_id = 330385;
 role_num = 1;
 level = 8;
 reply_id = 141074;
 is_quote = 0;
 userTitle = 论坛元老;
 quote_pid = 0;
 posts_date = 1472017683000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=330385&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 感恩师兄们;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 8;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=214227&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 贤萌;
 reply_posts_id = 331125;
 role_num = 1;
 level = 2;
 reply_id = 214227;
 is_quote = 0;
 userTitle = 初级会员;
 quote_pid = 0;
 posts_date = 1472116100000;
 quote_content = ;
 extraPanel = (
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 随喜赞叹，看的末学满心欢喜[呵呵];
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 9;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=215236&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = xinnongyang;
 reply_posts_id = 331133;
 role_num = 1;
 level = 2;
 reply_id = 215236;
 is_quote = 0;
 userTitle = 初级会员;
 quote_pid = 0;
 posts_date = 1472117521000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=331133&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 随喜赞叹！;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 10;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=210503&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = 阿珍;
 reply_posts_id = 331208;
 role_num = 1;
 level = 3;
 reply_id = 210503;
 is_quote = 0;
 userTitle = 中级会员;
 quote_pid = 0;
 posts_date = 1472128079000;
 quote_content = ;
 extraPanel = (
 );
 quote_user_name = ;
 }
 ,
 {
 reply_content = (
 {
 infor = 成就他人就是成就自己，师兄们真正实践了这句话，我要向师兄们学习无我利他，阿弥陀佛！;
 type = 0;
 }
 ,
 );
 location = ;
 mobileSign = 来自龙泉论坛手机客户端;
 position = 11;
 status = 1;
 title = ;
 managePanel = (
 );
 delThread = 0;
 icon = http://forum.longquanzs.org/uc_server/avatar.php?uid=167890&size=middle;
 reply_status = 1;
 reply_type = normal;
 reply_name = dongchen;
 reply_posts_id = 331319;
 role_num = 1;
 level = 3;
 reply_id = 167890;
 is_quote = 0;
 userTitle = 中级会员;
 quote_pid = 0;
 posts_date = 1472135435000;
 quote_content = ;
 extraPanel = (
 {
 extParams = {
 recommendAdd = 0;
 beforeAction = ;
 isHasRecommendAdd = 0;
 }
 ;
 title = 支持;
 recommendAdd = ;
 type = support;
 action = http://forum.longquanzs.org/mobcent/app/web/index.php?r=forum/support&sdkVersion=2.5.0.0&accessToken=7e3972a7a729e541ee373e7da3d06&accessSecret=39a68e4d5473e75669bce2d70c4b9&apphash=a15172f4&tid=64054&pid=331319&type=post;
 }
 ,
 );
 quote_user_name = ;
 }
 ,
 );
 
 page = 1;
 forumTopicUrl = http://forum.longquanzs.org/forum.php?mod=viewthread&tid=64054;
 }
 
 
 */





@end

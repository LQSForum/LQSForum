//
//  LQSComposeViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSComposeViewController.h"
#import "LQSLocationModel.h"
#import <CoreLocation/CoreLocation.h>
#import "LQSComposePhotosView.h"
#import "LQSPickViewSelectViewController.h"


@interface LQSComposeViewController ()<LQSComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,CLLocationManagerDelegate,jmpPickVCDelegate>

// 正文
@property (nonatomic, weak) LQSEmotionTextView *textView;

// 标题
@property (nonatomic, weak) LQSTextView *titleView;

// 键盘上方工具条
@property (nonatomic, weak) LQSCompostToolbar *toolbar;

// 添加照片的视图
@property (nonatomic, weak) LQSComposePhotosView *photosView;

// 键盘视图
@property (nonatomic, strong) LQSEmotionKeyboard *kerboard;

// 是否正在切换键盘
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;

// 显示位置的按钮
@property (nonatomic, strong) UIButton *locationBtn;

// 网络请求管理器
@property(nonatomic, strong) AFHTTPSessionManager * manager;

// 存储用户位置信息的模型
@property(nonatomic, strong) NSMutableArray * models;

// 获取位置信息的管理类
@property(nonatomic, strong) CLLocationManager *locationManager;

// 标题与正文的分割线
@property(nonatomic, strong) UIView *marginLine;


@end

@implementation LQSComposeViewController

- (void)loadView
{
    [super loadView];
    UIScrollView *scrrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrrollView.backgroundColor = [UIColor lightGrayColor];
    scrrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 5);
    
    self.view =scrrollView ;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor clearColor];
    // 设置导航条内容
    [self setupNavBar];
    // 添加输入控件
    [self setupTextView];
    
    //应该将工具条添加到键盘上方
   
    // 添加显示图片的相册控件
    [self setupPhotosView];
    
    // 添加工具条
    [self setupToolbar];
    
    // 添加定位按钮
    [self setupLocationBtn];
    
    // 监听表情选中的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:LQSEmotionDidSelectedNotification object:nil];
    
    // 监听删除按钮点击的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidDeleted:) name:LQSEmotionDidDeletedNotification object:nil];

    
    }

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  view显示完毕的时候再弹出键盘，避免显示控制器view的时候会卡住
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 成为第一响应者（叫出键盘）
    [self.textView becomeFirstResponder];
    [self.titleView becomeFirstResponder];

}

// 添加显示图片的相册控件
- (void)setupPhotosView
{
    LQSComposePhotosView *photosView = [[LQSComposePhotosView alloc] init];
    photosView.delegate = self;
    
    photosView.width = self.textView.width;
    photosView.height = self.textView.height * 0.5;
    
    photosView.x = self.textView.x;
    photosView.y = CGRectGetMaxY(self.textView.frame) + 10;
    [self.view addSubview:photosView];
    photosView.backgroundColor = [UIColor whiteColor];
    self.photosView = photosView;
    
    
}
// 跳转控制器的协议方法
- (void)jmpPickVC:(LQSComposePhotosView *)composePhotoView
{

    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    LQSPickViewSelectViewController *pickerViewSelectVC = [[LQSPickViewSelectViewController alloc] initWithCollectionViewLayout:layout];
    
    [self presentViewController:pickerViewSelectVC animated:YES completion:nil];
}

// 添加工具条
- (void)setupToolbar
{
    // 1.创建
    LQSCompostToolbar *toolbar = [[LQSCompostToolbar alloc] init];
   // toolbar.backgroundColor = [UIColor redColor];
//    toolbar.width = self.view.width;
    toolbar.delegate = self;
//    toolbar.height = 44;
    self.toolbar = toolbar;
    
    // 2.显示
//    toolbar.y = CGRectGetMaxY(self.textView.frame);
    
    
    toolbar.frame = CGRectMake(0, CGRectGetMaxY(self.photosView.frame)+20, LQSScreenW, 44);
    [self.view addSubview:toolbar];
}

// 设置导航条内容
- (void)setupNavBar
{
    NSString *name = @""/*[LQSAccountTool account].name*/;
    if (name) {
        // 构建文字
        NSString *prefix = @"发微博";
        NSString *text = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[text rangeOfString:prefix]];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[text rangeOfString:name]];
        
        // 创建label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.attributedText = string;
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.width = 100;
        titleLabel.height = 44;
        self.navigationItem.titleView = titleLabel;
    } else {
        self.title = @"发微博";
    }
    //====================//
    //self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

//添加输入控件
- (void)setupTextView
{
//创建标题控件
    UITextField *titleText = [[UITextField alloc] init];
    titleText.placeholder = @"来个标题";
    NSLog(@"%f",CGRectGetMaxY(self.navigationController.navigationBar.frame));
    titleText.frame = CGRectMake(0,0, LQSScreenW, 44);
    titleText.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleText];
    
// 标题和正文间的分割线
    UIView *marginLine = [[UIView alloc] init];
    marginLine.frame = CGRectMake(0, CGRectGetMaxY(titleText.frame), LQSScreenW, 1);
    marginLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:marginLine];
    self.marginLine = marginLine;
    
//创建正文控件
    CGFloat textViewH = LQSScreenH * 0.5 - 44 - 64 - 2;
    LQSEmotionTextView *textView = [[LQSEmotionTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.marginLine.frame), LQSScreenW, textViewH)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.alwaysBounceVertical = YES; // textView可以滚动的属性
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    textView.placehoder = @"分享两句话...";
    textView.placehoderColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:17];
    
    // 当拖拽时textView让键盘消失
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 正在更换键盘时不做任何操作
    if (self.isChangingKeyboard) return;
    //=====================================//
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}


/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
//        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
        
        // 工具跳不在keyBoard上方=======================//
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(LQSComposeToolbar *)toolbar didClickedButton:(LQSComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case LQSComposeToolbarButtonTypeCamera: // 照相机
            [self openCamera];
            break;
            
        case LQSComposeToolbarButtonTypePicture: // 相册
            [self openAlbum];
            break;
            
        case LQSComposeToolbarButtonTypeEmotion: // 表情
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

/**
 *  打开照相机
 */
- (void)openCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开相册
 */
- (void)openAlbum
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/**
 *  打开表情
 */
- (void)openEmotion
{
    // 正在切换键盘
    self.changingKeyboard = YES;
    
    if (self.textView.inputView) { // 当前显示的是自定义键盘，切换为系统自带的键盘
        self.textView.inputView = nil;
        
        // 显示表情图片
        self.toolbar.showEmotionButton = YES;
    } else { // 当前显示的是系统自带的键盘，切换为自定义键盘
        // 如果临时更换了文本框的键盘，一定要重新打开键盘
        self.textView.inputView = self.kerboard;
        
        // 不显示表情图片
        self.toolbar.showEmotionButton = NO;
    }
    
    // 关闭键盘
    [self.textView resignFirstResponder];
    
#warning 记录是否正在更换键盘
    // 更换完毕完毕
    self.changingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 打开键盘
        [self.textView becomeFirstResponder];
    });
}

/**
 *  当表情选中的时候调用
 *
 *  @param note 里面包含了选中的表情
 */
- (void)emotionDidSelected:(NSNotification *)note
{
    LQSEmotion *emotion = note.userInfo[LQSSelectedEmotion];
    
    // 1.拼接表情
    [self.textView appendEmotion:emotion];
    
    // 2.检测文字长度
    [self textViewDidChange:self.textView];
}

/**
 *  当点击表情键盘上的删除按钮时调用
 */
- (void)emotionDidDeleted:(NSNotification *)note
{
    // 往回删
    [self.textView deleteBackward];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.添加图片到相册中
    [self.photosView addImage:image];
}

#pragma mark - 添加定位按钮
- (void)setupLocationBtn
{
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [locationBtn setImage:[UIImage imageNamed:@"tab_discover_hilighted"] forState:UIControlStateNormal];
    
    [locationBtn setImage:[UIImage imageNamed:@"tab_discover_common"] forState:UIControlStateSelected];
    
    [locationBtn setTitle:@"显示所在位置" forState:UIControlStateNormal];
    
    // 获取文字长度的宽
    CGFloat textW = locationBtn.intrinsicContentSize.width;
    
    CGFloat locationBtnX = 8;
    CGFloat locationBtnY = LQSScreenH - 100;
    CGFloat locationBtnW = textW + 8;
    CGFloat locationBtnH = 30;
    
    locationBtn.frame = CGRectMake(locationBtnX, locationBtnY, locationBtnW, locationBtnH);
    
    // 按钮上显示的文字颜色
    [locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [locationBtn setBackgroundColor:[UIColor whiteColor]];
    
    self.locationBtn = locationBtn;
    
    [self.view addSubview:locationBtn];
    
    [locationBtn addTarget:self action:@selector(locationBtnClick) forControlEvents:UIControlEventTouchDown];
    
}

#pragma mark - 定位按钮点击方法
- (void)locationBtnClick
{
    self.locationBtn.selected = YES;
    
    // 获取用户经纬度
    [self getlatitudeAndLongitude];
}

#pragma mark - 获取经纬度
- (void)getlatitudeAndLongitude
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    self.locationManager = locationManager;
    
    //期望精度 单位:米  100 :表示系统默认将100米看做同一个范围
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //位置过滤 单位:米  100.0 表示当用户位置更新了100.0米后调用对应的代理方法
    locationManager.distanceFilter = 100.0;
    
    // iOS 8.0 之后需要用户授权
    if([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        [locationManager requestWhenInUseAuthorization];
    }
    
    
    locationManager.delegate = self;
    
    [locationManager startUpdatingLocation];
    
}

// locationManager的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(nonnull CLLocation *)newLocation fromLocation:(nonnull CLLocation *)oldLocation
{
    // 通过经纬度获取位置信息
    [self getLocationWithLatitude:newLocation.coordinate.latitude andLongitude:newLocation.coordinate.longitude];
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - 发送网络请求获取位置信息
- (void)getLocationWithLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude
{
//====================先确定位置是否可用=========================//
    NSString * url = @"http://forum.longquanzs.org//mobcent/app/web/index.php?r=user/location";
    
    [self.manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // JSON数据解析
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:NULL];
        
        NSLog(@"---------------------%@",dict);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 显示错误信息
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"网络连接失败");
    }];

//====================获取位置信息=========================//
    // 拼接url路径
    NSString *urlStr=[NSString stringWithFormat:@"http://api.map.baidu.com/geocoder/v2/?ak=GT5EmhOircF8diYLKDrIezIp&location=%f,%f&output=json&pois=1",latitude,longitude];
    
    // 发送get请求,获取位置信息
    [self.manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 如果模型数组不为空,清空模型数组(不清除,点击按钮时数据不会变)
        [self.models removeAllObjects];
        
        // JSON数据解析
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:NULL];
        
        //NSLog(@"---------------------%@",dict);// 解析成功
        
        NSArray<NSDictionary *> * arr = dict[@"result"][@"pois"];
    
        //NSLog(@"+++++++++++++++++++++%@",arr);// 取出可能的每个位置信息成功
        
        // 字典转模型
        [arr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            LQSLocationModel *model = [LQSLocationModel modelWithDict:obj];
            
            [self.models addObject:model];
        }];
        
        
        // 回到主线程显示位置信息
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 有很多信息,要列出来,目前只固定选择第一个地址
            LQSLocationModel *model = self.models[0];
            // 展示数据
            [self.locationBtn setTitle:model.name forState:UIControlStateSelected];
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络连接失败");
    }];

}


#pragma mark - 懒加载
/** AFHTTPSessionManager 懒加载 */
- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        _manager = manager;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSSet * set = [NSSet setWithObjects:@"text/plain", @"text/html", nil];
        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:set];
    }
    return _manager;
}

/** models 懒加载 */
- (NSMutableArray*)models {
    if (_models == nil) {
        _models = [NSMutableArray array];
    }
    return _models;
}

// keyBoard懒加载
- (LQSEmotionKeyboard *)kerboard
{
    if (!_kerboard) {
        self.kerboard = [LQSEmotionKeyboard keyboard];
        self.kerboard.width = LQSScreenW;
        self.kerboard.height = 216;
    }
    return _kerboard;
}
@end

//
//  LQSComposeViewController.m
//  myOrgForum
//
//  Created by SkyAndSea on 16/6/27.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSComposeViewController.h"

@interface LQSComposeViewController ()<LQSComposeToolbarDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, weak) LQSEmotionTextView *textView;
@property (nonatomic, weak) LQSTextView *titleView;

@property (nonatomic, weak) LQSEmotionToolbar *toolbar;
@property (nonatomic, weak) LQSComposePhotosView *photosView;
@property (nonatomic, strong) LQSEmotionKeyboard *kerboard;
/**
 *  是否正在切换键盘
 */
@property (nonatomic, assign, getter = isChangingKeyboard) BOOL changingKeyboard;

@end

@implementation LQSComposeViewController

#pragma mark - 初始化方法
- (LQSEmotionKeyboard *)kerboard
{
    if (!_kerboard) {
        self.kerboard = [LQSEmotionKeyboard keyboard];
        self.kerboard.width = LQSScreenW;
        self.kerboard.height = 216;
    }
    return _kerboard;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    // 设置导航条内容
    [self setupNavBar];
//    添加输入控件
    [self setupTextView];

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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

//添加输入控件
- (void)setupTextView
{
//创建标题控件
    LQSTextView *titleView = [[LQSTextView alloc] initWithFrame:CGRectMake(2, 64, LQSScreenW, 44)];
    titleView.font = [UIFont systemFontOfSize:15.0];
    titleView.backgroundColor = [UIColor greenColor];
    titleView.alwaysBounceVertical = YES;
    self.titleView = titleView;
    titleView.placehoder = @"请输入标题";
    [self.view addSubview:titleView];
//创建正文控件
    LQSEmotionTextView *textView = [[LQSEmotionTextView alloc] initWithFrame:CGRectMake(0, 64 + 44 + 2, LQSScreenW, LQSScreenH * 0.5 - 44 - 64 - 2)];
    textView.backgroundColor = [UIColor yellowColor];

    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    textView.placehoder = @"分享两句话...";
    textView.placehoderColor = [UIColor lightGrayColor];
    textView.font = [UIFont systemFontOfSize:15];
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
    if (self.isChangingKeyboard) return;
    
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
//        self.toolbar.transform = CGAffineTransformIdentity;
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
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

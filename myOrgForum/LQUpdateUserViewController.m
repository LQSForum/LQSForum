//
//  LQUpdateUserViewController.m
//  myOrgForum
//
//  Created by su on 16/8/9.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQUpdateUserViewController.h"
#import <AFURLSessionManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#define MainBlueColor  [UIColor colorWithRed:0.529 green:0.765 blue:0.898 alpha:1.000]
@implementation LQUpdateUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    CGFloat screenWidht = self.view.width;
    IsSelectSecretBtn = YES;
    IsSelectManBtn = NO;
    IsSelectWomanBtn = NO;
    IsUploadingPic = NO;
    //恭喜，注册成功
    UILabel *regSuccessLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidht - 200)/2,80, 200, 30)];
    regSuccessLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    regSuccessLabel.text = @"恭喜，注册成功!";
    regSuccessLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:regSuccessLabel];
    //完善资料
    UILabel *completeDataLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenWidht - 200)/2,130, 200, 30)];
    completeDataLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    completeDataLabel.text = @"完善资料";
    completeDataLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:completeDataLabel];
    
    //用户名
    UILabel *userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,200, 80, 30)];
    userNameLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    userNameLabel.text = @"用户名";
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:userNameLabel];
    
    UITextField * userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(100,200, screenWidht-120, 40)];
    userNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    userNameTextField.placeholder = @"请输入用户名";
    userNameTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    userNameTextField.textAlignment = UITextAlignmentLeft;
    userNameTextField.keyboardType = UIKeyboardTypeDefault;
    userNameTextField.delegate = self;
    [self.view addSubview:userNameTextField];
    //头像
    UILabel *headSculptureLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,270, 80, 30)];
    headSculptureLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    headSculptureLabel.text = @"头像";
    headSculptureLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:headSculptureLabel];
    
    UIButton * takePhotoBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(90, 270, (screenWidht -130)/2, 40.0)];
    takePhotoBtn.titleLabel.font              = [UIFont systemFontOfSize:15];
    [takePhotoBtn addTarget:self action:@selector(takePhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [takePhotoBtn setTitle:@"拍照" forState:UIControlStateNormal];
    [takePhotoBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [takePhotoBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:takePhotoBtn];
    
    UIButton * fromPhotoBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(100 + (screenWidht -120)/2, 270, (screenWidht -130)/2, 40.0)];
    fromPhotoBtn.titleLabel.font              = [UIFont systemFontOfSize:15];
    [fromPhotoBtn addTarget:self action:@selector(fromPhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [fromPhotoBtn setTitle:@"本地上传" forState:UIControlStateNormal];
    [fromPhotoBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [fromPhotoBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:fromPhotoBtn];
    
    //性别
    UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,340, 200, 30)];
    sexLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    sexLabel.text = @"性别";
    sexLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:sexLabel];
    
    //Radio按钮保密
    secretBtn = [[UIButton alloc]initWithFrame:CGRectMake(80,340, 20, 20)];
    UIImageView *Radio1ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
    Radio1ImageView.image = [UIImage imageNamed:@"selectRadio.png"];
    [secretBtn addSubview:Radio1ImageView];
    [secretBtn addTarget:self action:@selector(secretBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secretBtn];
    //保密
    UILabel *secretLabel = [[UILabel alloc]initWithFrame:CGRectMake(100,340, 40, 20)];
    secretLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    secretLabel.text = @"保密";
    secretLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:secretLabel];

    //Radio按钮男
    manBtn = [[UIButton alloc]initWithFrame:CGRectMake(145,340, 20, 20)];
    UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
    Radio2ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
    [manBtn addSubview:Radio2ImageView];

    [manBtn addTarget:self action:@selector(manBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manBtn];
    //男
    UILabel *manLabel = [[UILabel alloc]initWithFrame:CGRectMake(165,340, 40, 20)];
    manLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    manLabel.text = @"男";
    manLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:manLabel];
    
    //Radio按钮女
    womanBtn = [[UIButton alloc]initWithFrame:CGRectMake(210,340, 20, 20)];
    UIImageView *Radio3ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
    Radio3ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
    [womanBtn addSubview:Radio3ImageView];
    [womanBtn addTarget:self action:@selector(womanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:womanBtn];
    //女
    UILabel *womanLabel = [[UILabel alloc]initWithFrame:CGRectMake(230,340, 40, 20)];
    womanLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    womanLabel.text = @"女";
    womanLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:womanLabel];
    
    
    //以后再说按钮
    UIButton * noSubmitBtn                    = [[UIButton alloc]initWithFrame:CGRectMake(40, 410, 90, 50.0)];
    noSubmitBtn.titleLabel.font              = [UIFont systemFontOfSize:15];
    [noSubmitBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [noSubmitBtn setTitle:@"以后再说" forState:UIControlStateNormal];
    [noSubmitBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [noSubmitBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:noSubmitBtn];
    //保存资料按钮
    UIButton * submitDataBtn                    = [[UIButton alloc]initWithFrame:CGRectMake((screenWidht - 130), 410, 90, 50.0)];
    submitDataBtn.titleLabel.font              = [UIFont systemFontOfSize:15];
    [submitDataBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [submitDataBtn setTitle:@"保存资料" forState:UIControlStateNormal];
    [submitDataBtn setTitleColor:MainBlueColor forState:UIControlStateNormal];
    [submitDataBtn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:submitDataBtn];
    
    
    //add for select image
    selectImageView = [[UIImageView alloc]init];
    selectImageView.frame = CGRectMake(0, 0, 120, 120);
    //[self.view addSubview:selectImageView];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (IsUploadingPic == YES) {
        NSString *msg = @"上传图片中请稍后.....";
        postImgAlertView = [[UIAlertView alloc] initWithTitle:@"上传图片"
                                                      message:msg
                                                     delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:nil];
        [postImgAlertView show];
        IsUploadingPic = NO;
    }
}

//选择性别保密
-(void)secretBtnClick
{
    NSLog(@"secretBtnClick");
    if(IsSelectSecretBtn == YES)
    {
         //如果已经是选择状态就不应该在
//        IsSelectSecretBtn  = NO;
//        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
//        Radio2ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
//        [secretBtn addSubview:Radio2ImageView];
        
    }
    else
    {
        IsSelectSecretBtn  = YES;
        NSArray *secretBtnSubViewArray = [secretBtn subviews];
        for (UIView *subviews in secretBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
        }

        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"selectRadio.png"];
        [secretBtn addSubview:Radio2ImageView];
        //如果性别报名设置为已选择，其他俩项就应该设置为未选择
   
        IsSelectManBtn = NO;
        NSArray *manBtnSubViewArray = [manBtn subviews];
        for (UIView *subviews in manBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
        }
        UIImageView *Radio3ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio3ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [manBtn addSubview:Radio3ImageView];
        
        IsSelectWomanBtn  = NO;
        NSArray *womanBtnSubViewArray = [womanBtn subviews];
        for (UIView *subviews in womanBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
            
        }
        UIImageView *Radio4ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio4ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [womanBtn addSubview:Radio4ImageView];

    }

}
//选择性别男
-(void)manBtnClick
{
    NSLog(@"secretBtnClick");
    if(IsSelectManBtn == YES)
    {
//        IsSelectManBtn  = NO;
//        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
//        Radio2ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
//        [manBtn addSubview:Radio2ImageView];
    }
    else
    {
        IsSelectManBtn  = YES;
        NSArray *manBtnSubViewArray = [manBtn subviews];
        for (UIView *subviews in manBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
        }
        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"selectRadio.png"];
        [manBtn addSubview:Radio2ImageView];
        //如果性别 男 设置为已选择，
        //保密设置为未选择
        IsSelectSecretBtn  = NO;
        NSArray *secretBtnSubViewArray = [secretBtn subviews];
        for (UIView *subviews in secretBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
            
        }
        UIImageView *Radio3ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio3ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [secretBtn addSubview:Radio3ImageView];
        
        //性别女设置为未选择
        IsSelectWomanBtn  = NO;
        NSArray *womanBtnSubViewArray = [womanBtn subviews];
        for (UIView *subviews in womanBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
            
        }

        UIImageView *Radio4ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio4ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [womanBtn addSubview:Radio4ImageView];

    }
}

//选择性别女
-(void)womanBtnClick
{
    NSLog(@"womanBtnClick");
    if(IsSelectWomanBtn == YES)
    {

    }
    else
    {
        IsSelectWomanBtn  = YES;
        NSArray *womanBtnSubViewArray = [womanBtn subviews];
        for (UIView *subviews in womanBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
            
        }
        UIImageView *Radio2ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio2ImageView.image = [UIImage imageNamed:@"selectRadio.png"];
        [womanBtn addSubview:Radio2ImageView];
        
        //如果性别 女 设置为已选择，其他俩项就应该设置为未选择
        IsSelectSecretBtn  = NO;
        NSArray *secretBtnSubViewArray = [secretBtn subviews];
        for (UIView *subviews in secretBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
            
        }
        UIImageView *Radio3ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio3ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [secretBtn addSubview:Radio3ImageView];
        //manBtn
        IsSelectManBtn  = NO;
        NSArray *manBtnSubViewArray = [manBtn subviews];
        for (UIView *subviews in manBtnSubViewArray) {
            if ([subviews isKindOfClass:[UIImageView class]]) {
                [subviews removeFromSuperview];
            }
            
        }
        UIImageView *Radio4ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 20, 20)];
        Radio4ImageView.image = [UIImage imageNamed:@"unselectRadio.png"];
        [manBtn addSubview:Radio4ImageView];

    }

}
//相机选取照片
-(void)takePhotoBtnClick
{
      NSLog(@"takePhotoBtnClick");
    NSLog(@"fromPhotoBtnClick");
    UIImagePickerController* picker_library_;
    picker_library_ = [[UIImagePickerController alloc] init];
    picker_library_.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker_library_.allowsEditing = YES;
    //picker_camera_.allowsImageEditing=YES;
    picker_library_.delegate = self;
    [self presentModalViewController: picker_library_
                            animated: YES];
}
//本地选取照片
//UIImagePickerControllerSourceTypePhotoLibrary：表示显示所有的照片
//UIImagePickerControllerSourceTypeCamera：表示从摄像头选取照片
//UIImagePickerControllerSourceTypeSavedPhotosAlbum：表示仅仅从相册中选取照片。
-(void)fromPhotoBtnClick
{
    NSLog(@"fromPhotoBtnClick");
    UIImagePickerController* picker_library_;
    picker_library_ = [[UIImagePickerController alloc] init];
    picker_library_.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker_library_.allowsEditing = YES;
    //picker_camera_.allowsImageEditing=YES;
    picker_library_.delegate = self;
    [self presentModalViewController: picker_library_
                            animated: YES];
}

-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,0); //边框线
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        // UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSLog(@"found an image");
      
        selectImageView.image =  [self circleImage:image withParam:1];
        //保存图片
        [self saveImageToPhotos];
        
        
    }
    else if ([mediaType isEqualToString:@"public.movie"]){
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"选择图片提示"
                                                        message:@"选择图片类型不正确"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
     
     
    }
    [picker dismissModalViewControllerAnimated:YES];
  
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
       
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)saveImageToPhotos
{

    NSFileManager *fileMgr = [NSFileManager defaultManager];
 
    
    NSData *imagedata=UIImagePNGRepresentation(selectImageView.image);

    NSArray*paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDirectory=[paths objectAtIndex:0];
    savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"saveFore.png"];
    NSLog(@"saveImageToPhotos path = %@",savedImagePath);
    [imagedata writeToFile:savedImagePath atomically:YES];
    BOOL bRet = [fileMgr fileExistsAtPath:savedImagePath];
    if (bRet) {
     
        [NSThread detachNewThreadSelector:@selector(uploadPictureWithImageData) toTarget:self withObject:nil];
        
    }
}

//http://forum.longquanzs.org//mobcent/app/web/index.php?r=user/uploadavatarex&accessSecret=4aab1523559aeef6bdc16d9a07d93&accessToken=9fefbc43129de83998ccd28f85d92&forumKey=BW0L5ISVRsOTVLCTJx&egnVersion=v2035.2&sdkVersion=2.4.3.0&apphash=a28e368b

//上传图片执行的方法
-(void)uploadPictureWithImageData
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    IsUploadingPic = YES;
    [session POST:@"http://forum.longquanzs.org//mobcent/app/web/index.php?r=useruploadavatarex&accessSecret=4aab1523559aeef6bdc16d9a07d93&accessToken=9fefbc43129de83998ccd28f85d92&forumKey=BW0L5ISVRsOTVLCTJx&egnVersion=v2035.2&sdkVersion=2.4.3.0&apphash=a28e368b" parameters:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSURL *url=[NSURL fileURLWithPath:savedImagePath];
        
        [formData appendPartWithFileURL:url name:@"file" fileName:@"2.jpg" mimeType:@"image/jpeg" error:nil];
        NSError *err;
        [fileMgr removeItemAtPath:savedImagePath error:&err];
        
       
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"progress %f",uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success %@",responseObject);
        [postImgAlertView dismissWithClickedButtonIndex:0 animated:NO];
        NSString * msg = @"图片上传成功";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"failure %@",error.description);
        [postImgAlertView dismissWithClickedButtonIndex:0 animated:NO];
        NSString * msg = @"图片上传失败";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    //删除文件
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSMutableDictionary * dict= [NSMutableDictionary dictionaryWithDictionary:editingInfo];
    
    [dict setObject:image forKey:@"UIImagePickerControllerEditedImage"];
    
    //直接调用3.x的处理函数
    [self imagePickerController:picker didFinishPickingMediaWithInfo:dict];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
    //[picker release];
}
@end

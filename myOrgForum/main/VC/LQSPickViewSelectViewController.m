//
//  LQSPickViewSelectViewController.m
//  myOrgForum
//
//  Created by 宋小宇Mac pro on 16/8/11.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSPickViewSelectViewController.h"
#import "LQSPickerSelectCollectionViewCell.h"

@interface LQSPickViewSelectViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,jmpPictureSelectedVCDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)NSMutableArray *images;
@property (nonatomic, strong)NSMutableArray *cellArray;

@end

@implementation LQSPickViewSelectViewController

static NSString * const reuseIdentifier = @"imgCell";


- (instancetype)init
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat margin = 3;
    CGFloat itemCount = 5;
    
    layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    CGFloat itemW = (LQSScreenW - margin *(itemCount +1))/itemCount;
    CGFloat itemH = itemW;
    
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(itemW, itemH);
    //cell之间的水平间距
    layout.minimumInteritemSpacing = 3 ;
    
    //cell之间的垂直间距
    layout.minimumLineSpacing = 3;
    
    
    return [super initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[LQSPickerSelectCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.backgroundColor = [UIColor blueColor];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LQSPickerSelectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    
    cell.delegate = self;
    
    if (self.images != nil) {
        if (indexPath.item == self.images.count) {
            //cell.deleteBtn.hidden = YES;
        }
        else{
            
            NSLog(@"%ld",indexPath.item);
            NSLog(@"%@",self.images[0]);
            
            UIImage *image = self.images[indexPath.item];
            cell.img = image;
        }
        
    }

    //[self.cellArray addObject:cell];
    
    return cell;
}

#pragma mark - 跳转图片选择控制器
- (void)jmpPictureSelectedVC:(LQSPickerSelectCollectionViewCell *)pictureCell
{
    // 1
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"进入图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
#warning 先获取用户打开相册的权限
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            NSLog(@"没有权限访问相册,请在设置中开启权限");
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        
       // picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        picker.delegate = self;
      
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    
    // 2
    UIAlertAction *paiZAction = [UIAlertAction actionWithTitle:@"打开照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
        else
        {
            NSLog(@"没有权限打开照相机,请在设置中开启");
        }
    }];
    
    
    // 3
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [alertVc addAction:photoAction];
    
    [alertVc addAction:paiZAction];
    
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - cell的协议方法,点击删除按钮时调用
- (void)deletePicture:(LQSPickerSelectCollectionViewCell *)pictureCell
{
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:pictureCell];
    
    NSLog(@"%ld",indexPath.item);
    if (self.images == nil) {
        return;
    }
    [self.images removeObjectAtIndex:indexPath.item];
    
    [self.collectionView reloadData];
}

#pragma mark- 相册的代理方法,点击一张照片时调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.images addObject:image];

//    
//    NSInteger count = self.cellArray.count;
//    
//    LQSPickerSelectCollectionViewCell *cell = self.cellArray[count-1];
//
//    cell.img = image;
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"image" object:nil];
    
    
    
    

}




#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - 懒加载

- (NSMutableArray *)cellArray
{
    if (_cellArray == nil) {
        _cellArray = [NSMutableArray array];
    }
    return _cellArray;
}
- (NSMutableArray *)images
{
    if (_images == nil) {
        NSMutableArray *images = [[NSMutableArray alloc]init];
        _images = images;
    }
    return _images;
}

@end

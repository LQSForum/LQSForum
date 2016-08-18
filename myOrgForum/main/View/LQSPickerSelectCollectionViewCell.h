//
//  LQSPickerSelectCollectionViewCell.h
//  myOrgForum
//
//  Created by 宋小宇Mac pro on 16/8/11.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LQSPickerSelectCollectionViewCell;
@protocol jmpPictureSelectedVCDelegate <NSObject>

- (void)jmpPictureSelectedVC:(LQSPickerSelectCollectionViewCell *)pictureCell;

- (void)deletePicture:(LQSPickerSelectCollectionViewCell *)pictureCell;

@end


@interface LQSPickerSelectCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) UIButton *deleteBtn;

@property(nonatomic,weak)id<jmpPictureSelectedVCDelegate> delegate;

@property(nonatomic,strong)UIImage *img;

+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView andIndexPath:(NSIndexPath *)indexPath;

@end

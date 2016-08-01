//
//  LQSHorizonDataModel.h
//  myOrgForum
//
//  Created by 周双 on 16/7/23.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSHorizonDataModel : NSObject
@property (nonatomic,strong)NSString * rs;
@property (nonatomic,strong)NSString * errcode;
@property (nonatomic,strong)NSArray * head;
@property (nonatomic,strong)NSArray * body;
@property (nonatomic,strong)NSArray * piclist;
@property (nonatomic,strong)NSString * page;
@property (nonatomic,strong)NSString *   has_next;








@end

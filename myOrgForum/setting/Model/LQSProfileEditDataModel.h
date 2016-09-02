//
//  LQSProfileEditDataModel.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/9/1.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSProfileEditDataModel : NSObject
@property (nonatomic, strong) NSString *rs;
@property (nonatomic, strong) NSMutableArray *listModel;


@end

@interface LQSProfileEditDetailDataModel :NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fieldid;
@property (nonatomic, strong) NSString *required;
@property (nonatomic, strong) NSString *unchangeable;
//@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *nowSet;

@end
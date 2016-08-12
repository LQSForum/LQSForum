//
//  LQSLocationModel.h
//  myOrgForum
//
//  Created by 宋小宇Mac pro on 16/8/10.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSLocationModel : NSObject

@property (nonatomic, copy)NSString *uid;
@property (nonatomic, assign)NSInteger *distance;
@property (nonatomic, assign)CGPoint *point;
@property (nonatomic, copy)NSString *addr;
@property (nonatomic, copy)NSString *poiType;
@property (nonatomic, copy)NSString *tag;
@property (nonatomic, copy)NSString *direction;
@property (nonatomic, copy)NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end

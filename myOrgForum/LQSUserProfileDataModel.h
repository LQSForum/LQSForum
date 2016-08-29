//
//  LQSUserProfileDataModel.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/8/29.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LQSUserProfileDetailDataModel

@end


@interface LQSUserProfileDetailDataModel : NSObject
@property (nonatomic, copy) NSString *fieldid;
@property (nonatomic, copy) NSString *required;
@property (nonatomic, copy) NSString *unchangeable;
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, strong) NSString *description;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *nowSet;

@end


@interface LQSUserProfileDataModel : NSObject

@property (nonatomic, strong) NSArray *ProfileArr;

@property (nonatomic, copy) NSMutableArray<LQSUserProfileDetailDataModel> *profiles;

@property (nonatomic, copy) NSString *name;

@end

@protocol LQSUserProfileDataModel

@end

@interface LQSUserResultDataModel : NSObject

@property (nonatomic, copy) NSMutableArray<LQSUserProfileDataModel> *profileResultsArr;





@end



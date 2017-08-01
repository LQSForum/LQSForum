//
//  LQSHttpsRequest.h
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSHttpsRequest : NSObject{
    NSMutableData *_receiveData;
}

@property (assign, nonatomic) BOOL isJsonPara;

- (void )GET:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)( NSError *error))failure;


- (void )POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)( NSError *error))failure;

@end

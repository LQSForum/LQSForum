//
//  LQSCoreManager.h
//  myOrgForum
//
//  Created by SkyAndSea on 16/5/11.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQSCoreManager : NSObject

- (void)HttpsPost:(NSString *)URLStr
           params:(id)params
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure;









@end

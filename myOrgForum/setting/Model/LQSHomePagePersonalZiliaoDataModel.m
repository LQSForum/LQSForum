//
//  LQSHomePagePersonalZiliaoDataModel.m
//  myOrgForum
//
//  Created by 周双 on 16/8/28.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSHomePagePersonalZiliaoDataModel.h"

@implementation LQSHomePagePersonalZiliaoDataModel
- (void)setBody:(NSDictionary *)body{
    _body = body;
    
    self.profileList = [LQSHomePagePersonalZiliaoDetailDataModel mj_objectArrayWithKeyValuesArray:body[@"profileList"]];
    
    self.profileList = [LQSHomePagePersonalZiliaoDetailDataModel mj_objectArrayWithKeyValuesArray:@"creditList"];
    
    self.creditShowList = [LQSHomePagePersonalZiliaoProfileListDataModel mj_objectArrayWithKeyValuesArray:body[@"creditShowList"]];
}

@end

@implementation LQSHomePagePersonalZiliaoDetailDataModel


@end

@implementation LQSHomePagePersonalZiliaoProfileListDataModel



@end
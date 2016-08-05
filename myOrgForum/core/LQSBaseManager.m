//
//  LQSBaseManager.m
//  myOrgForum
//
//  Created by SongKuangshi on 16-8-5.
//  Copyright (c) 2016年 baidu. All rights reserved.
//

#import "LQSBaseManager.h"
#import <objc/runtime.h>
#import "GCDMulticastDelegate.h"

@interface LQSBaseManager () {

}
@property (nonatomic, strong) id observerController;
@end

@implementation LQSBaseManager

+ (instancetype)defaultManager{
    Class selfClass = [self class];
    id manager = objc_getAssociatedObject(selfClass, @"kOTSharedInstance");
    if (!manager){
        manager = [[self alloc] init];
        objc_setAssociatedObject(selfClass, @"kOTSharedInstance", manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return manager;
}

+ (void)destoryDefault {
}

- (id)observerController{
    if (!_observerController){
        _observerController = [[GCDMulticastDelegate alloc] init];
    }
    return _observerController;
}

#pragma mark - Public Method
- (void)setUpWithApphash:(NSString *)appHash{
    self.appHash = appHash;
}

- (void)resetCurrentSecret:(NSString *)secret {
    self.secret = secret;
}

- (void)reloadToken:(NSString *)token{
    self.token = token;
}

#pragma mark - public Method
+ (void)registManagerObserver:(id)observer{
    [[[self defaultManager] observerController] addDelegate:observer delegateQueue:dispatch_get_main_queue()];
}

+ (void)removeManagerObserver:(id)observer{
    [[[self defaultManager] observerController] removeDelegate:observer delegateQueue:dispatch_get_main_queue()];
}

- (void)registManagerObserver:(id)observer{
    [self.observerController addDelegate:observer delegateQueue:dispatch_get_main_queue()];
}

- (void)removeManagerObserver:(id)observer{
    [self.observerController removeDelegate:observer delegateQueue:dispatch_get_main_queue()];
}

@end

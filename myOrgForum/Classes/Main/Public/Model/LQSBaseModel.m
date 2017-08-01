//
//  LQSBaseModel.m
//  myOrgForum
//
//  Created by SongKuangshi on 2016/8/5.
//  Copyright © 2016年 SkyAndSea. All rights reserved.
//

#import "LQSBaseModel.h"
#import <objc/runtime.h>
#import "LQSBaseModel_Private.h"

@implementation LQSBaseModel

- (id)init{
    if (self = [super init]){
        self.ignores = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (NSDictionary *)propertyOfClass:(Class)aclass{
    unsigned int outCount, i;
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    objc_property_t *properties = class_copyPropertyList(aclass, &outCount);
    
    for (i = 0; i<outCount; i++){
        @autoreleasepool {
            objc_property_t property = properties[i];
            const char* char_f =property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            if (![self.ignores containsObject:propertyName]){
                id propertyValue = [self valueForKey:(NSString *)propertyName];
                if (propertyValue){
                    if ([propertyValue isKindOfClass:[NSString class]] || [propertyValue isKindOfClass:[NSNumber class]] || [propertyValue isKindOfClass:[NSArray class]]){
                        [result setObject:propertyValue forKey:propertyName];
                    }else if ([propertyValue isKindOfClass:[NSDictionary class]]){
                        NSData *jsonData =[NSJSONSerialization dataWithJSONObject:propertyValue options:0 error:nil];
                        [result setObject:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] forKey:propertyName];
                    }
                }
            }
        }
    }
    free(properties);
    return result;
}

- (NSMutableDictionary *)dictionary{
    if ([self isKindOfClass:[NSDictionary class]]){
        return (NSMutableDictionary *)self;
    }
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    Class aclass = [self class];
    while (aclass != NSClassFromString(@"NSObject")) {
        [result addEntriesFromDictionary:[self propertyOfClass:aclass]];
        aclass = [aclass superclass];
    }
    return result;
}

+ (instancetype)model:(id)dict{
    if (![dict isKindOfClass:[NSDictionary class]]){
        return nil;
    }
    Class modelClass = [self class];
    LQSBaseModel *result = [[self alloc] init];
    unsigned int outCount = 0;
    
    while (modelClass != NSClassFromString(@"NSObject")) {
        objc_property_t *properties = class_copyPropertyList(modelClass, &outCount);
        for (int i = 0; i<outCount; i++)
        {
            objc_property_t property = properties[i];
            char const *attributes = property_getAttributes(property);
            NSArray *attributeArr = [[NSString stringWithCString:attributes encoding:[NSString defaultCStringEncoding]] componentsSeparatedByString:@","];
            if (![attributeArr containsObject:@"R"]){
                const char* char_f = property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_f];
                if (propertyName){
                    id value = [dict objectForKey:propertyName];
                    if (value && ![value isEqual:[NSNull null]]){
                        [result setValue:[dict objectForKey:propertyName] forKey:propertyName];
                    }
                }
            }
        }
        free(properties);
        
        modelClass = [modelClass superclass];
    }
    return result;
}

+ (instancetype)defaultModel{
    return [[self alloc] init];
}

- (void)reset:(LQSBaseModel *)model{
    NSDictionary *dict = [model dictionary];
    for (NSString *key in dict){
        [self setValue:[dict objectForKey:key] forKey:key];
    }
}

- (void)copyFromModel:(LQSBaseModel *)model{
    NSDictionary *dict = model.dictionary;
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        if (propertyName)
            if ([dict objectForKey:propertyName]){
                [self setValue:[dict objectForKey:propertyName] forKey:propertyName];
            }
    }
    free(properties);
}
@end

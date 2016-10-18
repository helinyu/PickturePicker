//
//  CreateServiceObjectFactory.m
//  PicturePicker
//
//  Created by felix on 2016/10/18.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "CreateServiceObjectFactory.h"

@implementation CreateServiceObjectFactory
{
    NSMutableDictionary *_serviceMap;
}

+ (instancetype)shareInstance {
    static dispatch_once_t once = 0;
    static CreateServiceObjectFactory *factory;
    dispatch_once(&once, ^{
        factory = [CreateServiceObjectFactory new];
    });
    return factory;
}

- (id)serviceWithClass:(Class)aClass {
    BasicService *service = [_serviceMap objectForKey:NSStringFromClass(aClass)];
    if (!service) {
        service = [aClass new];
        [_serviceMap setObject:service forKey:NSStringFromClass(aClass)];
    }
    return service;
}

@end

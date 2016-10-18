//
//  CreateServiceObjectFactory.h
//  PicturePicker
//
//  Created by felix on 2016/10/18.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "BasicService.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define OBTAIN_SERVICE(classname) ((classname *)[[CreateServiceObjectFactory shareInstance] serviceWithClass:classname.class])

@interface CreateServiceObjectFactory : NSObject

- (id)serviceWithClass:(Class)aClass ;
+ (instancetype)shareInstance ;

@end

//所有使用这个方法来进行创建对象的都是必须继承BasicService
#import "ALAssetLibraryService.h"
#import "PictureDatasources.h"

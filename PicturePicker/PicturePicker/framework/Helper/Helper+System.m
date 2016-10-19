//
//  Helper+System.m
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "Helper+System.h"
#import <UIKit/UIKit.h>
#import "sys/utsname.h"

#define GreaterOrEqualToSystem(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version?YES:NO)
#define LowerThanSystem(version) ([[[UIDevice currentDevice] systemVersion] floatValue] < version?YES:NO)

@implementation Helper (System)

+ (NSString *)getDeviceID {
#if TARGET_IPHONE_SIMULATOR
    return @"E3EC295326A9486FB4E835E4020C2783";
#else
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
#endif
}

+ (BOOL)isGreaterOrEqualToIOS10{
    return GreaterOrEqualToSystem(10.0);
}
+ (BOOL)isGreaterOrEqualToIOS9{
    return GreaterOrEqualToSystem(9.0);
}

+ (BOOL)isGreaterOrEqualToIOS8{
    return GreaterOrEqualToSystem(8.0);
}

+ (BOOL)islowerThanIOS10{
    return LowerThanSystem(10.0);
}
+ (BOOL)islowerThanIOS9{
    return LowerThanSystem(9.0);
}
+ (BOOL)islowerThanIOS8{
    return LowerThanSystem(8.0);
}

@end

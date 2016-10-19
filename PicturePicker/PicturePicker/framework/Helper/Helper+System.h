//
//  Helper+System.h
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "Helper.h"

//#define LowerThanIOS10 +(BOOL)isGreaterOrEqualToIOS8{return GreaterOrEqualToSystem(8.0);}

@interface Helper (System)

+ (NSString *)getDeviceID;

+ (BOOL)isGreaterOrEqualToIOS10;
+ (BOOL)isGreaterOrEqualToIOS9;
+ (BOOL)isGreaterOrEqualToIOS8;

+ (BOOL)islowerThanIOS10;
+ (BOOL)islowerThanIOS9;
+ (BOOL)islowerThanIOS8;

@end

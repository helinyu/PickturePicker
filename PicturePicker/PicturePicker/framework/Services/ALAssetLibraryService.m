//
//  DisplayPictureService.m
//  PicturePicker
//
//  Created by felix on 2016/10/18.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "ALAssetLibraryService.h"
/*
 1、这里应该是有相应的图片获取（分为全部图片获取、指定相册进行获取）
 2、获取的内容应该是如何进行展示？？？？、
 ps:总体来说，相册里面的信息进行自定义展示；
 
 */

@implementation ALAssetLibraryService

- (ALAssetsLibrary *)defaultALAssetLibrary {
    static dispatch_once_t once = 0;
    static ALAssetsLibrary * assetsLibrary;
    dispatch_once(&once, ^{
        assetsLibrary = [ALAssetsLibrary new];
    });
    return assetsLibrary;
}

@end

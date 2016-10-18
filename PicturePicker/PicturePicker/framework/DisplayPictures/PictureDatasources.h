//
//  PictureDatasources.h
//  PicturePicker
//
//  Created by felix on 2016/10/18.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "CreateServiceObjectFactory.h"

@interface PictureDatasources : NSObject

typedef void (^ALAssetsGroupResultsBlock)(ALAssetsGroup *result); //group result block
typedef void (^ALAssetsResultsBlock)(ALAsset *result); // alasset result block

//获取相册中的图片组
+ (void)requestAllPhotoFromAlbumWithALAssetsGroup:(ALAssetsGroupResultsBlock)resultBlock;


@end

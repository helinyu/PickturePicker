//
//  PictureDatasources.m
//  PicturePicker
//
//  Created by felix on 2016/10/18.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PictureDatasources.h"

@implementation PictureDatasources


+ (void)requestAllPhotoFromAlbumWithALAssetsGroup:(ALAssetsGroupResultsBlock)resultBlock {
    
    [[OBTAIN_SERVICE(ALAssetLibraryService) defaultALAssetLibrary] enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        resultBlock(group);
        
    } failureBlock:^(NSError *error) {
        resultBlock(nil);
    }];
}

+ (void)requestAllPhotoFromAlbumWithALAssets:(ALAssetsResultsBlock)resultBlock {
    
}

@end

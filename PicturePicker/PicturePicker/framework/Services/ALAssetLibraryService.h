//
//  DisplayPictureService.h
//  PicturePicker
//
//  Created by felix on 2016/10/18.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "BasicService.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAssetLibraryService : BasicService

- (ALAssetsLibrary *)defaultALAssetLibrary;

@end

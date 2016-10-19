//
//  DisplayPictures.h
//  PicturePicker
//
//  Created by felix on 2016/10/17.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayPicturesCell.h"

@interface DisplayPictures : UIViewController<UICollectionViewDataSourcePrefetching,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
    
typedef void (^ALAssetsGroupBlock)(ALAssetsGroup *result);
typedef void (^ALAssetsBlock)(ALAsset *result);
typedef void (^ArrayALAssetsBlock)(NSMutableArray<ALAsset*>* result);

- (void)showPhotoLibraryPhtosFrom:(UIViewController*)fromController Complete:(ArrayALAssetsBlock)callback;

@end

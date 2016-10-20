//
//  PreviewPictures.h
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PreviewPictures : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDataSourcePrefetching,UICollectionViewDelegateFlowLayout>

- (void)passValueToDatasource:(NSArray<ALAsset*> *)datasource ;
- (void)passValueToGroupDatasource:(ALAssetsGroup *)datasource ;
- (void)passValueToDatasource:(NSArray<ALAsset*> *)assests withGroupDataSource:(ALAssetsGroup *)assetsGroup;

@end

@interface PreviewPictureCell : UICollectionViewCell
    

@end

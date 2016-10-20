//
//  PreviewPictures.m
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PreviewPictures.h"

@interface PreviewPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation PreviewPictureCell

@end

@interface PreviewPictures ()
{
    NSArray<ALAsset *>* _datasources;
    ALAssetsGroup * _assetsGroup;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation PreviewPictures

- (void)passValueToDatasource:(NSMutableArray<ALAsset*> *)datasource {
    [_datasources arrayByAddingObjectsFromArray:datasource];
}

- (void)passValueToGroupDatasource:(ALAssetsGroup *)datasource {
    _assetsGroup = datasource;
}

- (void)passValueToDatasource:(NSMutableArray<ALAsset*> *)assests withGroupDataSource:(ALAssetsGroup *)assetsGroup{
    [self passValueToGroupDatasource:assetsGroup];
    [self passValueToDatasource:assests];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initVariables];

}

- (void) initVariables {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- uicollectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _datasources.count;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PreviewPictureCell *pictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PreviewPictureCell class]) forIndexPath:indexPath];
    pictureCell.imageView.image = [UIImage imageWithCGImage:_datasources[indexPath.row].thumbnail];
    
    return pictureCell;
}

#pragma mark -- uicollecitonViewDelegateLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.collectionView.frame.size;
}

@end

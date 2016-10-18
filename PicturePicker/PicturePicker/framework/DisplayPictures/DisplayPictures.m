//
//  DisplayPictures.m
//  PicturePicker
//
//  Created by felix on 2016/10/17.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "DisplayPictures.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "PictureDatasources.h"

#define String(CellCalssName) NSStringFromClass([CellCalssName class])
#define DISPLAYPICTURECELL_STRING String(DisplayPicturesCell)

#pragma mark -- define cell minute space and number of row
#define CELL_MIN_SPACING_FOR_CELL 5
#define CELL_MIN_SPACING_FOR_LINE 5
#define CELL_NUMBER_PER_ROW 5

@interface DisplayPictures ()
{
    NSMutableArray<ALAsset*> *_pictureSources;
}
@property (weak, nonatomic) IBOutlet UICollectionView *displayCollectionView;

typedef void (^ALAssetsGroupBlock)(ALAssetsGroup *result);

@end

@implementation DisplayPictures

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureNomalVariables];
    [self configureVariableOfCollectionViewCellAtInitState];
    [self configureDataSourceAtInitState];
}

- (void)configureVariableOfCollectionViewCellAtInitState {
    [self.displayCollectionView registerNib:[UINib nibWithNibName:DISPLAYPICTURECELL_STRING bundle:nil] forCellWithReuseIdentifier:DISPLAYPICTURECELL_STRING];
    self.displayCollectionView.prefetchingEnabled = true;
    self.automaticallyAdjustsScrollViewInsets = false;
}

- (void)configureNomalVariables {
    _pictureSources = [NSMutableArray<ALAsset*> new];
}


- (void)configureDataSourceAtInitState {
    [PictureDatasources requestAllPhotoFromAlbumWithALAssetsGroup:^(ALAssetsGroup *result) {
        NSLog(@"group is : %@",result);
//        NSUInteger resultCount = [result numberOfAssets];
        [result enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if ( result == nil || index == NSIntegerMax || index == NSUIntegerMax ) {
                [self.displayCollectionView reloadData];
                return ;
            }
            [_pictureSources addObject:result];
        }];
    }];
}

#pragma mark -- collection Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _pictureSources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DisplayPicturesCell *picturesCell = [collectionView dequeueReusableCellWithReuseIdentifier:DISPLAYPICTURECELL_STRING forIndexPath:indexPath];
    picturesCell.backgroundColor = [UIColor blueColor];
    picturesCell.pictureImageView.image = [UIImage imageNamed:@"icon_common_picker_correct"];
    picturesCell.pictureImageView.image = [UIImage imageWithCGImage:_pictureSources[indexPath.row].thumbnail];
//    _pictureSources[indexPath.row] ;
    return picturesCell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake( (([UIScreen mainScreen].bounds.size.width + CELL_MIN_SPACING_FOR_CELL) / CELL_NUMBER_PER_ROW) - CELL_MIN_SPACING_FOR_CELL, (([UIScreen mainScreen].bounds.size.width + CELL_MIN_SPACING_FOR_CELL) / CELL_NUMBER_PER_ROW) - CELL_MIN_SPACING_FOR_CELL);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return CELL_MIN_SPACING_FOR_LINE;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return CELL_MIN_SPACING_FOR_CELL;
}

#pragma mark -- UICollectionViewDataSourcePrefetching

- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths NS_AVAILABLE_IOS(10_0) {
    NSLog(@"prefetchItemsAtIndexPaths");
}

- (void)collectionView:(UICollectionView *)collectionView cancelPrefetchingForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths  NS_AVAILABLE_IOS(10_0) {
    NSLog(@"cancelPrefetchingForItemsAtIndexPaths");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

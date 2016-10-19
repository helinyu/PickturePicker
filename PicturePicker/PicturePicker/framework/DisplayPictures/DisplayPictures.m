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
#import "Helper+System.h"
#import "FrameworkDefinition.h"

#define String(CellCalssName) NSStringFromClass([CellCalssName class])
#define DISPLAYPICTURECELL_STRING String(DisplayPicturesCell)
#define TAKEPICTURECELL_STRING String(TakePictureCell)

#pragma mark -- define cell minute space and number of row
#define CELL_MIN_SPACING_FOR_CELL 5
#define CELL_MIN_SPACING_FOR_LINE 5
#define CELL_NUMBER_PER_ROW 5

//cell 最小也得50
#define CELL_MIN_WIDTH_LENGTH 50

#define NUMBER_OF_TAKEPICTURECELL 1

@interface DisplayPictures ()<DisplayPicturesCellSelectedDataSource>
{
    NSMutableArray<ALAsset*> *_pictureSources;
     BOOL _hasSelected;
    NSMutableArray * _selectIndeses;
    
    PicturesDisplayStyle _picturesDisplayStyle;
}
@property (weak, nonatomic) IBOutlet UICollectionView *displayCollectionView;

@property (nonatomic) ArrayALAssetsBlock  datasoucesCallback;
    
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
    [self.displayCollectionView registerNib:[UINib nibWithNibName:TAKEPICTURECELL_STRING bundle:nil] forCellWithReuseIdentifier:TAKEPICTURECELL_STRING];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    if ([Helper isGreaterOrEqualToIOS10]) {
        self.displayCollectionView.prefetchDataSource = self;
        self.displayCollectionView.prefetchingEnabled = true;
    }

}

- (void)configureNomalVariables {
    _pictureSources = [NSMutableArray<ALAsset*> new];
    _selectIndeses = [NSMutableArray new];
    
    if (self.navigationController) {
        UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithTitle:pictures_finishedChoice_text style:UIBarButtonItemStylePlain target:self action:@selector(pictureChiceHasFinished:)];
        self.navigationItem.rightBarButtonItem = rightBtnItem;
    }
    
    if (_numberOfcolumn <= 0) {
        _numberOfcolumn = CELL_NUMBER_PER_ROW;
    }

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
    
#pragma mark -- UIbarButton
- (void)pictureChiceHasFinished:(UIBarButtonItem *)btnItem {
    NSLog(@"完成选择");

    [self.navigationController popViewControllerAnimated:true];
    
    NSMutableArray<ALAsset*>* datasource = [NSMutableArray<ALAsset*> new];
    for ( NSInteger index =0 ;index <_selectIndeses.count; index++ ) {
        NSInteger sourceIndex = [_selectIndeses[index] integerValue];
        [datasource addObject:_pictureSources[sourceIndex]];
    }
    _datasoucesCallback(datasource);

}

#pragma mark -- collection Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (_picturesDisplayStyle) {
        case PicturesDisplayStyleOutSide:
        case PicturesDisplayStyleDefaultOrNot:
        return _pictureSources.count;
        break;
        case PicturesDisplayStyleFirstOfInside:
        case PicturesDisplayStyleBottomOfInside:
        return _pictureSources.count + NUMBER_OF_TAKEPICTURECELL;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DisplayPicturesCell *picturesCell = [collectionView dequeueReusableCellWithReuseIdentifier:DISPLAYPICTURECELL_STRING forIndexPath:indexPath];
    
    for (NSInteger index = 0; index < _selectIndeses.count; index++) {
        if ([_selectIndeses[index] isEqual:@(indexPath.row)]) {
            _hasSelected = true;
            break;
        }
    }
    
    switch (_picturesDisplayStyle) {
        case PicturesDisplayStyleDefaultOrNot:
        case PicturesDisplayStyleOutSide:
        {
            [picturesCell configureCellWithDataSource:_pictureSources[indexPath.row] andSelectedOrNot:_hasSelected withSelectedIndex:indexPath.row];
            _hasSelected = false;
            picturesCell.selectedDataSource = self;
            return picturesCell;
        }
        break;
        case PicturesDisplayStyleBottomOfInside:
        {
            if (indexPath.row == _pictureSources.count) {
                TakePictureCell *takePicturesCell = [collectionView dequeueReusableCellWithReuseIdentifier:TAKEPICTURECELL_STRING forIndexPath:indexPath];
                return takePicturesCell;
            }
            
            [picturesCell configureCellWithDataSource:_pictureSources[indexPath.row] andSelectedOrNot:_hasSelected withSelectedIndex:indexPath.row];
            _hasSelected = false;
            picturesCell.selectedDataSource = self;
            return picturesCell;

        }
        break;
        case PicturesDisplayStyleFirstOfInside:
        {
            if (indexPath.row == 0) {
                TakePictureCell *takePicturesCell = [collectionView dequeueReusableCellWithReuseIdentifier:TAKEPICTURECELL_STRING forIndexPath:indexPath];
                return takePicturesCell;
            }

            [picturesCell configureCellWithDataSource:_pictureSources[indexPath.row-NUMBER_OF_TAKEPICTURECELL] andSelectedOrNot:_hasSelected withSelectedIndex:indexPath.row];
            _hasSelected = false;
            picturesCell.selectedDataSource = self;
            return picturesCell;

        }
        break;
    }
}

#pragma mark -- selectedDatasource

- (BOOL)updateSelectedPictureWithIndex:(NSInteger)index withSelectedOrNot:(BOOL)selected{
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    _hasSelected = true;
    [_selectIndeses addObject:@(index)];
    [self.displayCollectionView reloadItemsAtIndexPaths:@[selectIndexPath]];
    return true;
}
    
#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cell_size_length = (([UIScreen mainScreen].bounds.size.width + CELL_MIN_SPACING_FOR_CELL) / _numberOfcolumn) - CELL_MIN_SPACING_FOR_CELL;
    if (cell_size_length < CELL_MIN_WIDTH_LENGTH) {
        return CGSizeMake(CELL_MIN_WIDTH_LENGTH,CELL_MIN_WIDTH_LENGTH);
    }
    return CGSizeMake(cell_size_length,cell_size_length);
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

- (void)showPhotoLibraryPhtosFrom:(UIViewController*)fromController Complete:(ArrayALAssetsBlock)callback {
    if (fromController.navigationController) {
        [fromController.navigationController pushViewController:self animated:true];
    }
    _datasoucesCallback = callback;
}
    
- (void)showPhotoLibraryPhtosFrom:(UIViewController*)fromController withPicturesDisplayStyle:(PicturesDisplayStyle)style Complete:(ArrayALAssetsBlock)callback {
       [self showPhotoLibraryPhtosFrom:fromController Complete:callback];
    _picturesDisplayStyle = style;
}

- (void)showPhotoLibraryPhtosFrom:(UIViewController*)fromController withPicturesDisplayStyle:(PicturesDisplayStyle)style withColumnsPerRow:(NSInteger)columnsPerRow Complete:(ArrayALAssetsBlock)callback {
    [self showPhotoLibraryPhtosFrom:fromController withPicturesDisplayStyle:style Complete:callback];
    _numberOfcolumn = columnsPerRow;
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

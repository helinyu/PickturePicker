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
#import "PreviewPictures.h"

#define choiceNumberAndAllRatio_DisplayOnTitle self.navigationItem.title = [NSString stringWithFormat:@"%lu/%d",(unsigned long)_selectIndeses.count,_numberOfAsset];


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

@interface DisplayPictures ()<DisplayPicturesCellSelectedDataSource,DisplayPicturesCellSelectedDelegate>
{
    NSMutableArray<ALAsset*> *_pictureSources;
    ALAssetsGroup *_picturesALGroupSources;
    NSInteger _numberOfAsset;
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
    [self initUIkitVariable];
    [self configureDataSourceAtInitState];
}

- (void)initUIkitVariable {
    
    [self.displayCollectionView registerNib:[UINib nibWithNibName:DISPLAYPICTURECELL_STRING bundle:nil] forCellWithReuseIdentifier:DISPLAYPICTURECELL_STRING];
    [self.displayCollectionView registerNib:[UINib nibWithNibName:TAKEPICTURECELL_STRING bundle:nil] forCellWithReuseIdentifier:TAKEPICTURECELL_STRING];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    if ([Helper isGreaterOrEqualToIOS10]) {
        self.displayCollectionView.prefetchDataSource = self;
        self.displayCollectionView.prefetchingEnabled = true;
    }
    
    if (self.navigationController) {
        UIBarButtonItem *lastSecondRightBtnItem = [[UIBarButtonItem alloc] initWithTitle:pictures_preview_text style:UIBarButtonItemStylePlain target:self action:@selector(onPicturePreview:)];
        lastSecondRightBtnItem.tintColor = [UIColor blueColor];
        UIBarButtonItem *lastRightBtnItem = [[UIBarButtonItem alloc] initWithTitle:pictures_finishedChoice_text style:UIBarButtonItemStylePlain target:self action:@selector(pictureChoiceHasFinished:)];
        lastRightBtnItem.tintColor = [UIColor redColor];
        self.navigationItem.rightBarButtonItems = @[lastRightBtnItem,lastSecondRightBtnItem];;
        
        UIBarButtonItem *backLeftBarItem = [[UIBarButtonItem alloc] initWithTitle:back_navitaion_text style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        backLeftBarItem.tintColor = [UIColor grayColor];
        UIBarButtonItem *leftLastSecondItem = [[UIBarButtonItem alloc] initWithTitle:preview_all_text style:UIBarButtonItemStylePlain target:self action:@selector(previewAllPictures:)];
        leftLastSecondItem.tintColor = [UIColor blueColor];
        self.navigationItem.leftBarButtonItems = @[backLeftBarItem,leftLastSecondItem];
    }

}

- (void)configureNomalVariables {
    _pictureSources = [NSMutableArray<ALAsset*> new];
    _selectIndeses = [NSMutableArray new];
    
    
    if (_numberOfcolumn <= 0) {
        _numberOfcolumn = CELL_NUMBER_PER_ROW;
    }

}

- (void)configureDataSourceAtInitState {
    [PictureDatasources requestAllPhotoFromAlbumWithALAssetsGroup:^(ALAssetsGroup *resultOfGroup) {
        NSLog(@"group is : %@",resultOfGroup);
        _picturesALGroupSources = [ALAssetsGroup new];
        _picturesALGroupSources = resultOfGroup;
        [resultOfGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if ( result == nil || index == NSIntegerMax || index == NSUIntegerMax ) {
                [self.displayCollectionView reloadData];
                return ;
            }
            [_pictureSources addObject:result];
            _numberOfAsset = resultOfGroup.numberOfAssets;

            choiceNumberAndAllRatio_DisplayOnTitle

        }];
    }];
}
    
#pragma mark -- UIbarButton
    
- (void)onPicturePreview:(UIBarButtonItem *) btnItem {
    NSLog(@"预览选择的图片");
}
    
- (void)pictureChoiceHasFinished:(UIBarButtonItem *)btnItem {
    NSLog(@"完成选择");

    [self.navigationController popViewControllerAnimated:true];
    
    NSMutableArray<ALAsset*>* datasource = [NSMutableArray<ALAsset*> new];
    for ( NSInteger index =0 ;index <_selectIndeses.count; index++ ) {
        NSInteger sourceIndex = [_selectIndeses[index] integerValue];
        [datasource addObject:_pictureSources[sourceIndex]];
    }
    _datasoucesCallback(datasource);

}

- (void)goBack {
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)previewAllPictures:(UIBarButtonItem *) btnItem {
    NSLog(@"preview all pictures");
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
    
    BOOL hasSelected = false;
    
    for (NSInteger index = 0; index < _selectIndeses.count; index++) {
        if ([_selectIndeses[index] isEqual:@(indexPath.row)]) {
            hasSelected = true;
            break;
        }
    }
    
    switch (_picturesDisplayStyle) {
        case PicturesDisplayStyleDefaultOrNot:
        case PicturesDisplayStyleOutSide:
        {
            [picturesCell configureCellWithDataSource:_pictureSources[indexPath.row] andSelectedOrNot:hasSelected withSelectedIndex:indexPath.row];
            hasSelected = false;
            picturesCell.selectedDataSource = self;
            picturesCell.selectedPictureDelegate = self;
            return picturesCell;
        }
        break;
        case PicturesDisplayStyleBottomOfInside:
        {
            if (indexPath.row == _pictureSources.count) {
                TakePictureCell *takePicturesCell = [collectionView dequeueReusableCellWithReuseIdentifier:TAKEPICTURECELL_STRING forIndexPath:indexPath];
                return takePicturesCell;
            }
            
            [picturesCell configureCellWithDataSource:_pictureSources[indexPath.row] andSelectedOrNot:hasSelected withSelectedIndex:indexPath.row];
            picturesCell.selectedDataSource = self;
            picturesCell.selectedPictureDelegate = self;
            return picturesCell;

        }
        break;
        case PicturesDisplayStyleFirstOfInside:
        {
            if (indexPath.row == 0) {
                TakePictureCell *takePicturesCell = [collectionView dequeueReusableCellWithReuseIdentifier:TAKEPICTURECELL_STRING forIndexPath:indexPath];
                return takePicturesCell;
            }

            [picturesCell configureCellWithDataSource:_pictureSources[indexPath.row-NUMBER_OF_TAKEPICTURECELL] andSelectedOrNot:hasSelected withSelectedIndex:indexPath.row];
            picturesCell.selectedDataSource = self;
            picturesCell.selectedPictureDelegate = self;
            return picturesCell;

        }
        break;
    }
}

#pragma mark -- selectedDatasource

- (BOOL)updateSelectedPictureWithIndex:(NSInteger)index withSelectedOrNot:(BOOL)selected{
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if (selected) {
        [_selectIndeses addObject:@(index)];
    }else{
        for (NSInteger inlineIndex = 0; inlineIndex < _selectIndeses.count; inlineIndex++ ) {
            if ([_selectIndeses[inlineIndex] isEqual:@(index)]) {
                [_selectIndeses removeObjectAtIndex:inlineIndex];
                break;
            }
        }
    }
    [self.displayCollectionView reloadItemsAtIndexPaths:@[selectIndexPath]];
    choiceNumberAndAllRatio_DisplayOnTitle
    return true;
}

#pragma mark -- selectedPicturesDelegate

- (BOOL)previewPictureAtIndex:(NSInteger)index {
    NSLog(@"index: %d",index);
    
    PreviewPictures *previewPictures = [[UIStoryboard storyboardWithName:PictureStoryName bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([PreviewPictures class])];
    [previewPictures passValueToDatasource:_pictureSources];
    [previewPictures passValueToGroupDatasource:_picturesALGroupSources];
    
    if (self.navigationController) {
        [self.navigationController pushViewController:previewPictures animated:true];
    }else{
        [self presentViewController:previewPictures animated:true completion:nil];
    }
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

#pragma mark -- for outside method
    
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

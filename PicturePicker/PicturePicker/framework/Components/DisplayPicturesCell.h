//
//  DisplayPicturesCell.h
//  PicturePicker
//
//  Created by felix on 2016/10/17.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include <AssetsLibrary/AssetsLibrary.h>

@protocol DisplayPicturesCellSelectedDataSource <NSObject>

- (BOOL)updateSelectedPictureWithIndex:(NSInteger)index withSelectedOrNot:(BOOL)selected;

@end

@protocol DisplayPicturesCellSelectedDelegate <NSObject>
@optional
- (BOOL)previewPictureAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)previewPictureAtIndex:(NSInteger)index;

@end

@interface DisplayPicturesCell : UICollectionViewCell
    
- (void)configureCellWithDataSource:(ALAsset*)asset andSelectedOrNot:(BOOL)selected withSelectedIndex:(NSInteger)selectedIndex;
    
@property (weak, nonatomic) IBOutlet UIButton *choiceBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
    
@property (weak, nonatomic) id<DisplayPicturesCellSelectedDataSource> selectedDataSource;

@property (weak, nonatomic) id<DisplayPicturesCellSelectedDelegate> selectedPictureDelegate;

@end

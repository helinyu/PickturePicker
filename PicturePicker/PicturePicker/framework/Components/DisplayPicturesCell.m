//
//  DisplayPicturesCell.m
//  PicturePicker
//
//  Created by felix on 2016/10/17.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "DisplayPicturesCell.h"

@interface DisplayPicturesCell ()
    
@property (assign, nonatomic) NSInteger row;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSMutableArray * pictureSelectedIndeses;
    
@end

@implementation DisplayPicturesCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
    
- (void)configureCellWithDataSource:(ALAsset*)asset andSelectedOrNot:(BOOL)selected withSelectedIndex:(NSInteger)selectedIndex {

    self.pictureImageView.image = [UIImage imageWithCGImage:asset.thumbnail];
    self.choiceBtn.selected = selected;
    self.choiceBtn.tag = selectedIndex;
}

- (IBAction)onChooseClicked:(id)sender {

    if ([self.selectedDataSource respondsToSelector:@selector(updateSelectedPictureWithIndex:withSelectedOrNot:)]) {
        [self.selectedDataSource updateSelectedPictureWithIndex:self.choiceBtn.tag withSelectedOrNot:!self.choiceBtn.selected];
    }else{
        NSLog(@"you need to implement this dataSource protocol method!!!");
    }
    
}

- (IBAction)onPreviewPictureHaschoicedClicked:(id)sender {

    NSLog(@"预览所有的图片");
    [self.selectedPictureDelegate previewPictureAtIndex:self.choiceBtn.tag];

}


@end

//
//  TakePictureCell.h
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TakePictureCellController  <NSObject>

- (void)onPicturesTake;

@end

@interface TakePictureCell : UICollectionViewCell

@property (weak,nonatomic) id<TakePictureCellController> picturesTakeController;
    
@end

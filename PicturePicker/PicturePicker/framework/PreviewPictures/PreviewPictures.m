//
//  PreviewPictures.m
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "PreviewPictures.h"

@interface PreviewPictureCell ()
    
@end

@implementation PreviewPictureCell

@end

@interface PreviewPictures ()

@end

@implementation PreviewPictures

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    
    
#pragma mark -- uicollectionView datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PreviewPictureCell *pictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PreviewPictureCell class]) forIndexPath:indexPath];
    
    return pictureCell;
}

@end

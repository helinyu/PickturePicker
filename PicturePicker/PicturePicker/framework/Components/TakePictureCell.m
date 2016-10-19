//
//  TakePictureCell.m
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "TakePictureCell.h"

@interface TakePictureCell ()

@end

@implementation TakePictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)onPicturesTakeClicked:(id)sender {
    NSLog(@"拍照");
    
    if ([self.picturesTakeController respondsToSelector:@selector(onPicturesTake)]) {
        [self.picturesTakeController onPicturesTake];
    }
    
}
    
@end

//
//  PicturesDisplayStyleService.h
//  PicturePicker
//
//  Created by felix on 2016/10/19.
//  Copyright © 2016年 felix. All rights reserved.
//

#import "BasicService.h"

typedef NS_ENUM(NSInteger, PicturesDisplayStyle) {
    PicturesDisplayStyleDefaultOrNot   = 0, //默认或者没有
    PicturesDisplayStyleOutSide        = 1, //在外面
    PicturesDisplayStyleFirstOfInside  = 2, //在里面首位
    PicturesDisplayStyleBottomOfInside = 3, //在里面末位
};


@interface PicturesDisplayStyleService : BasicService

@end

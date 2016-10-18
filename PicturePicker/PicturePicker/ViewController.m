//
//  ViewController.m
//  PicturePicker
//
//  Created by felix on 2016/10/17.
//  Copyright © 2016年 felix. All rights reserved.

#import "ViewController.h"
#import "DisplayPictures.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onDisplayPhotoLibraryClicked:(id)sender {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Picture" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DisplayPictures class])] animated:true];
}

@end

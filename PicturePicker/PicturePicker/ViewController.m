//
//  ViewController.m
//  PicturePicker
//
//  Created by felix on 2016/10/17.
//  Copyright © 2016年 felix. All rights reserved.

#import "ViewController.h"
#import "DisplayPictures.h"
#import "PicturesDisplayStyleService.h"

@interface ViewController ()
{
    PicturesDisplayStyle _displayStyle;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeCondition;
    @property (weak, nonatomic) IBOutlet UILabel *NumberOfColumns;
    @property (weak, nonatomic) IBOutlet UITextField *inputTextfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVariables];
    
}

- (void)initVariables {
    _displayStyle = PicturesDisplayStyleDefaultOrNot;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
 显示全部的图片
 */
- (IBAction)onDisplayPhotoLibraryClicked:(id)sender {
    
    DisplayPictures * dpViewController = [[UIStoryboard storyboardWithName:@"Picture" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([DisplayPictures class])];
    dpViewController.numberOfcolumn = [self.inputTextfield.text integerValue];
    [dpViewController showPhotoLibraryPhtosFrom:self withPicturesDisplayStyle:_displayStyle Complete:^(NSMutableArray<ALAsset *> *result) {
        NSLog(@"alasset is : %@",result);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.inputTextfield respondsToSelector:@selector(resignFirstResponder)]) {
                [self.inputTextfield resignFirstResponder];
            }
        });
   }];
    
 }
    
- (IBAction)onChangeDisPlayCellConditionClicked:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    NSLog(@"index is : %d",segmentedControl.selectedSegmentIndex);
    _displayStyle = segmentedControl.selectedSegmentIndex;
}


@end

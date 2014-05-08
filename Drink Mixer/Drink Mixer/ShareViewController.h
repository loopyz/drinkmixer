//
//  ShareViewController.h
//  Drink Mixer
//
//  Created by Angela Zhang on 5/4/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UITextField *nameField;

@property (strong, nonatomic) UITextField *ingredient1;
@property (strong, nonatomic) UITextField *ingredient2;
@property (strong, nonatomic) UITextField *ingredient3;
@property (strong, nonatomic) UITextField *ingredient4;
@property (strong, nonatomic) UITextField *ingredient5;
@property (strong, nonatomic) UITextField *ingredient6;

@property (strong, nonatomic) UITextField *amt1;
@property (strong, nonatomic) UITextField *amt2;
@property (strong, nonatomic) UITextField *amt3;
@property (strong, nonatomic) UITextField *amt4;
@property (strong, nonatomic) UITextField *amt5;
@property (strong, nonatomic) UITextField *amt6;

@end

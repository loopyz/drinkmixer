//
//  ShareViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/4/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "ShareViewController.h"
#import "CategoryViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import "NSStrinAdditions.h" // For storing images in Firebase

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

@interface ShareViewController ()  <UITextFieldDelegate>
{
    BOOL mediaPicked;
    UIImage *img;
    NSString *category;
}
@end

@implementation ShareViewController
@synthesize nameField, ingredient1, ingredient2, ingredient3, ingredient4, ingredient5, ingredient6;
@synthesize amt1, amt2, amt3, amt4, amt5, amt6;
@synthesize pickerView, dataArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeNavBar];
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        
        [self initializeCameraButton];
        
        [self initTextFields];
        [self initializeNameField];
        [self initializeIngredientFields];
        
        [self initializeAddButton];

        category = @"Juice"; // Default value
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initTextFields
{
    self.nameField = [[UITextField alloc] init];
    self.ingredient1 = [[UITextField alloc] init];
    self.ingredient2 = [[UITextField alloc] init];
    self.ingredient3 = [[UITextField alloc] init];
    self.ingredient4 = [[UITextField alloc] init];
    self.ingredient5 = [[UITextField alloc] init];
    self.ingredient6 = [[UITextField alloc] init];
    
    self.amt1 = [[UITextField alloc] init];
    self.amt2 = [[UITextField alloc] init];
    self.amt3 = [[UITextField alloc] init];
    self.amt4 = [[UITextField alloc] init];
    self.amt5 = [[UITextField alloc] init];
    self.amt6 = [[UITextField alloc] init];
    
    self.nameField.alpha = 0.0;
}

- (void)initializeIngredientFields
{
    int ingredientFieldWidth = 200;
    int yOffset = 30;
    int margin = 20;
    int count = 0;
    int topMargin = 90;
    
    self.ingredient1.frame = CGRectMake(yOffset, SCREEN_HEIGHT/2-topMargin + count * margin, ingredientFieldWidth, 30);
    self.ingredient1.backgroundColor = [UIColor whiteColor];
    self.ingredient1.textColor = [UIColor blackColor];
    self.ingredient1.text = @"";
    [self.ingredient1 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    self.ingredient1.autocorrectionType = UITextAutocorrectionTypeNo;
    self.ingredient1.keyboardType = UIKeyboardTypeDefault;
    self.ingredient1.returnKeyType = UIReturnKeyDone;
    self.ingredient1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ingredient1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ingredient1.borderStyle = UITextBorderStyleNone;
    self.ingredient1.delegate = self;
    self.ingredient1.placeholder = @" Ingredient #1";
    
    [self.view addSubview:self.ingredient1];
    
    //draw line for ingred & amount
    UIView *ingredient1Line = [[UIView alloc] initWithFrame:CGRectMake(yOffset, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 160, 1)];
    ingredient1Line.backgroundColor = [UIColor grayColor];
    ingredient1Line.alpha = .5;
    [self.view addSubview:ingredient1Line];
    
    UIView *amtLine1 = [[UIView alloc] initWithFrame:CGRectMake(yOffset + 220, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 30, 1)];
    amtLine1.backgroundColor = [UIColor grayColor];
    amtLine1.alpha = .5;
    [self.view addSubview:amtLine1];
    
    self.amt1.frame = CGRectMake(yOffset + margin + ingredientFieldWidth, SCREEN_HEIGHT/2-topMargin + count * margin, 40, 30);
    self.amt1.backgroundColor = [UIColor whiteColor];
    self.amt1.textColor = [UIColor blackColor];
    self.amt1.text = @"";
    [self.amt1 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    [self.amt1 setAlpha:0.8];
    
    self.amt1.autocorrectionType = UITextAutocorrectionTypeNo;
    self.amt1.keyboardType = UIKeyboardTypeDefault;
    self.amt1.returnKeyType = UIReturnKeyDone;
    self.amt1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.amt1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.amt1.borderStyle = UITextBorderStyleNone;
    self.amt1.delegate = self;
    self.amt1.placeholder = @" mL";
    
    [self.view addSubview:self.amt1];
    
    count += 2;
    
    self.ingredient2.frame = CGRectMake(yOffset, SCREEN_HEIGHT/2-topMargin + count * margin, ingredientFieldWidth, 30);
    self.ingredient2.backgroundColor = [UIColor whiteColor];
    self.ingredient2.textColor = [UIColor blackColor];
    self.ingredient2.text = @"";
    [self.ingredient2 setAlpha:0.8];
    
    self.ingredient2.autocorrectionType = UITextAutocorrectionTypeNo;
    self.ingredient2.keyboardType = UIKeyboardTypeDefault;
    self.ingredient2.returnKeyType = UIReturnKeyDone;
    self.ingredient2.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ingredient2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ingredient2.borderStyle = UITextBorderStyleNone;
    self.ingredient2.delegate = self;
    self.ingredient2.placeholder = @" Ingredient #2";
    
    [self.ingredient2 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    [self.view addSubview:self.ingredient2];
    
    self.amt2.frame = CGRectMake(yOffset + margin + ingredientFieldWidth, SCREEN_HEIGHT/2-topMargin + count * margin, 40, 30);
    self.amt2.backgroundColor = [UIColor whiteColor];
    self.amt2.textColor = [UIColor blackColor];
    self.amt2.text = @"";
    [self.amt2 setAlpha:0.8];
    [self.amt2 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    self.amt2.autocorrectionType = UITextAutocorrectionTypeNo;
    self.amt2.keyboardType = UIKeyboardTypeDefault;
    self.amt2.returnKeyType = UIReturnKeyDone;
    self.amt2.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.amt2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.amt2.borderStyle = UITextBorderStyleNone;
    self.amt2.delegate = self;
    self.amt2.placeholder = @" mL";
    
    [self.view addSubview:self.amt2];
    
    //draw line for ingred & amount
    UIView *ingredient2Line = [[UIView alloc] initWithFrame:CGRectMake(yOffset, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 160, 1)];
    ingredient2Line.backgroundColor = [UIColor grayColor];
    ingredient2Line.alpha = .5;
    [self.view addSubview:ingredient2Line];
    
    UIView *amtLine2 = [[UIView alloc] initWithFrame:CGRectMake(yOffset + 220, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 30, 1)];
    amtLine2.backgroundColor = [UIColor grayColor];
    amtLine2.alpha = .5;
    [self.view addSubview:amtLine2];
    
    count += 2;
    
    self.ingredient3.frame = CGRectMake(yOffset, SCREEN_HEIGHT/2-topMargin + count * margin, ingredientFieldWidth, 30);
    self.ingredient3.backgroundColor = [UIColor whiteColor];
    self.ingredient3.textColor = [UIColor blackColor];
    self.ingredient3.text = @"";
    [self.ingredient3 setAlpha:0.8];
    
    self.ingredient3.autocorrectionType = UITextAutocorrectionTypeNo;
    self.ingredient3.keyboardType = UIKeyboardTypeDefault;
    self.ingredient3.returnKeyType = UIReturnKeyDone;
    self.ingredient3.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ingredient3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ingredient3.borderStyle = UITextBorderStyleNone;
    self.ingredient3.delegate = self;
    self.ingredient3.placeholder = @" Ingredient #3";
    
    [self.ingredient3 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    [self.view addSubview:self.ingredient3];
    
    self.amt3.frame = CGRectMake(yOffset + margin + ingredientFieldWidth, SCREEN_HEIGHT/2-topMargin + count * margin, 40, 30);
    self.amt3.backgroundColor = [UIColor whiteColor];
    self.amt3.textColor = [UIColor blackColor];
    self.amt3.text = @"";
    [self.amt3 setAlpha:0.8];
    [self.amt3 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    self.amt3.autocorrectionType = UITextAutocorrectionTypeNo;
    self.amt3.keyboardType = UIKeyboardTypeDefault;
    self.amt3.returnKeyType = UIReturnKeyDone;
    self.amt3.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.amt3.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.amt3.borderStyle = UITextBorderStyleNone;
    self.amt3.delegate = self;
    self.amt3.placeholder = @" mL";
    
    [self.view addSubview:self.amt3];
    
    //draw line for ingred & amount
    UIView *ingredient3Line = [[UIView alloc] initWithFrame:CGRectMake(yOffset, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 160, 1)];
    ingredient3Line.backgroundColor = [UIColor grayColor];
    ingredient3Line.alpha = .5;
    [self.view addSubview:ingredient3Line];
    
    UIView *amtLine3 = [[UIView alloc] initWithFrame:CGRectMake(yOffset + 220, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 30, 1)];
    amtLine3.backgroundColor = [UIColor grayColor];
    amtLine3.alpha = .5;
    [self.view addSubview:amtLine3];
    
    count += 2;
    
    self.ingredient4.frame = CGRectMake(yOffset, SCREEN_HEIGHT/2-topMargin + count * margin, ingredientFieldWidth, 30);
    self.ingredient4.backgroundColor = [UIColor whiteColor];
    self.ingredient4.textColor = [UIColor blackColor];
    self.ingredient4.text = @"";
    [self.ingredient4 setAlpha:0.8];
    
    self.ingredient4.autocorrectionType = UITextAutocorrectionTypeNo;
    self.ingredient4.keyboardType = UIKeyboardTypeDefault;
    self.ingredient4.returnKeyType = UIReturnKeyDone;
    self.ingredient4.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ingredient4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ingredient4.borderStyle = UITextBorderStyleNone;
    self.ingredient4.delegate = self;
    self.ingredient4.placeholder = @" Ingredient #4";
    [self.ingredient4 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    [self.view addSubview:self.ingredient4];
    
    self.amt4.frame = CGRectMake(yOffset + margin + ingredientFieldWidth, SCREEN_HEIGHT/2-topMargin + count * margin, 40, 30);
    self.amt4.backgroundColor = [UIColor whiteColor];
    self.amt4.textColor = [UIColor blackColor];
    self.amt4.text = @"";
    [self.amt4 setAlpha:0.8];
    [self.amt4 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    self.amt4.autocorrectionType = UITextAutocorrectionTypeNo;
    self.amt4.keyboardType = UIKeyboardTypeDefault;
    self.amt4.returnKeyType = UIReturnKeyDone;
    self.amt4.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.amt4.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.amt4.borderStyle = UITextBorderStyleNone;
    self.amt4.delegate = self;
    self.amt4.placeholder = @" mL";
    
    [self.view addSubview:self.amt4];
    
    //draw line for ingred & amount
    UIView *ingredient4Line = [[UIView alloc] initWithFrame:CGRectMake(yOffset, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 160, 1)];
    ingredient4Line.backgroundColor = [UIColor grayColor];
    ingredient4Line.alpha = .5;
    [self.view addSubview:ingredient4Line];
    
    UIView *amtLine4 = [[UIView alloc] initWithFrame:CGRectMake(yOffset + 220, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 30, 1)];
    amtLine4.backgroundColor = [UIColor grayColor];
    amtLine4.alpha = .5;
    [self.view addSubview:amtLine4];
    
    count += 2;
    
    self.ingredient5.frame = CGRectMake(yOffset, SCREEN_HEIGHT/2-topMargin + count * margin, ingredientFieldWidth, 30);
    self.ingredient5.backgroundColor = [UIColor whiteColor];
    self.ingredient5.textColor = [UIColor blackColor];
    self.ingredient5.text = @"";
    [self.ingredient5 setAlpha:0.8];
    [self.ingredient5 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    self.ingredient5.autocorrectionType = UITextAutocorrectionTypeNo;
    self.ingredient5.keyboardType = UIKeyboardTypeDefault;
    self.ingredient5.returnKeyType = UIReturnKeyDone;
    self.ingredient5.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ingredient5.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ingredient5.borderStyle = UITextBorderStyleNone;
    self.ingredient5.delegate = self;
    self.ingredient5.placeholder = @" Ingredient #5";
    
    [self.view addSubview:self.ingredient5];
    
    self.amt5.frame = CGRectMake(yOffset + margin + ingredientFieldWidth, SCREEN_HEIGHT/2-topMargin + count * margin, 40, 30);
    self.amt5.backgroundColor = [UIColor whiteColor];
    self.amt5.textColor = [UIColor blackColor];
    self.amt5.text = @"";
    [self.amt5 setAlpha:0.8];
    
    self.amt5.autocorrectionType = UITextAutocorrectionTypeNo;
    self.amt5.keyboardType = UIKeyboardTypeDefault;
    self.amt5.returnKeyType = UIReturnKeyDone;
    self.amt5.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.amt5.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.amt5.borderStyle = UITextBorderStyleNone;
    self.amt5.delegate = self;
    self.amt5.placeholder = @" mL";
    [self.amt5 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    [self.view addSubview:self.amt5];
    
    //draw line for ingred & amount
    UIView *ingredient5Line = [[UIView alloc] initWithFrame:CGRectMake(yOffset, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 160, 1)];
    ingredient5Line.backgroundColor = [UIColor grayColor];
    ingredient5Line.alpha = .5;
    [self.view addSubview:ingredient5Line];
    
    UIView *amtLine5 = [[UIView alloc] initWithFrame:CGRectMake(yOffset + 220, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 30, 1)];
    amtLine5.backgroundColor = [UIColor grayColor];
    amtLine5.alpha = .5;
    [self.view addSubview:amtLine5];
    
    count += 2;
    
    self.ingredient6.frame = CGRectMake(yOffset, SCREEN_HEIGHT/2-topMargin + count * margin, ingredientFieldWidth, 30);
    self.ingredient6.backgroundColor = [UIColor whiteColor];
    self.ingredient6.textColor = [UIColor blackColor];
    self.ingredient6.text = @"";
    [self.ingredient6 setAlpha:0.8];
    [self.ingredient6 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    self.ingredient6.autocorrectionType = UITextAutocorrectionTypeNo;
    self.ingredient6.keyboardType = UIKeyboardTypeDefault;
    self.ingredient6.returnKeyType = UIReturnKeyDone;
    self.ingredient6.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.ingredient6.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.ingredient6.borderStyle = UITextBorderStyleNone;
    self.ingredient6.delegate = self;
    self.ingredient6.placeholder = @" Ingredient #6";
    
    [self.view addSubview:self.ingredient6];
    
    self.amt6.frame = CGRectMake(yOffset + margin + ingredientFieldWidth, SCREEN_HEIGHT/2-topMargin + count * margin, 40, 30);
    self.amt6.backgroundColor = [UIColor whiteColor];
    self.amt6.textColor = [UIColor blackColor];
    self.amt6.text = @"";
    [self.amt6 setAlpha:0.8];
    [self.amt6 setFont:[UIFont fontWithName:@"ArialMT" size:16]];
    
    self.amt6.autocorrectionType = UITextAutocorrectionTypeNo;
    self.amt6.keyboardType = UIKeyboardTypeDefault;
    self.amt6.returnKeyType = UIReturnKeyDone;
    self.amt6.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.amt6.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.amt6.borderStyle = UITextBorderStyleNone;
    self.amt6.delegate = self;
    self.amt6.placeholder = @" mL";
    
    [self.view addSubview:self.amt6];
    
    //draw line for ingred & amount
    UIView *ingredient6Line = [[UIView alloc] initWithFrame:CGRectMake(yOffset, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 160, 1)];
    ingredient6Line.backgroundColor = [UIColor grayColor];
    ingredient6Line.alpha = .5;
    [self.view addSubview:ingredient6Line];
    
    UIView *amtLine6 = [[UIView alloc] initWithFrame:CGRectMake(yOffset + 220, SCREEN_HEIGHT/2 - topMargin + count * margin + 30, 30, 1)];
    amtLine6.backgroundColor = [UIColor grayColor];
    amtLine6.alpha = .5;
    [self.view addSubview:amtLine6];
}

- (void)initializeNameField
{
    //set up fields?
    int nameFieldWidth = 180;
    self.nameField.frame = CGRectMake(10,30,nameFieldWidth,30);
    self.nameField.backgroundColor = [UIColor whiteColor];
    self.nameField.textColor = [UIColor blackColor];
    self.nameField.text = @"";
    
    [self.nameField setAlpha:1];
    
    //make location text field pretty
    self.nameField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.nameField.keyboardType = UIKeyboardTypeDefault;
    self.nameField.returnKeyType = UIReturnKeyDone;
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.nameField.borderStyle = UITextBorderStyleNone;
    self.nameField.delegate = self;
    self.nameField.placeholder = @" Name of drink";
    
    [self.view addSubview:self.nameField];
    
    //draw line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 60, 180, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = .5;
    [self.view addSubview:lineView];
}

- (void)initializeCameraButton
{
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *cameraButtonImage = [UIImage imageNamed:@"addcamera.png"];
    [cameraButton setBackgroundImage:cameraButtonImage forState:UIControlStateNormal];
    int buttonWidth = 80;
    cameraButton.frame = CGRectMake(SCREEN_WIDTH - buttonWidth - 10, 30, buttonWidth, 80);
    [cameraButton addTarget:self action:@selector(choosePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
}

- (void)initializeAddButton
{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *addButtonImage = [UIImage imageNamed:@"sharebutton.png"];
    [addButton setBackgroundImage:addButtonImage forState:UIControlStateNormal];
    int buttonWidth = 200;
    addButton.frame = CGRectMake(SCREEN_WIDTH/2 - buttonWidth/2 - 35, SCREEN_HEIGHT - 130, 273.5, 39);
    [addButton addTarget:self action:@selector(addDrink) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
}

- (void)addDrink
{
    Firebase* ref = [[Firebase alloc] initWithUrl:@"https://drinkmixer.firebaseio.com/drinks"];
    if ([self.nameField.text isEqual: @""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: No Drink Name"
                                                        message:@"Name of drink can't be empty."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    ref = [[ref childByAppendingPath:category] childByAppendingPath:self.nameField.text];
    
    NSMutableDictionary *ingredients = [[NSMutableDictionary alloc] init];
    
    if (![self.ingredient1.text isEqual: @""]) {
        if ((![self.amt1.text isEqual: @""]) && ([self.amt1.text rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]].location == NSNotFound)) {
            [ingredients setObject:self.amt1.text forKey:self.ingredient1.text];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: Invalid Ingredient #1"
                                                            message:@"No amount specified or invalid amount."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    
    if (![self.ingredient2.text isEqual: @""]) {
        if ((![self.amt2.text isEqual: @""]) && ([self.amt2.text rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]].location == NSNotFound)) {
            [ingredients setObject:self.amt2.text forKey:self.ingredient2.text];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: Invalid Ingredient #2"
                                                            message:@"No amount specified or invalid amount."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    
    if (![self.ingredient3.text isEqual: @""]) {
        if ((![self.amt3.text isEqual: @""]) && ([self.amt3.text rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]].location == NSNotFound)) {
            [ingredients setObject:self.amt3.text forKey:self.ingredient3.text];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: Invalid Ingredient #3"
                                                            message:@"No amount specified or invalid amount."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    
    if (![self.ingredient4.text isEqual: @""]) {
        if ((![self.amt4.text isEqual: @""]) && ([self.amt4.text rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]].location == NSNotFound)) {
            [ingredients setObject:self.amt4.text forKey:self.ingredient4.text];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: Invalid Ingredient #4"
                                                            message:@"No amount specified or invalid amount."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    
    if (![self.ingredient5.text isEqual: @""]) {
        if ((![self.amt5.text isEqual: @""]) && ([self.amt5.text rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]].location == NSNotFound)) {
            [ingredients setObject:self.amt5.text forKey:self.ingredient5.text];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: Invalid Ingredient #5"
                                                            message:@"No amount specified or invalid amount."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    
    if (![self.ingredient6.text isEqual: @""]) {
        if ((![self.amt6.text isEqual: @""]) && ([self.amt6.text rangeOfCharacterFromSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet]].location == NSNotFound)) {
            [ingredients setObject:self.amt6.text forKey:self.ingredient6.text];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: Invalid Ingredient #1"
                                                            message:@"No amount specified or invalid amount."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
    }
    
    if (mediaPicked == YES) {
            NSData *imageData = UIImageJPEGRepresentation(img, 0.9);
            NSString *imageString = [NSString base64StringFromData:imageData length:[imageData length]];
           [ingredients setObject:imageString forKey:@"image"];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error: No Image"
                                                        message:@"Upload an image of your drink!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [ref setValue:ingredients];
}

- (void)initializeNavBar
{
    // Background image for navbar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"]
                                       forBarMetrics: UIBarMetricsDefault];
    
    // Left bar button item.
    UIBarButtonItem *lbb =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tinyworld.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(launchShare)];
    lbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(59, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    
    titleImageView.alpha = .5;
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(0, 0, 200, 44);
    [homeButton addTarget:self
                   action:@selector(launchHome)
         forControlEvents:UIControlEventTouchUpInside];
    [logoView addSubview:homeButton];
    
    self.navigationItem.titleView = logoView;
    
    // Right bar button item to launch the categories selection screen.
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tinycup.png"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(launchCategories)];
    
    rbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.5];
    self.navigationItem.rightBarButtonItem = rbb;

}

- (void)launchHome
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)launchShare
{
    // Already in the share view controller; no need to do anything here.
}

- (void)launchCategories
{
    CategoryViewController *cvc = [[CategoryViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:NO];
}

- (void) choosePicture: (id) sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        NSArray* mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        self.imagePicker.mediaTypes = mediaTypes;
    } else {
        [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    }
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    mediaPicked = NO;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image;
    NSData *mediaData;
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *) kUTTypeImage]) {
        image = [info valueForKey:UIImagePickerControllerOriginalImage];
        mediaData = UIImageJPEGRepresentation(image, 1.0f);
    } else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        NSURL *vidURL = [info valueForKey:UIImagePickerControllerMediaURL];
        mediaData = [NSData dataWithContentsOfURL:vidURL];
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:vidURL];
        image = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        player = nil;
    }
    
    img = [UIImage imageWithData:mediaData];
    mediaPicked = YES;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, 50, 100, 100)];
    [imgView setImage:img];
    [self.view addSubview:imgView];
}

- (UIImage *)getThumbnailFromImage:(UIImage *)image {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, 20, 20));
    CGImageRef imageRef = image.CGImage;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(20.0f, 20.0f), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, 20.0f);
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = @[@"Refreshers", @"Coffee", @"Juice", @"Shakes"];
    
    //add category label
    UILabel *cat = [[UILabel alloc] initWithFrame:CGRectMake(15, 70, 300, 20)];
    
    [cat setTextColor:[UIColor grayColor]];
    [cat setBackgroundColor:[UIColor clearColor]];
    [cat setFont:[UIFont fontWithName: @"Trebuchet MS" size: 19.0f]];
    cat.text = @"Category:";
    [self.view addSubview:cat];
    
    pickerView = [[UIPickerView alloc] init];
    
    [pickerView setDelegate: self];
    
    [pickerView setFrame:CGRectMake(15, 75.0, 180, 30)];
    pickerView.showsSelectionIndicator = YES;
    [pickerView selectRow:2 inComponent:0 animated:YES];
    
    [self.view addSubview: pickerView];
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    dataArray = @[@"Refreshers", @"Coffee", @"Juice", @"Shakes"];
    if (!tView){
        tView = [[UILabel alloc] init];
        tView.font = [tView.font fontWithSize:12];
    }
    // Fill the label text here
    
    tView.text = dataArray[row];

    
    return tView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)didFinishChoosing
{
    [self dismissViewControllerAnimated:YES completion:^() {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return false;
}

// Picker view delegate methods
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [dataArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [dataArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    category = [dataArray objectAtIndex:row];
}


@end

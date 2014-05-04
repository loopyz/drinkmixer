//
//  ShareViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/4/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "ShareViewController.h"
#import "CategoriesViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ShareViewController ()  <UITextFieldDelegate>
{
    BOOL mediaPicked;
    UIImage *img;
}
@end

@implementation ShareViewController
@synthesize nameField, descriptionField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeNavBar];
        self.imagePicker = [[UIImagePickerController alloc] init];
        self.imagePicker.delegate = self;
        
        [self initializeCameraButton];
        
        //initialize text field?
        self.nameField = [[UITextField alloc] init];
        self.descriptionField = [[UITextField alloc] init];
        
        //set up fields?
        self.nameField.frame = CGRectMake(120,250,180,30);
        self.nameField.backgroundColor = [UIColor whiteColor];
        self.nameField.textColor = [UIColor blackColor];
        [self.nameField setAlpha:0.8];
        
        //make location text field pretty
        self.nameField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.nameField.keyboardType = UIKeyboardTypeDefault;
        self.nameField.returnKeyType = UIReturnKeyDone;
        self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.nameField.borderStyle = UITextBorderStyleNone;
        //[self.locationTextField setBackground:textBG];
        self.nameField.delegate = self;
        
        [self.view addSubview:self.nameField];

    }
    return self;
}

- (void)initializeCameraButton
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *cameraButtonImage = [UIImage imageNamed:@"addcamera.png"]; // TODO: change to image of camera
    [cameraButton setBackgroundImage:cameraButtonImage forState:UIControlStateNormal];
    int buttonWidth = 100;
    cameraButton.frame = CGRectMake(20, 20, buttonWidth * .8, 80);
    [cameraButton addTarget:self action:@selector(choosePicture:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
}

- (void)initializeNavBar
{
    // Background image for navbar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"]
                                       forBarMetrics: UIBarMetricsDefault];
    
    // Left bar button item. TODO: replace with custom image one
    UIImage *world = [UIImage imageNamed:@"world-disabled.png"];
    
    UIBarButtonItem *lbb =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tinyworld.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(launchShare)];
    lbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(43, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
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
    CategoriesViewController *cvc = [[CategoriesViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:NO];
}

- (void) choosePicture: (id) sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        NSArray* mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        self.imagePicker.mediaTypes = mediaTypes;
        [self.imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
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
    
    // TODO: test this since I'm not sure it works (simulator has no camera)
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
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
    NSLog(@"SHARE");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didFinishChoosing
{
    //    AppDelegate* appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //    NSString* username = appDelegate.username;
    //
    //    Firebase* usersRef = [[Firebase alloc] initWithUrl:@"https://uStudy.firebaseio.com/users"];
    //    Firebase* interestsRef = [[usersRef childByAppendingPath:username] childByAppendingPath:@"college"];
    //
    //
    [self dismissViewControllerAnimated:YES completion:^() {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //go to next view :P
    return false;
}



@end

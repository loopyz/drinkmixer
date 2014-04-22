//
//  LoginViewController.m
//  uStudy
//
//  Created by Angela Zhang on 1/31/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self addBackgroundImage];
    }
    return self;
}

- (IBAction)buttonTouched:(id)sender
{
    // If the session state is any of the two "open" states when the button is clicked
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for basic_info permissions when opening a session
        [FBSession openActiveSessionWithPublishPermissions:@[@"basic_info", @"create_event"] defaultAudience:FBSessionDefaultAudienceEveryone allowLoginUI:YES completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             // Retrieve the app delegate
             AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
             // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
             [appDelegate sessionStateChanged:session state:state error:error];
         }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 230)/2 - 13, 80, 258.5, 62)];
    imgView.image = [UIImage imageNamed:@"logo.png"];
    [self.view addSubview:imgView];
    
	// Do any additional setup after loading the view.
    self.facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.facebookButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.facebookButton.frame = CGRectMake((self.view.frame.size.width - 263)/2 + 3, 190, 263, 52);
    [self.facebookButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"facebook-login.png"];
    [self.facebookButton setImage:btnImage forState:UIControlStateNormal];
    self.facebookButton.contentMode = UIViewContentModeScaleToFill;

    [self.view addSubview:self.facebookButton];
    
    self.twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.twitterButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.twitterButton.frame = CGRectMake((self.view.frame.size.width - 263)/2 + 3, 250, 263, 52);
    [self.twitterButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"twitter-login.png"];
    [self.twitterButton setImage:btnImage forState:UIControlStateNormal];
    self.twitterButton.contentMode = UIViewContentModeScaleToFill;
    
    
//    UIImageView *bottompic = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 230)/2 - 13, 400, 423, 214)];
//    bottompic.image =  [UIImage imageNamed:@"login-picture.png"];
//    [self.view addSubview:bottompic];
    
    
    [self.view addSubview:self.twitterButton];
    
    
}

- (void)addBackgroundImage
{
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

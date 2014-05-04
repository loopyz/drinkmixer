//
//  HomeViewController.m
//  Drink Mixer
//
//  Created by Lucy Guo on 4/22/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeNavBar];
        
        [self addBackgroundImage];

    }
    return self;
}

- (void)initializeNavBar
{
    // Background image for navbar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"]
                                       forBarMetrics: UIBarMetricsDefault];
    
    // Left bar button item. TODO: replace with custom image one
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doSomething)];
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(40, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
    // Right bar button item. TODO: replace with custom image one
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(doSomethingElse)];
    self.navigationItem.rightBarButtonItem = rbb;
}

- (void)doSomething //TODO: change this!
{
    NSLog(@"left bar button item clicked");
}

- (void)doSomethingElse //TODO: change this!
{
    NSLog(@"right bar buttom item clicked");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBackgroundImage
{
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"home-bg.png"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 326.4, 120.36)];
    imgView.image = [UIImage imageNamed:@"profile.png"];
    [self.view addSubview:imgView];

//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

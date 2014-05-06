//
//  CategoryViewController.m
//  Drink Mixer
//
//  Created by Lucy Guo on 5/5/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "CategoryViewController.h"
#import "ShareViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initializeNavBar];
        [self addSideImage];
        [self addCatButtons];
        self.view.backgroundColor = [UIColor whiteColor];

    }
    return self;
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

- (void)addSideImage
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 70.5, 485)];
    imgView.image = [UIImage imageNamed:@"sideimages.png"];
    [self.view addSubview:imgView];
}

- (void)addCatButtons
{
    
    //cocktails button
    self.refreshersButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.refreshersButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.refreshersButton.frame = CGRectMake(80, 15, 219.5, 20.5);
    [self.refreshersButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"refreshers.png"];
    [self.refreshersButton setImage:btnImage forState:UIControlStateNormal];
    self.refreshersButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.refreshersButton];
    
    
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
    lbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.5];
    self.navigationItem.leftBarButtonItem = lbb;
    
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(43, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(0, 0, 200, 44);
    [homeButton addTarget:self
                   action:@selector(launchHome)
         forControlEvents:UIControlEventTouchUpInside];
    [logoView addSubview:homeButton];
    
    titleImageView.alpha = .5;
    
    self.navigationItem.titleView = logoView;
    
    // Right bar button item to launch the categories selection screen.
    
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tinycup.png"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(launchCategories)];
    
    rbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = rbb;
}

- (void)launchHome
{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)launchShare
{
    ShareViewController *svc = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:svc animated:NO];
}

- (void)launchCategories
{
    // Already in the Categories view; this doesn't do anything.
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

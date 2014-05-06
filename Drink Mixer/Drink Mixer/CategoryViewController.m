//
//  CategoryViewController.m
//  Drink Mixer
//
//  Created by Lucy Guo on 5/5/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "CategoryViewController.h"
#import "ShareViewController.h"
#import "ListViewController.h"

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
    
    //refreshers button
    self.refreshersButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.refreshersButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.refreshersButton.frame = CGRectMake(80, 15, 219.5, 20.5);
    [self.refreshersButton addTarget:self action:@selector(launchListView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"refreshers.png"];
    [self.refreshersButton setImage:btnImage forState:UIControlStateNormal];
    self.refreshersButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.refreshersButton];
    
    //coffee button
    self.coffeeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.coffeeButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.coffeeButton.frame = CGRectMake(80, 15 + 115, 219.5, 20.5);
    [self.coffeeButton addTarget:self action:@selector(launchListView:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"coffee.png"];
    [self.coffeeButton setImage:btnImage forState:UIControlStateNormal];
    self.coffeeButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.coffeeButton];
    
    //juice button
    self.juiceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.juiceButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.juiceButton.frame = CGRectMake(80, 130 + 115, 219.5, 20.5);
    [self.juiceButton addTarget:self action:@selector(launchListView:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"juice.png"];
    [self.juiceButton setImage:btnImage forState:UIControlStateNormal];
    self.juiceButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.juiceButton];
    
    //shakes button
    self.shakesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shakesButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.shakesButton.frame = CGRectMake(80, 130 + 115 + 130, 219.5, 20.5);
    [self.shakesButton addTarget:self action:@selector(launchListView:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"shakes.png"];
    [self.shakesButton setImage:btnImage forState:UIControlStateNormal];
    self.shakesButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.shakesButton];
    
    
}

- (void)launchListView:(id)sender
{
    NSString *category = @"Coffee";
    if (sender == self.shakesButton)    {
        category = @"Shakes";
    } else if (sender == self.refreshersButton) {
        category = @"Refreshers";
    } else if (sender == self.juiceButton) {
        category = @"Juice";
    }
    ListViewController *lvc = [[ListViewController alloc] initWithNibName:category bundle:nil];
    [self.navigationController pushViewController:lvc animated:NO];
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

@end

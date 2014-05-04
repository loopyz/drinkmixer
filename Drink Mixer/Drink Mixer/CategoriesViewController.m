//
//  CategoriesViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/4/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "CategoriesViewController.h"
#import "ShareViewController.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeNavBar];
    }
    return self;
}

- (void)initializeNavBar
{
    // Background image for navbar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar.png"]
                                       forBarMetrics: UIBarMetricsDefault];
    
    // Left bar button item. TODO: replace with custom image one
    UIBarButtonItem *lbb =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"world-disabled.png"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(launchShare)];
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(30, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(0, 0, 200, 44);
    [homeButton addTarget:self
                   action:@selector(launchHome)
         forControlEvents:UIControlEventTouchUpInside];
    [logoView addSubview:homeButton];
    
    self.navigationItem.titleView = logoView;
    
    // Right bar button item to launch the categories selection screen.
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cup-disabled.png"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(launchCategories)];
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

- (void)viewDidLoad
{
    NSLog(@"CATEGORIES");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

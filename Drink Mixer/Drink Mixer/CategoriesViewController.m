//
//  CategoriesViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/4/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "CategoriesViewController.h"
#import "ShareViewController.h"

@interface CategoriesViewController () <UITextFieldDelegate>

@end

@implementation CategoriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeNavBar];
        [self setupSearch];
        [self setupButtons];
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

- (void)setupSearch
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 326.4, 32.38)];
    imgView.image = [UIImage imageNamed:@"search.png"];
    [self.view addSubview:imgView];
}

- (void)setupButtons
{
    
    //cocktails button
    self.cocktailsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cocktailsButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.cocktailsButton.frame = CGRectMake(0, 32.38, 327, 121.14759);
    [self.cocktailsButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"cocktails.png"];
    [self.cocktailsButton setImage:btnImage forState:UIControlStateNormal];
    self.cocktailsButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.cocktailsButton];
    
    //smoothies button
    self.smoothiesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.smoothiesButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.smoothiesButton.frame = CGRectMake(0, 32.38 + 120, 327, 121.14759);
    [self.smoothiesButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"smoothies.png"];
    [self.smoothiesButton setImage:btnImage forState:UIControlStateNormal];
    self.smoothiesButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.smoothiesButton];
    
    //protein button
    self.proteinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.proteinButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.proteinButton.frame = CGRectMake(0, 32.38 + 120 + 120, 327, 121.14759);
    [self.proteinButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"protein.png"];
    [self.proteinButton setImage:btnImage forState:UIControlStateNormal];
    self.proteinButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.proteinButton];
    
    //other button
    self.otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.otherButton setTitle:@"Show View" forState:UIControlStateNormal];
    
    self.otherButton.frame = CGRectMake(0, 32.38 + 120 + 120+114, 327, 121.14759);
    [self.otherButton addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"other.png"];
    [self.otherButton setImage:btnImage forState:UIControlStateNormal];
    self.otherButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:self.otherButton];
    
    
    
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

- (IBAction)buttonTouched:(id)sender
{
    NSLog(@"Meow");
}

- (void)didFinishChoosing
{

    [self dismissViewControllerAnimated:YES completion:^() {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    //go to next view :P
    return false;
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

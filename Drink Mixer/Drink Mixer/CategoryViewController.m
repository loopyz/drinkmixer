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
#import "MakeItViewController.h"

#define firebaseURL @"https://drinkmixer.firebaseio.com/"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeNavBar];
        [self addSideImage];
        [self addCatButtons];
        //[self setupRefreshers];
        [self grabtop3:@"Refreshers"];
        [self grabtop3:@"Coffee"];
        [self grabtop3:@"Juice"];
        [self grabtop3:@"Shakes"];
        //[self setupCoffee];
        //[self setupJuice];
        //[self setupShakes];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)grabtop3:(NSString *)category
{
    //test thing
    Firebase *ref = [[self.firebase childByAppendingPath:@"drinks"] childByAppendingPath:category];
    
    NSMutableArray *drinksDataSource = [[NSMutableArray alloc] init];
    
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSString* ingredient = snapshot.name;
        //NSLog(ingredient);
        [drinksDataSource addObject:ingredient];
        //[self.drinksTableView reloadData];
        
        if ([drinksDataSource count] >= 3) {
            if ([category isEqualToString:@"Refreshers"])
                [self setupRefreshers:[drinksDataSource objectAtIndex:0] second:[drinksDataSource objectAtIndex:1] third:[drinksDataSource objectAtIndex:2]];
            else if ([category isEqualToString:@"Coffee"])
                [self setupCoffee:[drinksDataSource objectAtIndex:0] second:[drinksDataSource objectAtIndex:1] third:[drinksDataSource objectAtIndex:2]];
            else if ([category isEqualToString:@"Juice"])
                [self setupJuice:[drinksDataSource objectAtIndex:0] second:[drinksDataSource objectAtIndex:1] third:[drinksDataSource objectAtIndex:2]];
            else if ([category isEqualToString:@"Shakes"])
                [self setupShakes:[drinksDataSource objectAtIndex:0] second:[drinksDataSource objectAtIndex:1] third:[drinksDataSource objectAtIndex:2]];
            
        }
    }];
}

- (void)setupRefreshers:(NSString *)item1 second:(NSString *)item2 third:(NSString *)item3
{
    //button 1
    UIButton *refreshers1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    refreshers1.frame = CGRectMake(80, 45, 191, 20.5);
    [refreshers1 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"bluebutton.png"];
    
    [refreshers1 setBackgroundImage:btnImage forState:UIControlStateNormal];
    refreshers1.contentMode = UIViewContentModeScaleToFill;
    
    //refreshers1.titleLabel = [self.drinksDataSource objectAtIndex:0];
    
    [refreshers1 setTitle:item1 forState:UIControlStateNormal];
    refreshers1.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    refreshers1.tag = 1;
    [self.view addSubview:refreshers1];
    
    //button 2
    UIButton *refreshers2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    refreshers2.frame = CGRectMake(80, 45 + 25, 191, 20.5);
    [refreshers2 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [refreshers2 setBackgroundImage:btnImage forState:UIControlStateNormal];
    refreshers2.contentMode = UIViewContentModeScaleToFill;
    
    [refreshers2 setTitle:item2 forState:UIControlStateNormal];
    refreshers2.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    refreshers2.tag = 1;
    [self.view addSubview:refreshers2];
    
    //button 3
    UIButton *refreshers3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    refreshers3.frame = CGRectMake(80, 45 + 25 + 25, 191, 20.5);
    [refreshers3 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [refreshers3 setBackgroundImage:btnImage forState:UIControlStateNormal];
    refreshers3.contentMode = UIViewContentModeScaleToFill;
    
    [refreshers3 setTitle:item3 forState:UIControlStateNormal];
    refreshers3.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    refreshers3.tag = 1;
    [self.view addSubview:refreshers3];
}

- (void) setupCoffee:(NSString *)item1 second:(NSString *)item2 third:(NSString *)item3
{
    //button 1
    UIButton *coffee1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    coffee1.frame = CGRectMake(80, 160, 191, 20.5);
    [coffee1 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [coffee1 setBackgroundImage:btnImage forState:UIControlStateNormal];
    coffee1.contentMode = UIViewContentModeScaleToFill;
    
    [coffee1 setTitle:item1 forState:UIControlStateNormal];
    coffee1.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    coffee1.tag = 2;
    [self.view addSubview:coffee1];
    
    //button 2
    UIButton *coffee2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    coffee2.frame = CGRectMake(80, 160 + 25, 191, 20.5);
    [coffee2 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [coffee2 setBackgroundImage:btnImage forState:UIControlStateNormal];
    coffee2.contentMode = UIViewContentModeScaleToFill;
    
    [coffee2 setTitle:item2 forState:UIControlStateNormal];
    coffee2.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    coffee2.tag = 2;
    [self.view addSubview:coffee2];
    
    //button 3
    UIButton *coffee3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    coffee3.frame = CGRectMake(80, 160 + 25 + 25, 191, 20.5);
    [coffee3 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [coffee3 setBackgroundImage:btnImage forState:UIControlStateNormal];
    coffee3.contentMode = UIViewContentModeScaleToFill;
    
    [coffee3 setTitle:item3 forState:UIControlStateNormal];
    coffee3.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    coffee3.tag = 2;
    [self.view addSubview:coffee3];
}

- (void)setupJuice:(NSString *)item1 second:(NSString *)item2 third:(NSString *)item3
{
    //button 1
    UIButton *juice1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    juice1.frame = CGRectMake(80, 280, 191, 20.5);
    [juice1 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [juice1 setBackgroundImage:btnImage forState:UIControlStateNormal];
    juice1.contentMode = UIViewContentModeScaleToFill;
    
    [juice1 setTitle:item1 forState:UIControlStateNormal];
    juice1.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    juice1.tag = 3;
    [self.view addSubview:juice1];
    
    //button 2
    UIButton *juice2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    juice2.frame = CGRectMake(80, 280 + 25, 191, 20.5);
    [juice2 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [juice2 setBackgroundImage:btnImage forState:UIControlStateNormal];
    juice2.contentMode = UIViewContentModeScaleToFill;
    
    [juice2 setTitle:item2 forState:UIControlStateNormal];
    juice2.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    juice2.tag = 3;
    [self.view addSubview:juice2];
    
    //button 3
    UIButton *juice3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    juice3.frame = CGRectMake(80, 280 + 25 + 25, 191, 20.5);
    [juice3 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [juice3 setBackgroundImage:btnImage forState:UIControlStateNormal];
    juice3.contentMode = UIViewContentModeScaleToFill;
    
    [juice3 setTitle:item3 forState:UIControlStateNormal];
    juice3.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    juice3.tag = 3;
    [self.view addSubview:juice3];
}

- (void)setupShakes:(NSString *)item1 second:(NSString *)item2 third:(NSString *)item3
{
    //button 1
    UIButton *shake1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [shake1 setTitle:item1 forState:UIControlStateNormal];
    
    shake1.frame = CGRectMake(80, 407, 191, 20.5);
    [shake1 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [shake1 setBackgroundImage:btnImage forState:UIControlStateNormal];
    shake1.contentMode = UIViewContentModeScaleToFill;
    
    shake1.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    [self.view addSubview:shake1];
    
    //button 2
    UIButton *shake2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [shake2 setTitle:item2 forState:UIControlStateNormal];
    
    shake2.frame = CGRectMake(80, 407 + 25, 191, 20.5);
    [shake2 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [shake2 setBackgroundImage:btnImage forState:UIControlStateNormal];
    shake2.contentMode = UIViewContentModeScaleToFill;
    
    shake2.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    [self.view addSubview:shake2];
    
    //button 3
    UIButton *shake3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [shake3 setTitle:item3 forState:UIControlStateNormal];
    
    shake3.frame = CGRectMake(80, 407 + 25 + 25, 191, 20.5);
    [shake3 addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    btnImage = [UIImage imageNamed:@"bluebutton.png"];
    [shake3 setBackgroundImage:btnImage forState:UIControlStateNormal];
    shake3.contentMode = UIViewContentModeScaleToFill;
    
    shake3.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    
    [self.view addSubview:shake3];
}

- (void)buttonTouched:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSString *category = @"Shakes";
    if (button.tag == 1) {
        category = @"Refreshers";
    } else if (button.tag == 2) {
        category = @"Coffee";
    } else if (button.tag == 3) {
        category = @"Juice";
    }
    
    MakeItViewController *mvc = [[MakeItViewController alloc] initCustom:@[category, button.titleLabel.text]];
    [self.navigationController pushViewController:mvc animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //initialize firebase
    self.firebase = [[Firebase alloc] initWithUrl:firebaseURL];
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
    [self.navigationController pushViewController:lvc animated:YES];
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

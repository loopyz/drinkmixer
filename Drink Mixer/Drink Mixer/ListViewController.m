//
//  ListViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/5/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "ListViewController.h"
#import "MakeItViewController.h"

#define firebaseURL @"https://drinkmixer.firebaseio.com/"
#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SIDEBAR_OFFSET 75


@interface ListViewController ()
{
    NSString *category;
}
@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nibBundleOrNil];
    category = nibNameOrNil;
    if (self) {
        self.textColor = [UIColor colorWithRed:221/255.0f green:31/255.0f blue:38/255.0f alpha:1.0f];
        
        self.drinksDataSource = [[NSMutableArray alloc] initWithObjects:nil];
        [self initSidebar];
        [self initNavbar];
        
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)initNavbar
{
    // Logo in the center of navigation bar
//    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
//    titleImageView.frame = CGRectMake(43, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
//    [logoView addSubview:titleImageView];
//    
//    titleImageView.alpha = .5;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 60, 50)];
    [label setFont:[UIFont fontWithName:@"hiragino kaku gothic pro" size:22]];
    
    [label setText:category];
    label.textColor = [UIColor whiteColor];
    
    //label.frame = CGRectMake(43, 8, 60, 50);
    self.navigationItem.titleView = label;
    
    
}

- (void)initSidebar
{
    // Add sidebar on left of screen
    UIView *sidebarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
    UIImageView *sidebarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[category stringByAppendingString:@"icon"]]];
    sidebarImageView.frame = CGRectMake(0, 30, 70.5, 482);
    [sidebarView addSubview:sidebarImageView];
    [self.view addSubview:sidebarView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize Firebase
    self.firebase = [[Firebase alloc] initWithUrl:firebaseURL];
    
    Firebase *ref = [[self.firebase childByAppendingPath:@"drinks"] childByAppendingPath:category];
    
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSString* ingredient = snapshot.name;
        [self.drinksDataSource addObject:ingredient];
        [self.drinksTableView reloadData];
    }];
    
    //  Setup for drinks list tableView
    CGRect tableViewRect = CGRectMake(SIDEBAR_OFFSET, 0, SCREEN_WIDTH-SIDEBAR_OFFSET, SCREEN_HEIGHT);
    self.drinksTableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    self.drinksTableView.separatorStyle=UITableViewCellSeparatorStyleNone; // Get rid of bars separating sections
    self.drinksTableView.delegate = self;
    self.drinksTableView.dataSource = self;
    [self.drinksTableView setRowHeight:30];
    [self.drinksTableView setAllowsSelection:YES];
    [self.view addSubview:self.drinksTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Table View Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.drinksDataSource count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @""; // Doesn't matter b/c we're using custom viewForHeaderInSection
}

//Header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 50)];
//    [label setFont:[UIFont fontWithName:@"hiragino kaku gothic pro" size:35]];
//    
//    [label setText:category];
//    [view addSubview:label];
    [view setBackgroundColor:[UIColor whiteColor]];
     return view;
}

//for each cell in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //what?
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [recognizer setNumberOfTapsRequired:1];
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:recognizer];
    
    static NSString *MyIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
        
//        UIView *cellBgView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0, 0)];
//        
//        [cellBgView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bluebutton.png"]]];
//        
//        [cell setBackgroundView:cellBgView];
        
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////        [button addTarget:self
////                   action:@selector(customActionPressed:)
////         forControlEvents:UIControlEventTouchDown];
//        button.frame = CGRectMake(0.0f, 0.0f, 191, 20.5);
//        [button setBackgroundImage:[UIImage imageNamed:@"bluebutton.png"] forState:UIControlStateNormal];
//        button.contentMode = UIViewContentModeScaleAspectFill;
//        
//        [cell addSubview:button];
        

    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //        [button addTarget:self
    //                   action:@selector(customActionPressed:)
    //         forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(10.0, 10.0, 191, 20.5);
    [button setBackgroundImage:[UIImage imageNamed:@"bluebutton.png"] forState:UIControlStateNormal];
    button.contentMode = UIViewContentModeScaleAspectFill;
    
    [cell addSubview:button];

    [button setTitle:[self.drinksDataSource objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    
    button.titleLabel.textColor = self.textColor;
    //cell.textLabel.text = [self.drinksDataSource objectAtIndex:indexPath.row];
    //cell.textLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    return cell;
}

//checks which row index you hit
-(void)gestureAction:(UITapGestureRecognizer *)sender
{
    CGPoint touchLocation = [sender locationOfTouch:0 inView:self.drinksTableView];
    NSIndexPath *indexPath = [self.drinksTableView indexPathForRowAtPoint:touchLocation];

    NSString *name = [self.drinksDataSource objectAtIndex:indexPath.row];
    
    NSArray *parameters = [[NSArray alloc] initWithObjects:category, name, nil];
    
    MakeItViewController *mvc = [[MakeItViewController alloc] initCustom:parameters];
    [self.navigationController pushViewController:mvc animated:NO];
    
}


@end

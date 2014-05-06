//
//  ListViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/5/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "ListViewController.h"

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
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    // TODO: change image here
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(43, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    
    titleImageView.alpha = .5;
    
    self.navigationItem.titleView = logoView;
}

- (void)initSidebar
{
    // Add sidebar on left of screen
    
    UIView *sidebarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
    
    
    //refreshers icon - CHANGE TO WHATEVER CAT WE ARE ON LATER
    UIImageView *sidebarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"refreshersicon.png"]];
    sidebarImageView.frame = CGRectMake(0, 30, 70.5, 482);
    
    [sidebarView addSubview:sidebarImageView];
    
    [self.view addSubview:sidebarView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //initialize firebase
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
    [self.drinksTableView setRowHeight:25];
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 20)];
    [label setFont:[UIFont fontWithName:@"hiragino kaku gothic pro" size:15]];
    
    // TODO: replace this with name of type of drink being queried for in firebase
    //NSString *string =[list objectAtIndex:section];
    //[label setText:string];
    
    [label setText:category];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor whiteColor]];
     return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [self.drinksDataSource objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:10];
    return cell;
}


@end

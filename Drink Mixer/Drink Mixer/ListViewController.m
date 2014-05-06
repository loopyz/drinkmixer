//
//  ListViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/5/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "ListViewController.h"

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define SIDEBAR_OFFSET 65

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Initialize data source TODO: populate with firebase
        self.drinksDataSource = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", nil];
        NSLog(@"self.drinksDataSource intialized as %@", self.drinksDataSource);
        
//        CGRect screenRect = [[UIScreen mainScreen] bounds];
//        CGFloat screenWidth = screenRect.size.width;
//        CGFloat screenHeight = screenRect.size.height;
//        
//        // Add image label for drink category
//        UIView *categoryLabel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenHeight, screenWidth)];
//        UIImageView *categoryLabelImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"categoryLabel.png"]];
//        categoryLabelImage.frame = CGRectMake(SIDEBAR_OFFSET, 0, categoryLabelImage.frame.size.width-SIDEBAR_OFFSET, categoryLabelImage.frame.size.height);
//        [categoryLabel addSubview:categoryLabelImage];
//        
//        [self.view addSubview:categoryLabel];
        
        [self initSidebar];
        
    }
    return self;
}

- (void)initSidebar
{
    // Add sidebar on left of screen
    
    UIView *sidebarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
    UIImageView *sidebarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebar.png"]];
    sidebarImageView.frame = CGRectMake(0, 0, sidebarImageView.frame.size.width/2, sidebarImageView.frame.size.height);
    [sidebarView addSubview:sidebarImageView];
    
    [self.view addSubview:sidebarView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //  Setup for drinks list tableView
    CGRect tableViewRect = CGRectMake(SIDEBAR_OFFSET, 0, SCREEN_WIDTH-SIDEBAR_OFFSET, SCREEN_HEIGHT);
    self.drinksTableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    self.drinksTableView.separatorStyle=UITableViewCellSeparatorStyleNone; // Get rid of bars separating sections
    self.drinksTableView.delegate = self;
    self.drinksTableView.dataSource = self;
    [self.drinksTableView reloadData];
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
    
    [label setText:@"TESTING"];
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
    cell.textLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:12];
    return cell;
}


@end

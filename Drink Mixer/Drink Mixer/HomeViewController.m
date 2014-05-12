//
//  HomeViewController.m
//  Drink Mixer
//
//  Created by Lucy Guo on 4/22/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "ShareViewController.h"
#import <Firebase/Firebase.h>


#define firebaseURL @"https://drinkmixer.firebaseio.com/"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //hardcoded images YAY
        self.images = [[NSArray alloc] initWithObjects: @"berrybubbly.png", @"greenberrybomb.png", @"passionmint.png", @"rosewatercooler.png", @"shakeupberry.png", @"strawberryshort.png", nil];
        
        [self initializeNavBar];
        
        //[self addBackgroundImage];
        
        self.view.backgroundColor = [UIColor whiteColor];

        
        
    }
    return self;
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
    titleImageView.frame = CGRectMake(59, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
    // Right bar button item to launch the categories selection screen.
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tinycup.png"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(launchCategories)];
    
    rbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.5];
    self.navigationItem.rightBarButtonItem = rbb;
}

- (void)launchShare
{
    ShareViewController *svc = [[ShareViewController alloc] init];
    [self.navigationController pushViewController:svc animated:NO];
}

- (void)launchCategories
{
    CategoryViewController *cvc = [[CategoryViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    //initialize firebase
    self.firebase = [[Firebase alloc] initWithUrl:firebaseURL];
    
    Firebase *ref = [[self.firebase childByAppendingPath:@"drinks"] childByAppendingPath:@"Refreshers"];
    
    self.drinkKeys = [[NSMutableArray alloc] init];
    
    [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        NSString* ingredient = snapshot.name;
        [self.drinkKeys addObject:ingredient];
        NSLog(@"Drink Keys Count: %lu", (unsigned long)[self.drinkKeys count]);
        [_collectionView reloadData];
        
    }];
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20); //  Top, left, bottom, right
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(-8, 0, frame.size.width + 13, frame.size.height)  collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1.0]];
    
    [self.view addSubview:_collectionView];
    
    NSLog(@"collection view added?!?");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addBackgroundImage
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 326.4, 120.36)];
    imgView.image = [UIImage imageNamed:@"profile.png"];
    [self.view addSubview:imgView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"drink keys count %d", [self.drinkKeys count]);
    return [self.drinkKeys count];
    //return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier"
                                                                         forIndexPath:indexPath];
    
    NSString* key = [self.drinkKeys objectAtIndex:indexPath.row];
    NSDictionary* drink = self.myDrinks[key];
    
    
    
    NSString *image = self.images[indexPath.row % [self.images count]];
    
    // TODO: query firebase for actual drink image and use it here
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:image]];
    
    UILabel *label = (UILabel*)[cell.contentView viewWithTag:1];
    
//    if (!label) {
//        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, 280, 25)];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.textColor = [UIColor colorWithRed:46.0/255.0 green:63.0/255.0 blue:81.0/255.0 alpha:1.0];
//        label.tag = 1;
//        [cell.contentView addSubview:label];
//    }
//    
//    label.text = self.myDrinks[[self.drinkKeys objectAtIndex:indexPath.row]][@"name"];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* key = [self.drinkKeys objectAtIndex:indexPath.row];
    NSDictionary* drink = self.myDrinks[key];
    
    NSLog(@"SELECTED ITEM %@", drink);
    
    // TODO: launch new screen for displaying how to mix the given drink
    
    [collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    //return CGSizeMake(screenWidth/2 - 100, screenHeight/4);
    return CGSizeMake(140, 140);
}


@end

//
//  HomeViewController.m
//  Drink Mixer
//
//  Created by Lucy Guo on 4/22/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "HomeViewController.h"
#import "CategoriesViewController.h"
#import "ShareViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initializeNavBar];
        
        [self addBackgroundImage];
        
        self.firebase = [[Firebase alloc] initWithUrl:firebaseURL];
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
    titleImageView.frame = CGRectMake(43, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
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
    CategoriesViewController *cvc = [[CategoriesViewController alloc] init];
    [self.navigationController pushViewController:cvc animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    Firebase* ref = [self.firebase childByAppendingPath:@"drinks"];

    [ref observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        self.myDrinks = snapshot.value;
        self.drinkKeys = self.myDrinks.allKeys;
        [_collectionView reloadData];
    }];
    NSLog(@"meep %@", self.myDrinks);
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20); //  Top, left, bottom, right
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.height-100, frame.size.width)  collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView setBackgroundColor:[UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1.0]];
    
    [self.view addSubview:_collectionView];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.drinkKeys count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier"
                                                                         forIndexPath:indexPath];
    
    NSString* key = [self.drinkKeys objectAtIndex:indexPath.row];
    NSDictionary* drink = self.myDrinks[key];
    
    // TODO: query firebase for actual drink image and use it here
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cup.png"]];
    
    UILabel *label = (UILabel*)[cell.contentView viewWithTag:1];
    
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, 280, 25)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:46.0/255.0 green:63.0/255.0 blue:81.0/255.0 alpha:1.0];
        label.tag = 1;
        [cell.contentView addSubview:label];
    }
    
    label.text = self.myDrinks[[self.drinkKeys objectAtIndex:indexPath.row]][@"name"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* key = [self.drinkKeys objectAtIndex:indexPath.row];
    NSDictionary* drink = self.myDrinks[key];
    
    // TODO: launch new screen for displaying how to mix the given drink
    
    [collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    return CGSizeMake(screenWidth/2 - 100, screenHeight/4);
}


@end

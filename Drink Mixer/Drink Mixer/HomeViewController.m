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
#import "MakeItViewController.h"
#import "NSStrinAdditions.h"
#import <Firebase/Firebase.h>


#define firebaseURL @"https://drinkmixer.firebaseio.com/"
#define favoritesURL @"https://drinkmixer.firebaseio.com/users/lguo/favorites/"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Default images for while Firebase is loading
        self.images = [[NSMutableArray alloc] initWithObjects:[UIImage imageNamed:@"berrybubbly.png"], [UIImage imageNamed:@"greenberrybomb.png"], [UIImage imageNamed:@"passionmint.png"], [UIImage imageNamed:@"rosewatercooler.png"], [UIImage imageNamed:@"shakeupberry.png"], [UIImage imageNamed:@"strawberryshort.png"], nil];
        
        [self initializeNavBar];
        
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
    
    self.firebase = [[Firebase alloc] initWithUrl:favoritesURL];
    
    self.drinkNames = [[NSMutableArray alloc] init];
    self.drinkCategories = [[NSMutableArray alloc] init];
    
    [self.firebase observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
        [self.drinkNames addObject:snapshot.name];
        [self.drinkCategories addObject:[snapshot.value objectForKey:@"Category"]];
    
        if ([snapshot.value objectForKey:@"Image"]) {
            UIImage *image = [[UIImage alloc] initWithData:[self base64DataFromString:[snapshot.value objectForKey:@"Image"]]];
            [self.images replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndex:([self.drinkNames count]-1)] withObjects:@[image]];
        }
        
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
}

- (NSData *)base64DataFromString: (NSString *)string {
    unsigned long ixtext, lentext;
    unsigned char ch, input[4], output[3];
    short i, ixinput;
    Boolean flignore, flendtext = false;
    const char *temporary;
    NSMutableData *result;
    
    if (!string) {
        return [NSData data];
    }
    
    ixtext = 0;
    
    temporary = [string UTF8String];
    
    lentext = [string length];
    
    result = [NSMutableData dataWithCapacity: lentext];
    
    ixinput = 0;
    
    while (true) {
        if (ixtext >= lentext) {
            break;
        }
        
        ch = temporary[ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        } else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        } else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        } else if (ch == '+') {
            ch = 62;
        } else if (ch == '=') {
            flendtext = true;
        } else if (ch == '/') {
            ch = 63;
        } else {
            flignore = true;
        }
        
        if (!flignore) {
            short ctcharsinput = 3;
            Boolean flbreak = false;
            
            if (flendtext) {
                if (ixinput == 0) {
                    break;
                }
                
                if ((ixinput == 1) || (ixinput == 2)) {
                    ctcharsinput = 1;
                } else {
                    ctcharsinput = 2;
                }
                
                ixinput = 3;
                
                flbreak = true;
            }
            
            input[ixinput++] = ch;
            
            if (ixinput == 4) {
                ixinput = 0;
                
                unsigned char0 = input[0];
                unsigned char1 = input[1];
                unsigned char2 = input[2];
                unsigned char3 = input[3];
                
                output[0] = (char0 << 2) | ((char1 & 0x30) >> 4);
                output[1] = ((char1 & 0x0F) << 4) | ((char2 & 0x3C) >> 2);
                output[2] = ((char2 & 0x03) << 6) | (char3 & 0x3F);
                
                for (i = 0; i < ctcharsinput; i++) {
                    [result appendBytes: &output[i] length: 1];
                }
            }
            
            if (flbreak) {
                break;
            }
        }
    }
    
    return result;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.drinkNames count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier"
                                                                         forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithPatternImage:self.images[indexPath.row]];
    
    
    UILabel *label = (UILabel*)[cell.contentView viewWithTag:1];
    
    NSString* name = [self.drinkNames objectAtIndex:indexPath.row];
    NSString* category = [self.drinkCategories objectAtIndex:indexPath.row];
    
    UIView *box = [[UIView alloc] initWithFrame:CGRectMake(0, 120, 140, 30)];
    box.backgroundColor = [UIColor whiteColor];
    box.alpha  = .4;
    [cell addSubview:box];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 115, 140, 30)];
    nameLabel.text = name;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:12];

    [cell addSubview:nameLabel];
    
    

    
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
    
    NSString* name = [self.drinkNames objectAtIndex:indexPath.row];
    NSString* category = [self.drinkCategories objectAtIndex:indexPath.row];
    
    MakeItViewController *mvc = [[MakeItViewController alloc] initCustom:@[category, name]];
    [self.navigationController pushViewController:mvc animated:NO];
    
    [collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(140, 140);
}





@end

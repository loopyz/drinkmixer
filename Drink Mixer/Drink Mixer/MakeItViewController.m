//
//  MakeItViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/9/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "MakeItViewController.h"
#import "RecipeViewController.h"
#import <Firebase/Firebase.h>

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define firebaseURL @"https://drinkmixer.firebaseio.com/"

@interface MakeItViewController ()
{
    NSMutableArray *recipe;
    int ingredientCount;
    Firebase* firebase;
    NSString *name;
    Firebase *ref;
    NSMutableDictionary *drinkInfo;
}
@end

@implementation MakeItViewController

- (id)initCustom:(NSArray *)parameters
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        recipe = [[NSMutableArray alloc] initWithObjects:nil];
        
        name = [parameters objectAtIndex:1];
        
        ref = [[[firebase childByAppendingPath:@"drinks"] childByAppendingPath:[parameters objectAtIndex:0]] childByAppendingPath:name];

        UILabel *drinkName = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 280, 25)];
        drinkName.textAlignment = NSTextAlignmentLeft;
        drinkName.textColor = [UIColor colorWithRed:46.0/255.0 green:63.0/255.0 blue:81.0/255.0 alpha:1.0];
        drinkName.text = name;
        [self.view addSubview:drinkName];
        
        drinkInfo = [[NSMutableDictionary alloc] init];
        
        // Query Firebase to get ingredients
        [ref observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
            NSString* ingredient = snapshot.name;
            [recipe addObject:ingredient];
            [drinkInfo setObject:snapshot.value forKey:snapshot.name];
            [self updateRecipe];
            ingredientCount += 1;
        }];
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nibBundleOrNil];

    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lemonade.jpg"]];
        [self initMakeButton];
        [self initLogo];
        
        ingredientCount = 1;
        
        firebase = [[Firebase alloc] initWithUrl:firebaseURL];

    }
    return self;
}

- (void)updateRecipe
{
    UILabel *label = (UILabel*)[self.view viewWithTag:ingredientCount];
    
    if (!label) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(50, 180 + ingredientCount * 30, 280, 25)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorWithRed:46.0/255.0 green:63.0/255.0 blue:81.0/255.0 alpha:1.0];
        label.tag = ingredientCount;
        [self.view addSubview:label];
    }

    // NOTE: DO NOT CHANGE THE -1 ON ingredientCount HERE. Turns out tag 0 defaults to the UIView itself. *cries*
    label.text = [NSString stringWithFormat:@"%@", [recipe objectAtIndex:(ingredientCount-1)]];
}

- (void)initLogo
{
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navlogo.png"]];
    titleImageView.frame = CGRectMake(43, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    
    titleImageView.alpha = .5;
    
    self.navigationItem.titleView = logoView;
}

- (void)initMakeButton
{
    UIButton *makeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *makeButtonImage = [UIImage imageNamed:@"makeButton.png"];
    [makeButton setBackgroundImage:makeButtonImage forState:UIControlStateNormal];
    int buttonWidth = 200;
    makeButton.frame = CGRectMake(SCREEN_WIDTH/2 - buttonWidth/2, SCREEN_HEIGHT - 130, buttonWidth, 50);
    [makeButton addTarget:self action:@selector(launchRecipeScreen) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:makeButton];
}

- (void)launchRecipeScreen
{
    RecipeViewController *rvc = [[RecipeViewController alloc] initWithDrinkInfo:drinkInfo];
    [self.navigationController pushViewController:rvc animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

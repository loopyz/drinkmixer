//
//  RecipeViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/9/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "RecipeViewController.h"
#include <stdlib.h>

#define SCREEN_HEIGHT 568.0 - 62 // iPhone 5 screen height - navbar height
#define SCREEN_WIDTH 320

@interface RecipeViewController ()

@end

@implementation RecipeViewController

- (id)initWithDrinkInfo:(NSDictionary *)info
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self initLogo];
        
        int total = 0;
        NSMutableArray *ingredients = [[NSMutableArray alloc] initWithObjects:nil];
        NSMutableArray *amounts = [[NSMutableArray alloc] initWithObjects:nil];
        for (NSString *key in [info allKeys]) {
            [ingredients addObject:key];
            [amounts addObject:[info objectForKey:key]];
            total += [[info objectForKey:key] integerValue];
        }
        
        int soFar = 0;
        float multiplier = (SCREEN_HEIGHT*1.0)/total;
        int y;
        NSArray *colors = @[[UIColor colorWithRed:0.616 green:0.114 blue:0.125 alpha:1], [UIColor colorWithRed:0.953 green:0.604 blue:0.761 alpha:1], [UIColor colorWithRed:0.004 green:0.651 blue:0.31 alpha:1], [UIColor colorWithRed:0.478 green:0.8 blue:0.784 alpha:1], [UIColor colorWithRed:0 green:0.682 blue:0.937 alpha:1], [UIColor colorWithRed:0.965 green:0.557 blue:0.337 alpha:1], [UIColor colorWithRed:0.62 green:0 blue:0.224 alpha:1]];
        
        for (int i = 0; i < [ingredients count]; i ++ ) {
            y = [[amounts objectAtIndex:i] integerValue] * multiplier;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, soFar, SCREEN_WIDTH, y)];
            view.backgroundColor = [colors objectAtIndex:(arc4random() %[colors count])]; // Random colors for each ingredient
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, y)];
            label.text = [ingredients objectAtIndex:i];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont fontWithName:@"hiragino kaku gothic pro" size:20];
            label.textColor = [UIColor whiteColor];
            [view addSubview:label];
            [self.view addSubview:view];
            soFar += y;
        }
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MakeItViewController.m
//  Drink Mixer
//
//  Created by Angela Zhang on 5/9/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import "MakeItViewController.h"

#define SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)


@interface MakeItViewController ()

@end

@implementation MakeItViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lemonade.jpg"]];
        
        // Make semi transparent white rectangle for writing ingredients on top of
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextStrokePath(context);
        CGContextSetRGBFillColor(context, 0.8, 1.0, 0.0, 0.5);
        
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetLineWidth(context, 5.0f);
        CGContextStrokeRect(context, CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT));
        
        CGContextFillRect(context, CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT));
        
        [self initMakeButton];
    }
    return self;
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
    NSLog(@"user hit the make it button!");
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

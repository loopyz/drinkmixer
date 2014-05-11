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
#import "UIImage+ImageEffects.h"

#define SCREEN_HEIGHT 568.0 - 62 // iPhone 5 screen height - navbar height
#define SCREEN_WIDTH 320


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

        UILabel *drinkName = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 280, 25)];
        drinkName.textAlignment = NSTextAlignmentLeft;
        drinkName.textColor = [UIColor whiteColor];
        drinkName.text = name;
        drinkName.layer.shadowColor = [[UIColor blackColor] CGColor];
        drinkName.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        drinkName.layer.shadowOpacity = 1.0 * pow(22.0 / (double)28, 3.0); // too much work?
        drinkName.font = [UIFont systemFontOfSize:28];
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
        //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lemonade.jpg"]];
        
        
        UIImage *bg = [UIImage imageNamed:@"lemonade.jpg"];
        
        
        //blurring image on bottom
        UIImage *croppedImage = [bg crop:CGRectMake(0, 300, SCREEN_WIDTH, 270)];
        //UIImage *croppedImage = [self cropImage:bg fromRect:CGRectMake(0, 300, SCREEN_WIDTH, 270)];
        UIImage *blurredbg = [croppedImage applyLightEffect];
        UIImageView *blurredView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 270)];
        blurredView.image = blurredbg;
        [self.view addSubview:blurredView];

        [self drawRect];

        
        self.view.backgroundColor = [UIColor colorWithPatternImage:bg];
        
        //blured image code?
        //    UIImage *bg = [[UIImage imageNamed:@"adrenaline-bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0];
        //    UIImage *blurredbg = [bg applyDarkEffect];
        
        
        //    cell.backgroundView = [[UIImageView alloc] initWithImage:blurredbg];
        //    cell.selectedBackgroundView =  [[UIImageView alloc] initWithImage: blurredbg];
        
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
        label = [[UILabel alloc] initWithFrame:CGRectMake(50, 240 + ingredientCount * 30, 280, 25)];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor colorWithRed:46.0/255.0 green:63.0/255.0 blue:81.0/255.0 alpha:1.0];
        label.tag = ingredientCount;
        [self.view addSubview:label];
    }

    // NOTE: DO NOT CHANGE THE -1 ON ingredientCount HERE. Turns out tag 0 defaults to the UIView itself. *cries*
    label.text = [NSString stringWithFormat:@"%@", [recipe objectAtIndex:(ingredientCount-1)]];
    label.textColor = [UIColor whiteColor];
}

- (void)drawRect
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 270)];
    
    //UIColor * color = [UIColor colorWithRed:190/255.0f green:190/255.0f blue:190/255.0f alpha:1.0f];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = .3;
    [self.view addSubview:view];
    
}

-(UIImage *)cropImage:(UIImage *)img fromRect:(CGRect)rect
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    if (scale > 1.0f) {
        rect = CGRectMake(rect.origin.x * scale,
                          rect.origin.y * scale,
                          rect.size.width * scale,
                          rect.size.height * scale);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(img.CGImage, rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:scale orientation:img.imageOrientation];
    CGImageRelease(imageRef);
    return result;
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
    makeButton.frame = CGRectMake(0, SCREEN_HEIGHT - 130, 320, 52);
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

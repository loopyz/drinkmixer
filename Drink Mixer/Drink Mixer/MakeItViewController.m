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
    bool favorited;
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
            if ([snapshot.name isEqual: @"image"]) { // Update background image from Firebase
                NSData *dataFromBase64=[self base64DataFromString:snapshot.value];
                UIImage *image = [[UIImage alloc]initWithData:dataFromBase64];
                
                UIImage *croppedImage = [image crop:CGRectMake(0, 300, SCREEN_WIDTH, 270)];
                UIImage *blurredbg = [croppedImage applyLightEffect];
                UIImageView *blurredView = (UIImageView*)[self.view viewWithTag:391];
                blurredView.image = blurredbg;
                
                self.view.backgroundColor = [UIColor colorWithPatternImage:image];
            } else {  // Update ingredients list
                NSString* ingredient = snapshot.name;
                [recipe addObject:ingredient];
                [drinkInfo setObject:snapshot.value forKey:snapshot.name];
                [self updateRecipe];
                ingredientCount += 1;
            }
        }];
        
        //FIREBASE STUFF
        NSString *url = @"https://drinkmixer.firebaseio.com/users/lguo/favorites/";
        NSString *drinkURL = [url stringByAppendingString:name];
        
        Firebase* ref = [[Firebase alloc] initWithUrl:drinkURL];
        
        [ref observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            if(snapshot.value == [NSNull null]) {
                NSLog(drinkURL);
                favorited = false;
            } else {
//                NSString* firstName = snapshot.value[@"name"][@"first"];
//                NSString* lastName = snapshot.value[@"name"][@"last"];
//                NSLog(@"User julie's full name is: %@ %@", firstName, lastName);
                NSLog(@"drink is favorited");
                favorited = true;
            }
        }];
        
        
        //favorited = false; // TODO: query Firebase for this and update it
    }
    
    return self;
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nibBundleOrNil];

    if (self) {
        UIImage *bg = [UIImage imageNamed:@"lemonade.jpg"];
        
        //blurring image on bottom
        UIImage *croppedImage = [bg crop:CGRectMake(0, 300, SCREEN_WIDTH, 270)];
        //UIImage *croppedImage = [self cropImage:bg fromRect:CGRectMake(0, 300, SCREEN_WIDTH, 270)];
        UIImage *blurredbg = [croppedImage applyLightEffect];
        UIImageView *blurredView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 270)];
        blurredView.image = blurredbg;
        blurredView.tag = 391;
        [self.view addSubview:blurredView];

        [self drawRect];

        
        self.view.backgroundColor = [UIColor colorWithPatternImage:bg];

        
        [self initMakeButton];
        [self initLogo];
        [self initFavButton];
        
        ingredientCount = 1;
        
        firebase = [[Firebase alloc] initWithUrl:firebaseURL];

    }
    return self;
}

/*- (UIImage *)blurImage:(UIImage *)image
{
    
}*/

- (void)initFavButton
{
    UIBarButtonItem *rbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"favorite-faded.png"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(favDrink)];
    rbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = rbb;
}

// TODO: write to firebase associated with user if current drink is favorited or not
- (void)favDrink
{
    if (favorited) { // Currently favorited, user is tapping to un-favorite
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"favorite-faded.png"];
        favorited = false;
        NSString *url = @"https://drinkmixer.firebaseio.com/users/lguo/favorites/";
        NSString *drinkURL = [url stringByAppendingString:name];
        
        Firebase* ref = [[Firebase alloc] initWithUrl:drinkURL];
        
        [ref removeValue];
        
    } else {
        self.navigationItem.rightBarButtonItem.image = [UIImage imageNamed:@"favorite.png"];
        favorited = true;
        
        Firebase* ref = [[Firebase alloc] initWithUrl:@"https://drinkmixer.firebaseio.com/users/lguo/favorites"];

        [[ref childByAppendingPath:name] setValue:@"true"];
        
    }
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
    titleImageView.frame = CGRectMake(59, 8, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    
    UIButton *homeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    homeButton.frame = CGRectMake(0, 0, 200, 44);
    [homeButton addTarget:self
                   action:@selector(launchHome)
         forControlEvents:UIControlEventTouchUpInside];
    [logoView addSubview:homeButton];
    
    titleImageView.alpha = .5;
    
    self.navigationItem.titleView = logoView;
}

- (void)launchHome
{
    [self.navigationController popToRootViewControllerAnimated:NO];
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

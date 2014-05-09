//
//  CategoryViewController.h
//  Drink Mixer
//
//  Created by Lucy Guo on 5/5/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface CategoryViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *refreshersButton;
@property (strong, nonatomic) IBOutlet UIButton *coffeeButton;
@property (strong, nonatomic) IBOutlet UIButton *shakesButton;
@property (strong, nonatomic) IBOutlet UIButton *juiceButton;


@property (nonatomic, strong) Firebase* firebase;
@property (nonatomic, strong) NSArray *drinkKeys;

@end

//
//  CategoriesViewController.h
//  Drink Mixer
//
//  Created by Angela Zhang on 5/4/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface CategoriesViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UIButton *cocktailsButton;
@property (strong, nonatomic) IBOutlet UIButton *smoothiesButton;
@property (strong, nonatomic) IBOutlet UIButton *proteinButton;
@property (strong, nonatomic) IBOutlet UIButton *otherButton;



@property (nonatomic, strong) NSMutableArray *drinksDataSource;
@property (nonatomic, strong) UITableView *drinksTableView;

@property (nonatomic, strong) Firebase* firebase;
@property (nonatomic, strong) NSArray *drinkKeys;


@end

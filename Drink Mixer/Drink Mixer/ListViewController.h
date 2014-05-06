//
//  ListViewController.h
//  Drink Mixer
//
//  Created by Angela Zhang on 5/5/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

@interface ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *drinksDataSource;
@property (nonatomic, strong) UITableView *drinksTableView;

@property (nonatomic, strong) Firebase* firebase;
@property (nonatomic, strong) NSArray *drinkKeys;

@end

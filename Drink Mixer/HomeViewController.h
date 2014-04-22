//
//  HomeViewController.h
//  Drink Mixer
//
//  Created by Angela Zhang on 4/22/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>
#import <FacebookSDK/FacebookSDK.h>

@interface HomeViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray* interests;
@property (nonatomic, strong) Firebase* firebase;

@property (nonatomic) bool done;

@end

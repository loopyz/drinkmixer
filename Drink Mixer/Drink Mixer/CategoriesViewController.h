//
//  CategoriesViewController.h
//  Drink Mixer
//
//  Created by Angela Zhang on 5/4/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>

#define firebaseURL @"https://something.firebaseio.com/" //TODO: change this to real thing!

@interface CategoriesViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@property (strong, nonatomic) IBOutlet UIButton *cocktailsButton;
@property (strong, nonatomic) IBOutlet UIButton *smoothiesButton;
@property (strong, nonatomic) IBOutlet UIButton *proteinButton;
@property (strong, nonatomic) IBOutlet UIButton *otherButton;

@property (nonatomic, strong) Firebase *firebase;
@property (nonatomic, strong) NSDictionary *myDrinks;
@property (nonatomic, strong) NSArray *drinkKeys;


@end

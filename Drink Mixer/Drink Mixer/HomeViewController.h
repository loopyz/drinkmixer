//
//  HomeViewController.h
//  Drink Mixer
//
//  Created by Lucy Guo on 4/22/14.
//  Copyright (c) 2014 Angela Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase/Firebase.h>



@interface HomeViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}

@property (nonatomic, strong) Firebase* firebase;
@property (nonatomic, strong) NSMutableArray *drinkCategories;
@property (nonatomic, strong) NSMutableArray *drinkNames;

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) NSMutableArray *drinksDataSource;

@end

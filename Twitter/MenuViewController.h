//
//  MenuViewController.h
//  Twitter
//
//  Created by Liz Chaddock on 9/28/15.
//  Copyright (c) 2015 Liz Chaddock. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate;

@interface MenuViewController : UIViewController

@property (nonatomic, weak) id <MenuViewControllerDelegate> delegate;

@end

@protocol MenuViewControllerDelegate

-(void)menuViewControllerDidFinishWithCategoryId:(NSInteger)categoryId;

@end


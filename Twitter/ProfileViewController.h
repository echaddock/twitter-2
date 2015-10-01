//
//  ProfileViewController.h
//  Twitter
//
//  Created by Liz Chaddock on 9/29/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "User.h"

@interface ProfileViewController : UIViewController

@property User* user;
@property SWRevealViewController *revealViewController;

@end

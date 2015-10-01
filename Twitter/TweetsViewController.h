//
//  TweetsViewController.h
//  Twitter
//
//  Created by Liz Chaddock on 9/23/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "SWRevealViewController.h"

@protocol TweetsViewControllerDelegate;

@interface TweetsViewController : UIViewController

@property User* user;
@property SWRevealViewController *revealViewController;
@property (nonatomic, weak) id <TweetsViewControllerDelegate> delegate;


@end

@protocol TweetsViewControllerDelegate

-(void)tweetsViewControllerDidFinishWithUser:(User *)user;

@end

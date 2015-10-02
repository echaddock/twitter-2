//
//  TweetCell.h
//  Twitter
//
//  Created by Liz Chaddock on 9/23/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetsViewController.h"

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet * tweet;
@property (nonatomic, weak) TweetsViewController *delegate;

@end

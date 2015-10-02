//
//  TweetCell.m
//  Twitter
//
//  Created by Liz Chaddock on 9/23/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ProfileViewController.h"
#import "TweetsViewController.h"

@interface TweetCell ()
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) User *user;
@end

@implementation TweetCell

- (void)awakeFromNib {
    [self.tweetImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)]];
}

- (void)onTap:(UITapGestureRecognizer *)sender {
    ProfileViewController *pvc = [[ProfileViewController alloc] init];
    pvc.user = _user;
    TweetsViewController *tvc = self.delegate;
    [tvc.navigationController pushViewController:pvc animated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet
{
    if(tweet) {
        _tweet = tweet;
        if(_tweet.imageURL) {
            [self.tweetImage setImageWithURL:[NSURL URLWithString:_tweet.imageURL]];
        }
        self.tweetLabel.text = _tweet.text;
        self.nameLabel.text = _tweet.name;
        self.twitterHandleLabel.text = _tweet.twitterHandle;
        self.createAtLabel.text = _tweet.createdAt;
        self.user = _tweet.user;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
}

@end

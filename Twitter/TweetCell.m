//
//  TweetCell.m
//  Twitter
//
//  Created by Liz Chaddock on 9/23/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell ()
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet
{
    if(tweet) {
    //if(NO) {
        _tweet = tweet;
        if(_tweet.imageURL) {
            [self.tweetImage setImageWithURL:[NSURL URLWithString:_tweet.imageURL]];
        }
        self.tweetLabel.text = _tweet.text;
        self.nameLabel.text = _tweet.name;
        self.twitterHandleLabel.text = _tweet.twitterHandle;
        self.createAtLabel.text = _tweet.createdAt;
    } else {
        self.tweetLabel.text = @"the best thing ever happened today. I made a twitter app but the data won't show up. and now i have to make fake tweets";
        [self.tweetImage setImageWithURL:[NSURL URLWithString:@"https://pbs.twimg.com/profile_images/613035653203300352/Bz94DZo-_bigger.jpg"]];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
}

@end

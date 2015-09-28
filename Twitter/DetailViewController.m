//
//  DetailViewController.m
//  Twitter
//
//  Created by Liz Chaddock on 9/25/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UITextView *replyTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendReplyButton;

@end

@implementation DetailViewController
- (IBAction)favorite:(id)sender {
    NSLog(@"favorite");
    NSDictionary* dict = @{ @"id": _tweet.tweetID };
    
    [[TwitterClient sharedInstance] favoriteWithParams:dict completion:^(NSArray *response, NSError *error){
        if (!error) {
            [self.favoriteButton setBackgroundImage:[UIImage imageNamed:@"favorite_done"] forState:UIControlStateNormal];
        } else {
            NSLog(@"%@", error);
        }
        NSLog(@"completed");
    }];
}

- (IBAction)reply:(id)sender {
    NSLog(@"reply");
    self.replyTextView.hidden = NO;
    self.sendReplyButton.hidden = NO;
    
    _sendReplyButton.layer.borderWidth=1.0f;
    _sendReplyButton.layer.borderColor=[[UIColor grayColor] CGColor];
    _sendReplyButton.layer.cornerRadius = 10;
    
    [self.replyTextView.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [self.replyTextView.layer setBorderWidth: 1.0];
    [self.replyTextView.layer setCornerRadius:4.0f];
    [self.replyTextView.layer setMasksToBounds:YES];

    self.replyTextView.text = [NSString stringWithFormat:@"%@", self.tweet.twitterHandle];
    [self.replyTextView becomeFirstResponder];
}
- (IBAction)sendReply:(id)sender {
    NSLog(@"reply!");
    NSDictionary* dict = @{ @"status": _replyTextView.text, @"in_reply_to_status_id": _tweet.tweetID };
    [[TwitterClient sharedInstance] tweetWithParams:dict completion:^(NSArray *response, NSError *error){
        if (!error) {
            [self.replyButton setBackgroundImage:[UIImage imageNamed:@"reply_done"] forState:UIControlStateNormal];
        }
        NSLog(@"completed");
    }];
}

- (IBAction)retweet:(id)sender {
    NSLog(@"retweet");
    NSDictionary* dict = @{ @"tweetID": _tweet.tweetID };
    [[TwitterClient sharedInstance] retweetWithParams:dict completion:^(NSArray *response, NSError *error){
        if (!error) {
            [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"retweet_done"] forState:UIControlStateNormal];
        }
        NSLog(@"completed");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.usernameLabel.text = _tweet.name;
    self.twitterHandleLabel.text = _tweet.twitterHandle;
    self.tweetLabel.text = _tweet.text;
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:_tweet.imageURL]];
    self.replyTextView.hidden = YES;
    self.sendReplyButton.hidden = YES;
    self.navigationItem.title = @"Tweet";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.title = @"Home";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

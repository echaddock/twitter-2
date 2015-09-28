//
//  ComposeViewController.m
//  Twitter
//
//  Created by Liz Chaddock on 9/27/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextArea;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameLabel.text = _name;
    self.twitterHandleLabel.text = _twitterHandle;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:_imageURL]];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.title = @"Cancel";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(sendTweet)];

    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendTweet {
    NSDictionary* dict = @{ @"status": _tweetTextArea.text };
    [[TwitterClient sharedInstance] tweetWithParams:dict completion:^(NSArray *response, NSError *error){
        if (!error) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        NSLog(@"completed");
    }];

    
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

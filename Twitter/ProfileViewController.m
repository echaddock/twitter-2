//
//  ProfileViewController.m
//  Twitter
//
//  Created by Liz Chaddock on 9/29/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_user.backgroundImageUrl) {
        [_backgroundImage setImageWithURL:[NSURL URLWithString:_user.backgroundImageUrl]];
    }
    
    [_profileImage setImageWithURL:[NSURL URLWithString:_user.profileImageUrl]];
    _tweetsLabel.text = [NSString stringWithFormat:@"%@", _user.tweets];
    _followingLabel.text = [NSString stringWithFormat:@"%@", _user.following];
    _followersLabel.text = [NSString stringWithFormat:@"%@", _user.followers];
    _nameLabel.text = _user.name;
    _twitterHandleLabel.text = _user.screenname;
    
    SWRevealViewController *svc = (SWRevealViewController *)self.navigationController.parentViewController;
    [self.view addGestureRecognizer:svc.panGestureRecognizer];
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

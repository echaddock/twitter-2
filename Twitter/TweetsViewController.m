//
//  TweetsViewController.m
//  Twitter
//
//  Created by Liz Chaddock on 9/23/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "TweetsViewController.h"
#import "DetailViewController.h"
#import "ComposeViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "TweetCell.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (nonatomic, strong) NSArray *tweets;
    @property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation TweetsViewController

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:85/255.0 green:172/255.0 blue:238/255.0 alpha:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(composeTweet)];
    self.navigationItem.title = @"Home";

    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}forState:UIControlStateNormal];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // Do any additional setup after loading the view from its nib.
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 18;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell setTweet:(Tweet *)(self.tweets[indexPath.row])];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *dvc = [[DetailViewController alloc] init];
    dvc.tweet = (Tweet *)(self.tweets[indexPath.row]);
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)onLogout {
    [User logout];
}

- (void)composeTweet {
    ComposeViewController *cvc = [[ComposeViewController alloc] init];
    cvc.name = _user.name;
    cvc.twitterHandle = _user.screenname;
    cvc.imageURL = _user.profileImageUrl;
    [self.navigationController pushViewController:cvc animated:YES];
}

- (void)onRefresh {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
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

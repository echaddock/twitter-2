//
//  MentionsViewController.m
//  Twitter
//
//  Created by Liz Chaddock on 10/2/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "MentionsViewController.h"
#import "TwitterClient.h"
#import "SWRevealViewController.h"
#import "TweetCell.h"

@interface MentionsViewController () <UITableViewDataSource, UITableViewDelegate>
    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (nonatomic, strong) NSArray *tweets;
@end

@implementation MentionsViewController

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
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    // Do any additional setup after loading the view.
    [[TwitterClient sharedInstance] mentionsWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
    }];
    
    SWRevealViewController *svc = (SWRevealViewController *)self.navigationController.parentViewController;
    [self.view addGestureRecognizer:svc.panGestureRecognizer];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    [cell setTweet:(Tweet *)(self.tweets[indexPath.row])];
    return cell;
}

- (void)viewDidAppear:(BOOL)animated {
    SWRevealViewController *svc = (SWRevealViewController *)self.navigationController.parentViewController;
    [self.view addGestureRecognizer:svc.panGestureRecognizer];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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

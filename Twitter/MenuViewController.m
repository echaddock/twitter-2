//
//  MenuViewController.m
//  Twitter
//
//  Created by Liz Chaddock on 9/28/15.
//  Copyright (c) 2015 Liz Chaddock. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCell.h"
#import "SWRevealViewController.h"
#import "TweetsViewController.h"

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate menuViewControllerDidFinishWithCategoryId:indexPath.row];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"Home";
            break;
        case 1:
            cell.titleLabel.text = @"Profile";
            break;
        case 2:
            cell.titleLabel.text = @"Mentions";
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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

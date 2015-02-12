//
//  TimelineViewController.m
//  twitterApp
//
//  Created by Nadav Golbandi on 2/11/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "TimelineViewController.h"
#import "TweetTableViewCell.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) TweetTableViewCell* prototypeCell;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";

    //update the view controller about the castom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetTableViewCell"];

    [[TwitterClient sharedInstance] homeTimelineWithParam:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        
        // Do any additional setup after loading the view from its nib.
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        //dynamic raw cell high dimension
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogoutButton)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewButton)];
        
    }];

}

- (void) onLogoutButton {
    [User logout];
}

-(void) onNewButton{
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TweetTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
//    TweetTableViewCell* cell = [[TweetCell alloc] init];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _prototypeCell.tweet = self.tweets[indexPath.row];

    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

- (TweetTableViewCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell"];
    }
    return _prototypeCell;
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

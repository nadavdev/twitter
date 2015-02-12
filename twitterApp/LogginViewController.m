//
//  LogginViewController.m
//  twitterApp
//
//  Created by Nadav Golbandi on 2/7/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "LogginViewController.h"
#import "TwitterClient.h"
//#import "TweetsViewController.h"
#import "TimelineViewController.h"

@interface LogginViewController ()
- (IBAction)onLogin:(id)sender;

@end

@implementation LogginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)onLogin:(id)sender {
    
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            //modally present tweet view
            NSLog(@"welcome to %@", user.name);
            [self presentViewController:[[TimelineViewController alloc]init] animated:YES completion:nil];
        }
        else{
            //present the error view to the user
        }
    }];
}
@end

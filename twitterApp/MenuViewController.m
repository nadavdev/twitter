//
//  MenuViewController.m
//  twitterApp
//
//  Created by Nadav Golbandi on 2/16/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//


#import "MenuViewController.h"
#import "TimelineViewController.h"
#import "ProfileViewController.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UIViewController * timelineViewControler;
@property (strong, nonatomic) UIViewController * profileViewControler;
@property (weak, nonatomic) IBOutlet UIView *barView;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIViewController* vc = [[TimelineViewController alloc]init];
    UINavigationController* nvc =[[UINavigationController alloc] initWithRootViewController:vc];

    self.timelineViewControler = nvc;
    self.profileViewControler = [[ProfileViewController alloc]init];
    
    nvc.view.frame = self.contentView.frame;
    [self.contentView addSubview:nvc.view];
//    [self.contentView addSubview:self.profileViewControler.view];
//
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


- (IBAction)onPaneGester:(UIPanGestureRecognizer *)sender {
//    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    
    if(sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"begin");
    }
    else if(sender.state == UIGestureRecognizerStateChanged){
        NSLog(@"cahnge");

    }
    else if(sender.state == UIGestureRecognizerStateEnded){
        NSLog(@"end");

        if(velocity.x > 0 ){
            [UIView animateWithDuration:0.6 animations:^{
                CGRect frame = self.contentView.frame;
                frame.size.width = 200;
                self.barView.frame = frame;
                [self.contentView addSubview:self.barView];
            }];
        }
        else{
            [UIView animateWithDuration:0.6 animations:^{
                self.timelineViewControler.view.frame = self.contentView.frame;
                [self.contentView addSubview:self.timelineViewControler.view];
            }];
        }
    }
}

@end

//
//  TweetTableViewCell.h
//  twitterApp
//
//  Created by Nadav Golbandi on 2/12/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetTableViewCell : UITableViewCell
@property (nonatomic, strong) Tweet* tweet;
@end

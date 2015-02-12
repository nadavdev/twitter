//
//  TweetTableViewCell.m
//  twitterApp
//
//  Created by Nadav Golbandi on 2/12/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTweet:(Tweet *)tweet{
    _tweet = tweet;
    [self.userImageView setImageWithURL: [NSURL URLWithString:self.tweet.user.profileImageUrl]];
    
    self.tweetTextLabel.text = tweet.text;
    self.nameLabel.text = self.tweet.user.name;
    self.loginLabel.text = self.tweet.user.screenname;
    
    NSTimeInterval elapsedTimeInterval = [self.tweet.createdAt timeIntervalSinceNow];
    int elapsedSeconds = (int)(elapsedTimeInterval * -1);
    
    NSLog(@"%d", elapsedSeconds);
    NSString* formattedDateString;
    if (elapsedSeconds < 60) {
        formattedDateString = @"now";
    }
    else if (elapsedSeconds < 3600) {
        int minutes = elapsedSeconds / 60;
        formattedDateString = [NSString stringWithFormat:@"%dm", minutes];
    }
    else if (elapsedSeconds < 86400) {
        int hours = elapsedSeconds / 3600;
        formattedDateString = [NSString stringWithFormat:@"%dh", hours];
    }
    else if (elapsedSeconds < 31536000) {
        int days = elapsedSeconds / 86400;
        formattedDateString = [NSString stringWithFormat:@"%dd", days];
    }
    else {
        int years = elapsedSeconds / 31536000;
        formattedDateString = [NSString stringWithFormat:@"%dyr", years];
    }
    
    self.timeLabel.text = formattedDateString;
}


@end

//
//  TwitterClient.m
//  twitterApp
//
//  Created by Nadav Golbandi on 2/7/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"RNOtaJ7oA5INLaGwSR0hwJ75c";
NSString * const kTwitterConsumerSecret = @"Iv5YSaTJZlGx7wXPXdJOC5EuuYiS2DE0dSUalwq80JRH8FWxp1";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void(^loginCompletion)(User* user, NSError* error);
@end

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if(instance == nil){
            instance = [[TwitterClient alloc]initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}

- (void) loginWithCompletion: (void(^)(User* user, NSError* error)) completion{
    self.loginCompletion = completion;
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got the request token!");
        
        NSURL* authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl];
    } failure:^(NSError *error) {
        NSLog(@"Failed getting the request token!");
        self.loginCompletion(nil, error);
    }];
  
}

-(void) openUrl:(NSURL *)url{
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        NSLog(@"got access token");
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //            NSLog(@"cerrent user: %@", responseObject);
            User* user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            NSLog(@"user name %@", user.name);
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ERROR getting the user");
            self.loginCompletion(nil, error);
        }];
        
//        [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            //            NSLog(@"my tweets: %@", responseObject);
//            NSArray* tweets = [Tweet tweetsWithArray:responseObject];
//            for (Tweet* t in tweets) {
//                NSLog(@"%@ created at %@", t.text, t.createdAt);
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"Error getting the tweets");
//        }];
    } failure:^(NSError *error) {
        NSLog(@"error got access token");
        self.loginCompletion(nil, error);
    }];
    

}

-(void) homeTimelineWithParam: (NSDictionary*) params completion: (void (^) (NSArray* tweets, NSError* error)) completion{
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray* tweets = [Tweet tweetsWithArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

@end

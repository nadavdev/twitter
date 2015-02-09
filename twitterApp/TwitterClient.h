//
//  TwitterClient.h
//  twitterApp
//
//  Created by Nadav Golbandi on 2/7/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager
+ (TwitterClient *) sharedInstance;

- (void) loginWithCompletion: (void(^)(User* user, NSError* error)) completion;
-(void) openUrl: (NSURL*) url;

-(void) homeTimelineWithParam: (NSDictionary*) params completion: (void (^) (NSArray* tweets, NSError* error)) completion;
@end

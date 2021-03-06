//
//  Tweet.m
//  twitterApp
//
//  Created by Nadav Golbandi on 2/8/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id) initWithDictionary:(NSDictionary*)dictionary{
    self = [super init];
    if(self){
        self.text = dictionary[@"text"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        NSString* createdAtStr = dictionary[@"created_at"];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtStr];
    }
    return self;
}

+ (NSArray*) tweetsWithArray: (NSArray*) array{
    NSMutableArray* tweets = [NSMutableArray array];
    
    for (NSDictionary* dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    return tweets;
}

@end

//
//  Tweet.h
//  twitterApp
//
//  Created by Nadav Golbandi on 2/8/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

//@property (nonatomic, strong) NSString* imageUrl;
//@property (nonatomic, strong) NSString* name;
//@property (nonatomic, strong) NSString* loginName;
@property (nonatomic, strong) NSString* text;
@property (nonatomic, strong) NSDate* createdAt;
@property (nonatomic, strong) User* user;


- (id) initWithDictionary:(NSDictionary*)dictionary;

+ (NSArray*) tweetsWithArray: (NSArray*) array;
@end

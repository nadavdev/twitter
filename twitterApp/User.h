//
//  User.h
//  twitterApp
//
//  Created by Nadav Golbandi on 2/8/15.
//  Copyright (c) 2015 Nadav Golbandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* screenname;
@property (nonatomic, strong) NSString* profileImageUrl;
@property (nonatomic, strong) NSString* tagline;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

//
//  Tweet.m
//  Twitter
//
//  Created by Liz Chaddock on 9/23/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
        NSDate *createdAtDate =[formatter dateFromString:dictionary[@"created_at"]];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        self.createdAt = [formatter stringFromDate:createdAtDate];
        self.imageURL =dictionary[@"user"][@"profile_image_url"];
        self.name = dictionary[@"user"][@"name"];
        self.twitterHandle = [NSString stringWithFormat:@"@%@", dictionary[@"user"][@"screen_name"]];
        self.tweetID = dictionary[@"id_str"];
    }
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for(NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

@end

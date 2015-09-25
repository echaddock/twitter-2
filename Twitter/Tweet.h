//
//  Tweet.h
//  Twitter
//
//  Created by Liz Chaddock on 9/23/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *twitterHandle;
@property (nonatomic, strong) NSString *name;

- (id)initWithDictionary: (NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end

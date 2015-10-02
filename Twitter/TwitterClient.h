//
//  TwitterClient.h
//  Twitter
//
//  Created by Liz Chaddock on 9/18/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)mentionsWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)retweetWithParams:(NSDictionary *)params completion:(void (^) (NSArray *response, NSError *error))completion;

- (void)favoriteWithParams:(NSDictionary *)params completion:(void (^) (NSArray *response, NSError *error))completion;

- (void)tweetWithParams:(NSDictionary *)params completion:(void (^)(NSArray *, NSError *))completion;

@end

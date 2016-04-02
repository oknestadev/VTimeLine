//
//  API.h
//  VKaudio
//
//  Created by EugeneYatsenko on 3/17/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKSdk.h"
#import "UserModel.h"
#import "NewsFeedModel.h"
#import "NewsWallModel.h"

@interface API : NSObject

@property(strong,nonatomic) VKAccessToken* accessToken;
@property(strong,nonatomic) NSString* user_id; 

-(void) token:(VKAccessToken*)token;

-(VKAccessToken*) token; 

+(API*) sharedManager;

- (void)  getuser:(NSString*) user onSuccess:(void(^)(NSArray* userArray)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


-(void)  getWallPost:(NSString*)user offset:(NSInteger)offset count:(NSInteger)count onSuccess:(void(^)(NewsWallModel* wall)) success  onFailure:(void(^)(NSError*error)) failure;

-(void)  getAudio:(NSString*)user offset:(NSInteger)offset count:(NSInteger)count onSuccess:(void(^)(NSArray* post)) success  onFailure:(void(^)(NSError*error)) failure;

-(void)  getFeed:(NSInteger)offset count:(NSInteger)count onSuccess:(void(^)(NewsFeedModel* wall))success  onFailure:(void(^)(NSError*error)) failure;


- (void) getFriendsFromUSer:(NSString*)user offset:(NSInteger) offset
                      count:(NSInteger) count
                  onSuccess:(void(^)(NSArray* friends)) success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getGroup:(NSString*)user offset:(NSInteger) offset
            count:(NSInteger) count
        onSuccess:(void(^)(NSArray* getGroup)) success
        onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


@end

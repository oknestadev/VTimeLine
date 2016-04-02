//
//  API.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/17/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "API.h"
#import "VKSdk.h"
#import "UserModel.h"
#import "AFNetworking.h"
#import "WallModel.h"
#import "AudioModel.h"
#import "FeedModel.h"
#import "FrendsModels.h"
#import "GroupsModel.h"






@interface API ()

@property(strong, nonatomic) AFHTTPSessionManager* requestOperation;
@property(strong, nonatomic) NSString* userID;

@end


@implementation API


+ (API*) sharedManager{
    
    static API* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[API alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.requestOperation = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    return self;
}







-(void) token:(VKAccessToken*)token {
    
    self.accessToken = token;
    
    NSLog(@"LOGIIIIN %@", self.accessToken); 
    
}

-(VKAccessToken*) token {
    
    NSLog(@"naaaaaaa %@", self.accessToken);
    
    return self.accessToken;
}



- (void)  getuser:(NSString*) user onSuccess:(void(^)(NSArray* userArray)) success
       onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
   NSString* userID = user?user:self.accessToken.userId;
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                          userID, @"user_ids",
                          @"photo_200_orig, status", @"fields", nil];
    
    
    [self.requestOperation GET:@"users.get" parameters:parametrs progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JASON %@", responseObject);
        
        NSArray* dictArray = [responseObject objectForKey:@"response"];
        
        
        NSMutableArray* array = [NSMutableArray array];
        
        for (NSDictionary* dict in dictArray) {
            UserModel* user =[[UserModel alloc] initWithServerResponse:dict];

            [array addObject:user];
            
        
           // NSLog(@"dict = %@", dict);
        }
        
        if (success) {
            success(array); 
        }
        
        
            
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


-(void) getWallPost:(NSString*)user offset:(NSInteger)offset count:(NSInteger)count onSuccess:(void(^)(NewsWallModel* wall))success  onFailure:(void(^)(NSError*error)) failure {
    
    
    NSString* userID = user?user:self.accessToken.userId;

    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               userID, @"owner_id",
                               @(offset), @"offset",
                               @(count), @"count",
                               @"all", @"filter",
                               @"Photo", @"fields",
                               self.token.accessToken, @"access_token",nil];
    
    [self.requestOperation GET:@"wall.get?v=5.50" parameters:parametrs progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"JAson %@", responseObject);

        NewsWallModel* nw = [[NewsWallModel alloc] initWithServerResponse:responseObject];
       
        
        if (success) {
            success(nw);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
  
    
}


-(void)  getAudio:(NSString*)user offset:(NSInteger)offset count:(NSInteger)count onSuccess:(void(^)(NSArray* audio)) success  onFailure:(void(^)(NSError*error)) failure {
    
    
    NSString* userID = user?user:self.accessToken.userId;
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               userID, @"owner_id",
                               @(offset), @"offset",
                               @(count), @"count",
                               self.token.accessToken, @"access_token", nil];
    
    //NSLog(@"TOKENNNNNN %@",self.token.accessToken );
    
    
    [self.requestOperation GET:@"audio.get?v=5.50"  parameters:parametrs progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"JASON AUDIO %@", responseObject);
        
        NSArray* dictArray = [[responseObject objectForKey:@"response"] objectForKey:@"items"];
        
        NSMutableArray* array = [NSMutableArray array];
        
        
        for (NSDictionary* dict in dictArray) {
            AudioModel* audio = [[AudioModel alloc]initWithServerResponse:dict];
            [array addObject:audio];
        }
        
        if (success) {
            success(array);
        }
        
      
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];



}

-(void)  getFeed:(NSInteger)offset count:(NSInteger)count onSuccess:(void(^)(NewsFeedModel* feed))success  onFailure:(void(^)(NSError*error)) failure {
    
    NSDictionary* paraments = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"post", @"filters",
                               @(offset), @"offset",
                               @(count), @"count",
                               @"v", @"5.50",
                               self.token.accessToken, @"access_token",nil];
    
    
    [self.requestOperation GET:@"newsfeed.get" parameters:paraments progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JASON FEED %@", responseObject);

        NSDictionary* responsDict = [NSDictionary dictionaryWithDictionary:[responseObject objectForKey:@"response"]];
        //[[responsDict objectForKey:@"response"]objectForKey:@"items"];
        NewsFeedModel* nf = [[NewsFeedModel alloc] initWithServerResponse:responsDict];
        NSLog(@"nf %@", nf);

        
        if (success) {
            success(nf);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}

- (void) getFriendsFromUSer:(NSString*)user offset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
  
    NSString* userID = user?user:self.accessToken.userId;
    
    NSLog(@"USER ID %@", self.accessToken.userId); 
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               userID, @"user_id",
                               @"name", @"order",
                               @(count), @"count",
                               @(offset), @"offset",
                               @"photo_100", @"fields",
                               @"nom", @"name_case",
                               nil];
    
    
    
     [self.requestOperation GET:@"friends.get" parameters:parametrs progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        
         NSLog(@"JASON Friend %@", responseObject);

        NSArray* dictArray = [responseObject objectForKey:@"response"];

        NSMutableArray* array = [NSMutableArray array];
        for (NSDictionary* dict in dictArray) {
           
            FrendsModels* friend = [[FrendsModels alloc] initWithServerResponse:dict];
            
         
            [array addObject:friend];
            
        }
        
        if (success) {
            success(array);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
    }];

}


- (void) getGroup:(NSString*)user offset:(NSInteger) offset
                      count:(NSInteger) count
                  onSuccess:(void(^)(NSArray* getGroup)) success
                  onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure{
    
     NSString* userID = user?user:self.accessToken.userId;
    
    NSDictionary* parametrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               userID, @"user_id",
                               @"1", @"extended",
                               @(offset), @"offset",
                               @(count), @"count" ,
                               self.token.accessToken, @"access_token",nil];
    
    [self.requestOperation GET:@"groups.get?v=5.50" parameters:parametrs progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"JSON GROUP %@", responseObject);
        NSArray* arrayDict = [[responseObject objectForKey:@"response"] objectForKey:@"items"];
        
        NSLog(@"JSON GROUP %@", arrayDict);
        
        NSMutableArray* array = [NSMutableArray array];
        
        for (NSDictionary* dict in arrayDict) {
            GroupsModel* groups = [[GroupsModel alloc]initWithServerResponse:dict];
            [array addObject:groups];
            
            NSLog(@"%@ %@ %@", groups.groupName, groups.groupID, groups.groupImageURL);
        }
        
       
        if (success) {
            success(array);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
    
    
}

@end

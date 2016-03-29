//
//  NewsFeedModel.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/24/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "NewsFeedModel.h"
#import "FeedModel.h"
#import "UserModel.h"
#import "GroupsModel.h"

@implementation NewsFeedModel

-(id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super initWithServerResponse:responseObject];
    
    NSMutableDictionary* peopleDict = [NSMutableDictionary dictionary];
    for (NSDictionary* dict in [responseObject objectForKey:@"profiles"]) {
        
        NSLog(@" dict ------ %@", dict);
        UserModel* userMod = [[UserModel alloc] initWithServerResponse:dict];
        
        [peopleDict setObject:userMod forKey:[dict objectForKey:@"uid"]];
    }
    self.profiles = peopleDict;
    
    NSMutableDictionary* groupDict = [NSMutableDictionary dictionary];
    for (NSDictionary* dict in [responseObject objectForKey:@"groups"]) {
        GroupsModel* groupMod = [[GroupsModel alloc]initWithServerResponse:dict];
        
        [groupDict setObject:groupMod forKey:[dict objectForKey:@"gid"]]; 
    }
    
    self.groups = groupDict;
    
    NSMutableArray* feedArray = [NSMutableArray array];
    for (NSDictionary* dict in [responseObject objectForKey:@"items"]) {

        FeedModel* feed = [[FeedModel alloc] initWithServerResponse:dict];
        
        NSLog(@"%@ ", dict);
        
        
        [feedArray addObject:feed];
    }
    self.items = feedArray;
    return self;
}

@end

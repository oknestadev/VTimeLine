
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
#import "AttachmentsModel.h"

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
        
         NSLog(@" attachments - %@", groupMod);
        
        [groupDict setObject:groupMod forKey:[dict objectForKey:@"gid"]]; 
    }
    
    self.groups = groupDict;
    

    NSMutableArray* feedArray = [NSMutableArray array];
    for (NSDictionary* dict in [responseObject objectForKey:@"items"]){
        
        FeedModel* feed = [[FeedModel alloc] initWithServerResponse:dict];
        
       
        
        NSLog(@"%@ ", dict);
        
        
        [feedArray addObject:feed];
    }
    self.items = feedArray;
    
    
    NSMutableDictionary* attachmentsDict = [NSMutableDictionary dictionary];
    for (NSDictionary* dict in [responseObject objectForKey:@"items"]) {
        
     
        
        if ([dict objectForKey:@"attachments"]) {
            
            for (NSDictionary* dictAttachs in [dict objectForKey:@"attachments"]) {
                
                AttachmentsModel* attachments = [[AttachmentsModel alloc] initWithServerResponse:dictAttachs];
                
               
                
                
                [attachmentsDict setObject:attachments forKey:[dict objectForKey:@"source_id"]];
                
                NSLog(@" attachments - %@", attachmentsDict);

            }
        } else if ([dict objectForKey:@"attachment"]) {
            for (NSDictionary* dictAttach in [dict objectForKey:@"attachment"]) {
                AttachmentsModel* attachment = [[AttachmentsModel alloc] initWithServerResponse:dictAttach];
                
                [attachmentsDict setObject:attachment forKey:[dict objectForKey:@"source_id"]];
                
                NSLog(@"attachment - %@", attachmentsDict);
            }
            
        }

    }


    self.attachments = attachmentsDict;
    
    
    
    
    return self;
}

@end

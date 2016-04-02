//
//  NewsWallModel.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/31/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "NewsWallModel.h"
#import "WallModel.h"

@implementation NewsWallModel



-(id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super initWithServerResponse:responseObject];

    
    NSLog(@"%@",responseObject );
    
    NSMutableArray* feedArray = [NSMutableArray array];
    
    for (NSDictionary* dict in [[responseObject objectForKey:@"response"]objectForKey:@"items"]) {
        
        WallModel* feed = [[WallModel alloc] initWithServerResponse:dict];
        
        NSLog(@"%@", feed.textWall); 
        
        [feedArray addObject:feed];
    }
    self.items = feedArray;
    
    
    NSMutableDictionary* dichAttachments = [NSMutableDictionary dictionary];
    for (NSDictionary* dict in [[responseObject objectForKey:@"response"]objectForKey:@"items"]) {
        for (NSDictionary* dictAtach in [dict objectForKey:@"attachments"]) {
            WallModel* feedAttachments = [[WallModel alloc] initWithServerResponse:dictAtach];
            
            
        }
   
        
    }
    self.dictAttachments = dichAttachments;
    
    
    
    
    
    
    
    return self;
}


@end

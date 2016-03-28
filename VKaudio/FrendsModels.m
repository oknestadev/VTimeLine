//
//  FrendsModels.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/24/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "FrendsModels.h"

@implementation FrendsModels


- (id)initWithServerResponse: (NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        self.name = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.uID = [responseObject objectForKey:@"user_id"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_100"];
        
        
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
        
    }
    return self;
}



@end

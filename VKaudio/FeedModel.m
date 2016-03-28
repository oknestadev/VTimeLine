//
//  FeedModel.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/22/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel


-(id) initWithServerResponse:(NSDictionary *)responseObject {
    
    self = [super initWithServerResponse:responseObject];
    
    if (self) {
        
        //self.textPost = [responseObject objectForKey:@"text"];
        self.textPost = [[responseObject objectForKey:@"text"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        //self.owner = [responseObject objectForKey:@"source_id"];
        if ([[responseObject objectForKey:@"source_id"] integerValue]>0) {
            self.type = FeedModelTypePeople;
        }
        else
        {
            self.type = FeedModelTypeGroupe;
        }
        
        NSString* urlString = [responseObject objectForKey:@"photo"];
        
        if (urlString) {
            self.photo = [NSURL URLWithString:urlString];
        }
        
               
    }
    return self;

    
    
    
    
    
    
    
    
}

@end

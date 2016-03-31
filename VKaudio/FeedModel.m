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
    
    
    NSLog(@"aaa %@", responseObject); 
    
    if (self) {
        
        
        
        //self.textPost = [responseObject objectForKey:@"text"];
        self.textPost = [[responseObject objectForKey:@"text"] stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        NSInteger temp_id = [[responseObject objectForKey:@"source_id"] integerValue];
       
        if (temp_id>0) {
            self.type = FeedModelTypePeople;
            self.owner = [responseObject objectForKey:@"source_id"];
            self.ownerAttachid = [responseObject objectForKey:@"source_id"];
          
        }
        else
        {
            self.type = FeedModelTypeGroupe;
            self.owner = [NSString stringWithFormat:@"%li",(temp_id*-1)];
            
            
            self.ownerAttachid = [responseObject objectForKey:@"source_id"];
            NSLog(@"%@", self.ownerAttachid); 
            
        
        }
        
        NSString* urlString = [responseObject objectForKey:@"photo"];
        NSLog(@"%@", urlString);
        
        if (urlString) {
            self.photo = [NSURL URLWithString:urlString];
        }
        
               
    }
    return self;

    
    
    
    
    
    
    
    
}

@end

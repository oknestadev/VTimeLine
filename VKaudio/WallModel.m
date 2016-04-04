//
//  WallModel.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/18/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "WallModel.h"

@implementation WallModel


-(id) initWithServerResponse:(NSDictionary *)responseObject {
    
    NSLog(@"%@",responseObject);
    
    
    
    
    self = [super initWithServerResponse:responseObject];
    
    if (self) {
        
        if ([responseObject objectForKey:@"text"]) {
            
             self.textWall = [responseObject objectForKey:@"text"];
            
             NSLog(@" %@ " ,self.textWall);
        
        } else if ([responseObject objectForKey:@"photo"] ) {
        
            
            NSString* urlString = [[responseObject objectForKey:@"photo"] objectForKey:@"photo_130"];
            
            NSLog(@"%@", urlString);
            
            if (urlString) {
                self.photo = [NSURL URLWithString:urlString];

            } else if ([responseObject objectForKey:@"audio"]) {
                
               self.titelAudioWall = [[responseObject objectForKey:@"audio"] objectForKey:@"title"];
                NSLog(@"%@",  self.titelAudioWall); 
                
            }
        
        

        
        }

           }
    
    return self;
    
    
    
    
}

@end

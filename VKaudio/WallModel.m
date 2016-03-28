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
    
    
    
    
    self = [super initWithServerResponse:responseObject];
    
    if (self) {
        
        self.testWall = [responseObject objectForKey:@"text"];
        
        NSString* urlString = [responseObject objectForKey:@"photo_604"];
        
        if (urlString) {
            self.photo = [NSURL URLWithString:urlString];
        }

        
           }
    return self;
    
    
    
    
}

@end

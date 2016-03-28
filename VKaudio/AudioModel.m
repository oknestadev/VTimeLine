//
//  AudioModel.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/21/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "AudioModel.h"

@implementation AudioModel


-(id) initWithServerResponse:(NSDictionary *)responseObject {
    
    
    
    
    self = [super initWithServerResponse:responseObject];
    
    if (self) {
        
        self.artist = [responseObject objectForKey:@"artist"];
        self.title = [responseObject objectForKey:@"title"];
        
        
        
        NSString* urlString = [responseObject objectForKey:@"url"];
        
        if (urlString) {
            self.urlAudio = [NSURL URLWithString:urlString];
        }
        
    }
    return self;
    
    
}

@end

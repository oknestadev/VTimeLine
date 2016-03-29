//
//  UserModel.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/17/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(id) initWithServerResponse:(NSDictionary *)responseObject {
    
    
    
    
    self = [super initWithServerResponse:responseObject];
    
    if (self) {
        
        self.name = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        self.status = [responseObject objectForKey:@"status"];
        self.uID = [responseObject objectForKey:@"uid"];

        NSString* urlString = [responseObject objectForKey:@"photo"];
        
        if (urlString) {
            self.photo = [NSURL URLWithString:urlString];
        }
        NSString* urlStringAvatar = [responseObject objectForKey:@"photo_200_orig"];
        
        if (urlStringAvatar) {
            self.avatarPhoto = [NSURL URLWithString:urlStringAvatar];
            
        }
        
    }
    return self;
    
    
}






@end

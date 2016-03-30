//
//  attachmentsModel.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/30/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "AttachmentsModel.h"

@implementation AttachmentsModel


- (id)initWithServerResponse: (NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        
        NSLog(@"%@", responseObject); 

        self.oid = [[responseObject objectForKey:@"photo"] objectForKey:@"owner_id"];
        NSLog(@"%@", self.oid); 
        
        NSString* urlString = [[responseObject objectForKey:@"photo"] objectForKey:@"src_big"] ;
        
        NSLog(@" aa %@", urlString);
        
        if (urlString) {
           self.photoAttachments = [NSURL URLWithString:urlString];
        }
        
        
    }
    return self;
}



@end

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
        
        if ([responseObject objectForKey:@"photo"]) {
            self.ownerPhotoid = [[responseObject objectForKey:@"photo"] objectForKey:@"owner_id"];
            NSLog(@"%@", self.ownerPhotoid);
            
            NSString* urlString = [[responseObject objectForKey:@"photo"] objectForKey:@"src_big"] ;
            
            NSLog(@" aa %@", urlString);
            
            if (urlString) {
                self.photoAttachments = [NSURL URLWithString:urlString];
            }
        } else if ([responseObject objectForKey:@"video"]){
            
           self.ownerVideoid = [[responseObject objectForKey:@"video"] objectForKey:@"owner_id"];
            NSLog(@"%@", self.ownerVideoid);
            
             NSString* urlString = [[responseObject objectForKey:@"video"] objectForKey:@"image_big"] ;
            
            if (urlString) {
                self.videoPhotoAttachments = [NSURL URLWithString:urlString];
            }
            
            NSLog(@"imageVideo - %@",urlString);

            
        }
        
        
        
    }
    return self;
}



@end

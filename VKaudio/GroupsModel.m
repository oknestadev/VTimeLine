//
//  GroupsModel.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/29/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "GroupsModel.h"

@implementation GroupsModel

/*   id = 16108331;
 "is_closed" = 0;
 name = ITmozg;
 "photo_100" = "http://cs617221.vk.me/v617221956/4e5b/DoGV6B-2qfw.jpg";
 "photo_200" = "http://cs617221.vk.me/v617221956/4e5a/LBj2hVecUnM.jpg";
 "photo_50" = "http://cs617221.vk.me/v617221956/4e5c/3Rqo1NpvW7Q.jpg";
 "screen_name" = itmozg;
 type = page; */

- (id)initWithServerResponse: (NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        //NSLog(@"GROUP INFO: \n %@",responseObject);
        self.groupName = [responseObject objectForKey:@"name"];
       
        self.gID = [responseObject objectForKey:@"gid"];
        self.groupID = [responseObject objectForKey:@"id"];
        NSString* urlString2 = [responseObject objectForKey:@"photo_200"];
        
        NSLog(@"%@", urlString2);
        
        if (urlString2) {
            self.groupImageURL = [NSURL URLWithString:urlString2];
        }
        

        
      
        
        
        NSString* urlString = [responseObject objectForKey:@"photo_big"];
        
        NSLog(@"%@", urlString); 
        
        if (urlString) {
            self.groupImageURL = [NSURL URLWithString:urlString];
        }
        
        
    }
    return self;
}







@end

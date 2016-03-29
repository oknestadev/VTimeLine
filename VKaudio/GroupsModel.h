//
//  GroupsModel.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/29/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "InitModels.h"

@interface GroupsModel : InitModels

@property(strong,nonatomic) NSString* groupName;
@property(strong,nonatomic) NSString* groupID;
@property (strong, nonatomic) NSURL* groupImageURL;


- (id)initWithServerResponse: (NSDictionary*) responseObject;





@end

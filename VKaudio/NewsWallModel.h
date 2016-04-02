//
//  NewsWallModel.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/31/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "InitModels.h"

@interface NewsWallModel : InitModels

@property(strong, nonatomic) NSArray* items;
@property(strong, nonatomic) NSDictionary* dictAttachments;
@property(strong, nonatomic) NSDictionary* dictProfiles; 

-(id) initWithServerResponse:(NSDictionary*) responseObject; 

@end

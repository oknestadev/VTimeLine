//
//  FeedModel.h
//  VKaudio
//
//  Created by EugeneYatsenko on 3/22/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InitModels.h"

typedef NS_OPTIONS(NSUInteger, FeedModelType) {
    FeedModelTypeGroupe,
    FeedModelTypePeople
};

@interface FeedModel : InitModels

@property(strong, nonatomic) NSString* textPost;
@property(strong, nonatomic) NSURL* photo;
@property(strong,nonatomic) NSURL* photoAttachments; 
@property(strong, nonatomic) NSString* owner;
@property(assign, nonatomic) FeedModelType type;


-(id) initWithServerResponse:(NSDictionary *)responseObject;




@end

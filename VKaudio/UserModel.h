//
//  UserModel.h
//  VKaudio
//
//  Created by EugeneYatsenko on 3/17/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InitModels.h"

@interface UserModel : InitModels

@property(strong,nonatomic) NSString* name;
@property(strong,nonatomic) NSString* lastName;
@property(strong,nonatomic) NSString* status;
@property(strong,nonatomic) NSString* textPost;
@property(strong,nonatomic) NSString* uID;
@property(strong, nonatomic) NSURL* photo;
@property(strong, nonatomic) NSURL* avatarPhoto;

-(id) initWithServerResponse:(NSDictionary*) responseObject;

@end

//
//  AudioModel.h
//  VKaudio
//
//  Created by EugeneYatsenko on 3/21/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InitModels.h"

@interface AudioModel : InitModels

-(id) initWithServerResponse:(NSDictionary*) responseObject;

@property(strong,nonatomic) NSString* artist;
@property(strong, nonatomic) NSString* title;
@property(strong, nonatomic) NSURL* urlAudio;



@end

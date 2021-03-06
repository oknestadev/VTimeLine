//
//  WallModel.h
//  VKaudio
//
//  Created by EugeneYatsenko on 3/18/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InitModels.h"

@interface WallModel : InitModels

@property(strong, nonatomic) NSString* textWall;
@property(strong, nonatomic) NSString* titelAudioWall;
@property(strong, nonatomic) NSURL* photo; 

@end

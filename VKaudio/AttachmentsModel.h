//
//  attachmentsModel.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/30/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "InitModels.h"

@interface AttachmentsModel : InitModels

@property(strong, nonatomic) NSURL* photoAttachments;
@property(strong, nonatomic) NSURL* videoPhotoAttachments;
@property(strong,nonatomic) NSString* ownerPhotoid;
@property(strong,nonatomic) NSString* ownerVideoid;


@end

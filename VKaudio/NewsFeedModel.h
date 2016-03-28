//
//  NewsFeedModel.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/24/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InitModels.h"

@interface NewsFeedModel : InitModels

/*
 items — массив новостей для текущего пользователя;
 profiles — информация о пользователях, которые находятся в списке новостей;
 groups — информация о группах, которые находятся в списке новостей;
 new_offset — содержит offset, который необходимо передать, для того, чтобы получить следующую часть новостей;
 next_from — содержит start_from, который необходимо передать, для того, чтобы получить следующую часть новостей. Позволяет избавиться от дубликатов, которые могут возникнуть при появлении новых новостей между вызовами этого метода.
 */

@property(strong, nonatomic) NSArray* items;
@property(strong, nonatomic) NSDictionary* profiles;
@property(strong, nonatomic) NSDictionary* groups;

#warning Заполни оставшиеся два поля!!!!
@property(strong, nonatomic) NSString* nwOffset;
@property(strong, nonatomic) NSString* nextFrom;

-(id) initWithServerResponse:(NSDictionary*) responseObject;
@end

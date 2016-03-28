//
//  FriendsTableViewCell.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/24/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoImageFriends;
@property (weak, nonatomic) IBOutlet UILabel *nameFriendsLabel;

@property(strong,nonatomic) NSIndexPath* indexPath;


@end

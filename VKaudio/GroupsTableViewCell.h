//
//  AudioTableViewCell.h
//  VKaudio
//
//  Created by EugeneYatsenko on 3/21/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UIImageView *groupPhoto;


@property(strong,nonatomic) NSIndexPath* indexPath;





@end

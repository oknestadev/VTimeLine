//
//  PageTableViewCell.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/24/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imagePhotoCell;
@property (weak, nonatomic) IBOutlet UILabel *labelCell;

@property(weak,nonatomic) NSIndexPath* indexPath;

@end

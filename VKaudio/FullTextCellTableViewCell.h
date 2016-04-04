//
//  FullTextCellTableViewCell.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/23/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullTextCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fullTextLabel;

@property(weak,nonatomic) NSIndexPath* indexPath;
@property (weak, nonatomic) IBOutlet UIImageView *fullImageCell;

+ (CGFloat) heightForText:(NSString*) text;

@end

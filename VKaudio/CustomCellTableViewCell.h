//
//  CustomCellTableViewCell.h
//  VKaudio
//
//  Created by EugeneYatsenko on 3/17/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *wallLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoFeed;

@property(strong,nonatomic) NSIndexPath* indexPath;

@property (weak, nonatomic) IBOutlet UILabel *fullNameTLabel;

- (IBAction)buttonPageTL:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *photoInCellTL;



+ (CGFloat) heightForText:(NSString*) text;

@end

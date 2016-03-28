//
//  AudioTableViewCell.h
//  VKaudio
//
//  Created by EugeneYatsenko on 3/21/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioTableViewCell : UITableViewCell



@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
- (IBAction)playMusic:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

//
//  GroupPageTableViewController.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/29/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupsModel.h"

@interface GroupPageTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *groupsPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *groupsFonePhoto;
@property (weak, nonatomic) IBOutlet UILabel *groupsNameLabel;
@property (weak, nonatomic) IBOutlet UIView *groupsView;




@property(strong,nonatomic) NSString* groupID;

@property(strong,nonatomic) GroupsModel* group;



@end

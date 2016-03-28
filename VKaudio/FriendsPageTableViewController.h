//
//  FriendsPageTableViewController.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/25/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsPageTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoUser;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *friendsButton;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *fonePhoto;
@property (weak, nonatomic) IBOutlet UIView *foneView;
@property (weak, nonatomic) IBOutlet UINavigationItem *userbar;




@property(strong,nonatomic) NSString* uIDPage;
@property(strong,nonatomic) NSString* fName;

@end

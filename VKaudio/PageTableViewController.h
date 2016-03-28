//
//  PageTableViewController.h
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/24/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *fullNamePage;
@property (weak, nonatomic) IBOutlet UILabel *statusPage;
@property (weak, nonatomic) IBOutlet UIImageView *photoAvatar;
@property (weak, nonatomic) IBOutlet UINavigationItem *tabBarPage;
- (IBAction)logOutButton:(id)sender;


@property(strong,nonatomic) NSString* fullNameText;
@property(strong,nonatomic) NSString* statusString;
@property(strong,nonatomic) NSURL* photoPage; 
@property (weak, nonatomic) IBOutlet UIView *viewFone;

@property(strong,nonatomic) NSString* uIDPage;
@property(strong,nonatomic) NSString* uIDPage2;



@end

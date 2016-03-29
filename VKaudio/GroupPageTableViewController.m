//
//  GroupPageTableViewController.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/29/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "GroupPageTableViewController.h"
#import "UIImageView+AFNetworking.h"

@interface GroupPageTableViewController ()

@end

@implementation GroupPageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makePhotoAndName]; 
    
    
   
    
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Wall";
    
}



-(void) blurEffect {
    
    // create blur effect
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // create vibrancy effect
    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
    
    // add blur to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.groupsFonePhoto.frame;
    
    // add vibrancy to yet another effect view
    UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
    vibrantView.frame = self.groupsFonePhoto.frame;
    
    // add both effect views to the image view
    [self.groupsFonePhoto addSubview:effectView];
    [self.groupsFonePhoto addSubview:vibrantView];
 
}
-(void) makePhotoAndName {
    
    self.groupsNameLabel.text = self.group.groupName;
    [self.groupsFonePhoto setImageWithURL:self.group.groupImageURL];
    [self.groupsPhoto setImageWithURL:self.group.groupImageURL];
    self.groupsPhoto .layer.cornerRadius = self.groupsPhoto.frame.size.height/2;
    self.groupsPhoto .clipsToBounds = YES;
    self.groupsPhoto.layer.borderColor = [UIColor blackColor].CGColor;
    [self.groupsPhoto.layer setBorderWidth:0.5f];
    [self blurEffect];
    
}


@end

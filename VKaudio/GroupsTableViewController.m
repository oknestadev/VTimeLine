//
//  AudioTableViewController.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/21/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "GroupsTableViewController.h"
#import "TimelineTableViewController.h"
#import "VKSdk.h"
#import "CustomCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "API.h"
#import "AudioModel.h"
#import "GroupsModel.h"
#import "GroupsTableViewCell.h"
#import "GroupPageTableViewController.h"
#import <AVFoundation/AVFoundation.h>



@interface GroupsTableViewController () <UITableViewDataSource, UITableViewDelegate>
{
    BOOL reloadFlag;
}

@property(strong,nonatomic) NSMutableArray* arrayWithGroup;

@end

@implementation GroupsTableViewController

static NSInteger PostInRequest = 10;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayWithGroup = [NSMutableArray array];
    
    [self getGroup]; 
    
   
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) getGroup {
    
    
    [[API sharedManager] getGroup:self.groupsId offset:[self.arrayWithGroup count] count:PostInRequest onSuccess:^(NSArray *getGroup) {
        
        reloadFlag = getGroup.count<PostInRequest;
        
        [self.arrayWithGroup addObjectsFromArray:getGroup];
        
        [self.tableView reloadData];
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
    
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.arrayWithGroup count]; 
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier = @"cellGroup";
    
    GroupsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[GroupsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier  ];
    }
    
    
    GroupsModel* group = [self.arrayWithGroup objectAtIndex:indexPath.row];
    
    cell.groupName.text = group.groupName;
    [cell.groupPhoto setImageWithURL:group.groupImageURL];
    
    NSLog(@"%@ %@ %@", group.groupName, group.groupID, group.groupImageURL);
    
    cell.groupPhoto.layer.cornerRadius = cell.groupPhoto.frame.size.height/2;
    cell.groupPhoto.clipsToBounds = YES;
    cell.groupPhoto.layer.borderColor = [UIColor blackColor].CGColor;
    [cell.groupPhoto.layer setBorderWidth:0.5f];

    
  
    [cell setIndexPath:indexPath];
    

    
    
    
    if (indexPath.row == [self.arrayWithGroup count]- 1 && !reloadFlag) {
        
        [self getGroup]; 
        
    }

    
    
    return cell; 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    if ([segue.identifier isEqualToString:@"segueGroup"]) {
        
        GroupsTableViewCell* cell = (GroupsTableViewCell*)sender;
       GroupsModel* group = [self.arrayWithGroup objectAtIndex:cell.indexPath.row];
        
        NSLog(@"%@ %@ %@", group.groupName, group.groupID, group.groupImageURL);
        
        ((GroupPageTableViewController*)[segue destinationViewController]).group = group;
        
    }
    
    
}








@end

//
//  FriendsTableViewController.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/24/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "API.h"
#import "FriendsTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TimelineTableViewController.h"
#import "VKSdk.h"
#import "UserModel.h"
#import "WallModel.h"
#import "FeedModel.h"
#import "FrendsModels.h"
#import "PageTableViewCell.h"
#import "FriendsTableViewCell.h"
#import "PageTableViewController.h"
#import "FriendsPageTableViewController.h"

@interface FriendsTableViewController ()
{
    BOOL reloadFlag;
}

@property(strong,nonatomic) NSMutableArray* arrayWithFrend;
@property(strong,nonatomic) FriendsTableViewCell* cell;

@property(strong,nonatomic) UserModel* myUser;

@end

@implementation FriendsTableViewController

static NSInteger friendsInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arrayWithFrend = [NSMutableArray array];
    
    self.titleFriends.title = @"Friends";
    
    [self getFriends];
    
    
    
    
    
   
}

-(void) getFriends {
    
  
    
    [[API sharedManager] getFriendsFromUSer:self.uIDFriends offset:[self.arrayWithFrend count] count:friendsInRequest onSuccess:^(NSArray *friends) {
        
        reloadFlag = friends.count<friendsInRequest;
        
        NSLog(@"aaaaaa %@", self.uIDFriends);
        
        [self.arrayWithFrend addObjectsFromArray:friends];
        
        
        // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        [self.tableView reloadData];
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [NSString stringWithFormat:@"Friends %lu",(unsigned long)[self.arrayWithFrend count]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayWithFrend count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
      static NSString* identifier = @"cell0";
    
      _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (! _cell) {
        
        _cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    FrendsModels* friend = [self.arrayWithFrend objectAtIndex:indexPath.row];

    
    NSLog(@"%@ %@ %@",friend.name, friend.lastName, friend.uID);
    
    
    _cell.nameFriendsLabel.text = [NSString stringWithFormat:@"%@ %@", friend.name, friend.lastName];
    [_cell.photoImageFriends setImageWithURL:friend.imageURL];
    
    _cell.photoImageFriends.layer.cornerRadius = _cell.photoImageFriends.frame.size.height/2;
    _cell.clipsToBounds= YES;
    
    
    
   
    
    if (indexPath.row == [_arrayWithFrend count] - 1 && !reloadFlag)
    {
        [self getFriends];
    }
    
    
    [_cell setIndexPath:indexPath];
    
    return _cell;
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    if ([segue.identifier isEqualToString:@"UserPageWall"]) {
        
        self.cell = (FriendsTableViewCell*)sender;
        FrendsModels* friend = [self.arrayWithFrend objectAtIndex:self.cell.indexPath.row];
        
        NSLog(@"%@ %@ %@", friend.name, friend.lastName, friend.uID);

        ((FriendsPageTableViewController*)[segue destinationViewController]).uIDPage = friend.uID;

   }


}


@end

 //
//  ProfileTableViewController.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/17/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "TimelineTableViewController.h"
#import "VKSdk.h"
#import "UserModel.h"
#import "CustomCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "API.h"
#import "WallModel.h"
#import "FeedModel.h"
#import "FullTextCellTableViewCell.h"
#import "FullTextTableViewController.h"
#import "PageTableViewController.h"
#import "NewsFeedModel.h"
#import "GroupsModel.h"


@interface TimelineTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NewsFeedModel* feedModel;
}


@property(strong,nonatomic) CustomCellTableViewCell* cell;
@property(strong,nonatomic) UserModel* myUser;

@property(strong, nonatomic) NSMutableDictionary* peopleDict;
@property(strong, nonatomic) NSMutableDictionary* groupDict;
@property(strong, nonatomic) NSMutableArray* arrayWithFeed;
@property(strong, nonatomic) NSMutableArray* arrayWithUser;
@property(strong, nonatomic) NSURL* photo;





- (IBAction)refreshControl:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UIView *imageView;










@end

@implementation TimelineTableViewController

static NSInteger PostInRequest = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    self.arrayWithFeed = [NSMutableArray array];
    self.arrayWithUser = [NSMutableArray array];
    self.peopleDict = [NSMutableDictionary dictionary];
    self.groupDict = [NSMutableDictionary dictionary];
    
    
    

    [self getUser];
    [self getFeed];
    
    
 

    
    

}




-(void) viewDidAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

-(void) getUser {
    
    

    [[API sharedManager] getuser:nil onSuccess:^(NSArray *userArray) {
        
        [self.arrayWithUser addObjectsFromArray:userArray];
        
        UserModel* user = [self.arrayWithUser objectAtIndex:0];
        [self makeProfilePhoto];
        
        self.myUser = user;
        
        [self.imageProfile setImageWithURL:user.avatarPhoto];
 
       
        NSLog(@"user %@", user.photo);

        [self.tableView reloadData];
        
        
         //NSLog(@"arrarra %@", self.arrayWithObject);
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"ERROR");
    }];
    
}




-(void) getFeed {
    
    [[API sharedManager] getFeed:[self.arrayWithFeed count] count:PostInRequest onSuccess:^(NewsFeedModel *feed) {
        feedModel = feed;
        [self.arrayWithFeed addObjectsFromArray:feed.items];
        [_peopleDict addEntriesFromDictionary:feed.profiles];
        [_groupDict addEntriesFromDictionary:feed.groups];
        
        NSLog(@"arrayitchObject %@", self.arrayWithFeed); 
        
        [self.tableView reloadData];
   
        
    } onFailure:^(NSError *error) {
        
    }];

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    

    NSLog(@"count %lu",(unsigned long)[self.arrayWithFeed count] );
    return [self.arrayWithFeed count] ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier = @"cell0";
    
    _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!_cell) {
        _cell = [[CustomCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier  ];
    }
    
    
    
    FeedModel* feed = [self.arrayWithFeed objectAtIndex:indexPath.row];
    switch (feed.type) {
        case FeedModelTypePeople:
        {
            UserModel* user = [_peopleDict objectForKey:feed.owner];

            
            [_cell.photoFeed setImageWithURL:user.photo];
        }
            break;
        case FeedModelTypeGroupe:
        {
            
            NSLog(@"photo %@",feed.owner );
            GroupsModel* group = [_groupDict objectForKey:[NSNumber numberWithInteger:[feed.owner integerValue]]];
            NSLog(@"photo %@",feed.owner );

            [_cell.photoFeed setImageWithURL:group.groupImageURL];
            _cell.photoFeed.layer.cornerRadius = _cell.photoFeed.frame.size.height/2;
            _cell.photoFeed.clipsToBounds = YES;
            _cell.photoFeed.layer.borderColor = [UIColor blackColor].CGColor;
            [_cell.photoFeed.layer setBorderWidth:0.5f];
            
            
        }
            break;
        default:
            break;
    }
    
  NSLog(@"Feed %@", feed.textPost);
    _cell.wallLabel.text = feed.textPost;
    [_cell setIndexPath:indexPath];
    NSLog(@"setIndexPath %@",indexPath);
    
    
    if (indexPath.row == [self.arrayWithFeed count] - 1) {
        [self getFeed];
    }

    return  _cell ;
    
}






- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    
    
    if ([segue.identifier isEqualToString:@"FullText"])
    {
        
        _cell = (CustomCellTableViewCell*)sender;
        FeedModel* feed = [self.arrayWithFeed objectAtIndex:_cell.indexPath.row];
        ((FullTextTableViewController*)[segue destinationViewController]).text = feed.textPost;

    }
    
    if ([segue.identifier isEqualToString:@"MyPage"]) {
        
        NSLog(@"User %@ %@ %@", self.myUser.name, self.myUser.lastName, self.myUser.uID);
        ((PageTableViewController*)[segue destinationViewController]).fullNameText = [NSString stringWithFormat:@"%@ %@", self.myUser.name, self.myUser.lastName];
        ((PageTableViewController*)[segue destinationViewController]).statusString= self.myUser.status;
        ((PageTableViewController*)[segue destinationViewController]).photoPage = self.myUser.photo;
        ((PageTableViewController*)[segue destinationViewController]).uIDPage = self.myUser.uID;


    }
    
    
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.view endEditing:YES]; 
}


- (IBAction)refreshControl:(id)sender {
    
    [self.tableView reloadData];
    
    [sender endRefreshing];
}



-(void) makeProfilePhoto {
    
    self.imageProfile.layer.cornerRadius = self.imageProfile.frame.size.height/2;
    self.imageProfile.clipsToBounds = YES;
    self.imageProfile.layer.borderColor = [UIColor blackColor].CGColor;
    [self.imageProfile.layer setBorderWidth:0.5f];
    
    self.imageView.layer.cornerRadius = self.imageProfile.frame.size.height/2;
    self.imageView.clipsToBounds = YES;

}
@end

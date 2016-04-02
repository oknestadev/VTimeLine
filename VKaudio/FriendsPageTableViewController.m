//
//  FriendsPageTableViewController.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/25/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "FriendsPageTableViewController.h"
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
#import "FriendPagesTableViewCell.h"
#import "FriendsTableViewController.h"
#import "NewsWallModel.h"


@interface FriendsPageTableViewController ()
{
    NewsWallModel *wallModel;
    BOOL reloadFlag;
}
@property(strong,nonatomic) NSMutableArray* arrayWithUser;
@property(strong,nonatomic) NSMutableArray* arrayWithUserWall;
@property(strong,nonatomic) FriendPagesTableViewCell* cell;

@end

@implementation FriendsPageTableViewController

static NSInteger PostInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.arrayWithUser = [NSMutableArray array];
    self.arrayWithUserWall = [NSMutableArray array];
    
    [self getUser];
    [self getwall];
    
    
    
    
   
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) getUser {
    
    
    
    [[API sharedManager] getuser:self.uIDPage onSuccess:^(NSArray *userArray) {
        [self.arrayWithUser addObjectsFromArray:userArray];
        
        reloadFlag = userArray.count<PostInRequest;
        
        UserModel* user = [self.arrayWithUser objectAtIndex:0];
        
        
        
        self.fullName.text = [NSString stringWithFormat:@"%@ %@ ", user.name , user.lastName];
        self.statusLabel.text = user.status;
        [self.userPhoto setImageWithURL:user.photo];
        [self.fonePhoto setImageWithURL:user.photo];

        [self blurEffectAndRoundingPhoto];
        
         self.userbar.title = [NSString stringWithFormat:@"%@ %@ ", user.name , user.lastName];

        
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
    
}

-(void) getwall {
        
        
        [[API sharedManager] getWallPost:self.uIDPage offset:[self.arrayWithUserWall count] count:PostInRequest onSuccess:^(NewsWallModel *wall) {
            wallModel = wall;
            
            
            [self.arrayWithUserWall addObjectsFromArray:wallModel.items];
            
            reloadFlag = self.arrayWithUserWall.count<PostInRequest;
            
            [self.tableView reloadData];
            
            
            
        } onFailure:^(NSError *error) {
            
        }];
        
    }
    




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) blurEffectAndRoundingPhoto {
    
    // create blur effect
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // create vibrancy effect
    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
    
    // add blur to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.foneView.frame;
    
    // add vibrancy to yet another effect view
    UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
    vibrantView.frame = self.foneView.frame;
    
    // add both effect views to the image view
    [self.fonePhoto addSubview:effectView];
    [self.fonePhoto addSubview:vibrantView];
    
    
    self.userPhoto.layer.cornerRadius = self.userPhoto.frame.size.height/2;
    self.userPhoto.clipsToBounds = YES;
    
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.arrayWithUserWall count] ;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier = @"cell0";
    
    self.cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!self.cell) {
        self.cell = [[FriendPagesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier  ];
    }
    
    
   
    
    WallModel* wall = [self.arrayWithUserWall objectAtIndex:indexPath.row];
    UserModel* user = [self.arrayWithUser objectAtIndex:0];
    
    NSLog(@"%@ ", wall.textWall );
    
    self.cell.textPost.text = wall.textWall;
    [self.cell.photoUserWall setImageWithURL:user.photo];
    
    self.cell.photoUserWall.layer.cornerRadius = _cell.photoUserWall.frame.size.height/2;
    self.cell.photoUserWall.clipsToBounds = YES;
    self.cell.photoUserWall.layer.borderColor = [UIColor blackColor].CGColor;
    [self.cell.photoUserWall.layer setBorderWidth:0.5f];
    
    if (indexPath.row == [self.arrayWithUserWall count] - 1 && !reloadFlag) {
        
        [self getwall];
        
        
    }
    
    
    
    return  self.cell ;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    if ([segue.identifier isEqualToString:@"friends"]) {
        
        
        ((FriendsTableViewController*)[segue destinationViewController]).uIDFriends = self.uIDPage; 
        
        
        
    }
    
    
}





@end

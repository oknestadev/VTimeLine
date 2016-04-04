//
//  PageTableViewController.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/24/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "PageTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TimelineTableViewController.h"
#import "VKSdk.h"
#import "UserModel.h"
#import "WallModel.h"
#import "PageTableViewCell.h"
#import "API.h"
#import "FriendsTableViewController.h"
#import "FrendsModels.h"
#import "GroupsTableViewController.h"
#import "NewsWallModel.h"

@interface PageTableViewController ()


{
    NewsWallModel* wallModel;
    BOOL reloadFlag;
}
@property(strong,nonatomic) PageTableViewCell* cell;
@property(strong,nonatomic) UserModel* user;
@property(strong,nonatomic) NSMutableArray* arrayWithWall;
@property(strong,nonatomic) NSMutableArray* arrayWithUser;
@property(strong,nonatomic) NSMutableArray* arrayWithfriend;
@property (weak, nonatomic) IBOutlet UIImageView *foneImageFriend;




@end

@implementation PageTableViewController

static NSInteger PostInRequest = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayWithWall = [NSMutableArray array];
    self.arrayWithUser = [NSMutableArray array];
    self.arrayWithfriend = [NSMutableArray array];
    self.tabBarPage.title = self.fullNameText;
    [self getwall];
    [self getUser];

    
    [self blurEffectAndRoundingPhoto];
    
   

  

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getwall {
    
    
   // NSLog(@"id %@",self.uIDPage);
    
    
    
   [[API sharedManager] getWallPost:self.uIDPage offset:[self.arrayWithWall count] count:PostInRequest onSuccess:^(NewsWallModel *wall) {
       wallModel = wall;
       [self.arrayWithWall addObjectsFromArray:wallModel.items];
       
       reloadFlag = self.arrayWithWall.count<PostInRequest;
       
       [self.tableView reloadData];
       
       
       
   } onFailure:^(NSError *error) {
       
   }];
    
}


        
        
    

-(void) getUser {
    
    [[API sharedManager] getuser: self.uIDPage onSuccess:^(NSArray *userArray) {
        
        [self.arrayWithUser addObjectsFromArray:userArray];
        
         self.user = [self.arrayWithUser objectAtIndex:0];
       
        
        self.fullNamePage.text = [NSString stringWithFormat:@"%@ %@ ", self.user.name , self.user.lastName];
        self.statusPage.text = self.user.status;
        [self.photoAvatar setImageWithURL:self.user.avatarPhoto];
        [self.foneImageFriend setImageWithURL:self.user.avatarPhoto];
        self.photoAvatar .layer.cornerRadius = self.photoAvatar.frame.size.height/2;
        self.photoAvatar .clipsToBounds = YES;
        self.photoAvatar.layer.borderColor = [UIColor blackColor].CGColor;
        [self.photoAvatar.layer setBorderWidth:0.5f];
        
        

        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        
    }];
    
    
}


#pragma mark - Table view data source

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Wall";
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
  

    return [self.arrayWithWall count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier = @"cell0";
    
    _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!_cell) {
        _cell = [[PageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier  ];
    }

    WallModel* wall = [self.arrayWithWall objectAtIndex:indexPath.row];

    self.cell.labelCell.text = wall.textWall;
    [self.cell.imagePhotoCell setImageWithURL:self.user.avatarPhoto];
    self.cell.imagePhotoCell.layer.cornerRadius = _cell.imagePhotoCell.frame.size.height/2;
    self.cell.imagePhotoCell.clipsToBounds = YES;
    self.cell.imagePhotoCell.layer.borderColor = [UIColor blackColor].CGColor;
    [self.cell.imagePhotoCell.layer setBorderWidth:0.5f];
    
    if (indexPath.row == [self.arrayWithWall count] - 1 && !reloadFlag) {
        [self getwall];
        
    }


    
    
    return  self.cell ;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    
    if ([segue.identifier isEqualToString:@"friends"]) {
        
        
        NSLog(@"USER ID %@",self.uIDPage );
        
        ((FriendsTableViewController*)[segue destinationViewController]).uIDFriends = self.uIDPage ;
        
        
        
    }

    
    
    if ([segue.identifier isEqualToString:@"segueGroups"]) {
        
       
        NSLog(@"USER ID %@",self.uIDPage );
        
        ((GroupsTableViewController*)[segue destinationViewController]).groupsId = self.uIDPage ;
        
        
        
    }
    
    
}



- (IBAction)logOutButton:(id)sender {
    
    [VKSdk forceLogout];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void) blurEffectAndRoundingPhoto {
    
    // create blur effect
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    // create vibrancy effect
    UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blur];
    
    // add blur to an effect view
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.foneImageFriend.frame;
    
    // add vibrancy to yet another effect view
    UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
    vibrantView.frame = self.foneImageFriend.frame;
    
    // add both effect views to the image view
    [self.foneImageFriend addSubview:effectView];
    [self.foneImageFriend addSubview:vibrantView];
    
    
    //self.foneImageFriend.layer.cornerRadius = self.photoPage.frame.size.height/2;
    self.foneImageFriend.clipsToBounds = YES;
    
    
}



@end

//
//  FullTextTableViewController.m
//  VTimeLine
//
//  Created by EugeneYatsenko on 3/23/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "FullTextTableViewController.h"
#import "FullTextCellTableViewCell.h"

@interface FullTextTableViewController ()

@property(strong, nonatomic) FullTextCellTableViewCell* cell;

@end

@implementation FullTextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


 
    UIFont *cellFont = [UIFont fontWithName:@"Helvetica Neue" size:17.0f];
    
    CGSize constraintSize = CGSizeMake(320.0f, CGFLOAT_MAX);
    
    CGSize labelSize = [_cell.fullTextLabel.text sizeWithFont:cellFont
                            constrainedToSize:constraintSize
                                lineBreakMode:NSLineBreakByWordWrapping];
    
    return labelSize.height + 70.0f;

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    return 1;
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier = @"cell";
    
     _cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!_cell) {
        _cell = [[FullTextCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier  ];
    }
    
    _cell.fullTextLabel.text = self.text;
   
    
    
    return  _cell ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}





@end

//
//  AudioTableViewController.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/21/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "AudioTableViewController.h"
#import "TimelineTableViewController.h"
#import "VKSdk.h"
#import "CustomCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "API.h"
#import "AudioModel.h"
#import "AudioTableViewCell.h"
#import <AVFoundation/AVFoundation.h>



@interface AudioTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property(strong,nonatomic) NSMutableArray* arrayWithAudio;
@property(strong,nonatomic) AVAudioPlayer *audioPlay;
@end

@implementation AudioTableViewController

static NSInteger PostInRequest = 10;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayWithAudio = [NSMutableArray array];
    
    [self getAudio]; 
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getAudio {
    
    
    
    [[API sharedManager] getAudio:nil offset:[self.arrayWithAudio count] count:PostInRequest onSuccess:^(NSArray *audio) {
        
        [self.arrayWithAudio addObjectsFromArray:audio];
        
        [self.tableView reloadData];
        
        
        
        
        
    } onFailure:^(NSError *error) {
        
    }];
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.arrayWithAudio count]; 
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString* identifier = @"cell0";
    
    AudioTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[AudioTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier  ];
    }
    
    AudioModel* audio = [self.arrayWithAudio objectAtIndex:indexPath.row];
    
    cell.artistNameLabel.text = [NSString stringWithFormat:@"%@ - %@", audio.artist, audio.title];
   
    cell.playButton.tag = indexPath.row;
    
    
    
   // NSData *data = [NSData dataWithContentsOfURL:audio.urlAudio];
    
   //self.audioPlay = [[AVAudioPlayer alloc] initWithData:data error:nil];
    
    

    
    
    
    if (indexPath.row == [self.arrayWithAudio count]- 1) {
        [self getAudio];
    }

    
    
    return cell; 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AudioModel* audio = [self.arrayWithAudio objectAtIndex:indexPath.row];
    
    NSData *data = [NSData dataWithContentsOfURL:audio.urlAudio];
    
    self.audioPlay = [[AVAudioPlayer alloc] initWithData:data error:nil];
      [self.audioPlay play];

    
}



- (IBAction)profileButton:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil]; 
}

- (IBAction)playMusic:(id)sender {
    
    [self.audioPlay play];
}


@end

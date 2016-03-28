//
//  LoginViewController.m
//  VKaudio
//
//  Created by EugeneYatsenko on 3/17/16.
//  Copyright © 2016 EugeneYatsenko. All rights reserved.
//

#import "LoginViewController.h"
#import "VKSdk.h"
#import "API.h"

@interface LoginViewController () <VKSdkDelegate, VKSdkUIDelegate>

@end

@implementation LoginViewController

static NSString *const TOKEN_KEY = @"my_application_access_token";
static NSString *const NEXT_CONTROLLER_SEGUE_ID = @"START_WORK";
static NSArray *SCOPE = nil;




- (void)viewDidLoad {
    
     
    
    
    SCOPE = @[VK_PER_FRIENDS, VK_PER_PHOTOS, VK_PER_MESSAGES, VK_PER_WALL, VK_PER_VIDEO,VK_PER_PAGES, VK_PER_EMAIL,VK_PER_AUDIO];
    [super viewDidLoad];
    
    
    [[VKSdk initializeWithAppId:@"5359263" ] registerDelegate:self];
    [[VKSdk instance] setUiDelegate:self];
    [VKSdk wakeUpSession:SCOPE completeBlock:^(VKAuthorizationState state, NSError *error) {
        if (state == VKAuthorizationAuthorized) {
            [[API sharedManager] setAccessToken:[VKSdk accessToken]];
            [self startWorking];
        } else if (error) {
            NSLog(@"ERROR!!!");
        }
    }];

    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) startWorking {
    
    //[self performSegueWithIdentifier:NEXT_CONTROLLER_SEGUE_ID sender:nil];
    
    UINavigationController* nc = [self.storyboard instantiateViewControllerWithIdentifier:@"nafig"];
    
    [self presentViewController:nc animated:YES completion:nil];
    NSLog(@"LOGIN");
    
}

-(void) vkSdkNeedCaptchaEnter:(VKError *)captchaError {
    VKCaptchaViewController* vc = [VKCaptchaViewController captchaControllerWithError:captchaError];
    [vc presentIn:self.navigationController.topViewController];
    
}

-(void)vkSdkTokenHasExpired:(VKAccessToken *)expiredToken {
    [self loginButton: nil];
    
}

-(void) vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result{
    
    if (result.token) {
        [self startWorking];
        
        NSLog(@"Token %@", result.token.accessToken);
        [[API sharedManager] token:result.token];
        
        
    } else if (result.error) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Mistake"
                                      message:@"Not Authorizen with VK"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleCancel
                                    handler:^(UIAlertAction * action)
                                    {
                                        //Handel your yes please button action here
                                        
                                        
                                    }];
        
        [alert addAction:okButton];
        
        [self presentViewController:alert animated:YES completion:nil];

        
        
    }
    
    
    
}

- (void)vkSdkUserAuthorizationFailed {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)vkSdkShouldPresentViewController:(UIViewController *)controller {
    [self.navigationController.topViewController presentViewController:controller animated:YES completion:nil];
}





- (IBAction)loginButton:(id)sender {
    
    [VKSdk authorize: SCOPE];
 

}


@end

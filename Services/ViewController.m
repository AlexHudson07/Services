//
//  ViewController.m
//  Services
//
//  Created by Alex Hudson on 5/2/15.
//  Copyright (c) 2015 HudsonApps. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>


@interface ViewController ()//<FBSDKLoginButtonDelegate>
@property (strong, nonatomic) IBOutlet UIButton *myButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    loginButton.delegate = self;
//    [self.view addSubview:loginButton];
//    // Do any additional setup after loading the view, typically from a nib.
//
//    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
//
// //   self.myButton.enabled = false;
//
//    if ([FBSDKAccessToken currentAccessToken]) {
//        [self performSegueWithIdentifier:@"servicesSegue" sender:self];
//    }
}

-(void)viewWillAppear:(BOOL)animated{

//    if ([FBSDKAccessToken currentAccessToken]) {
//        // User is logged in, do work such as go to next view controller.
//
//        self.myButton.enabled = true;
//    }

    if ([PFUser currentUser] || [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {

        [self performSegueWithIdentifier:@"servicesSegue" sender:self];
    }
}

- (IBAction)onButtonPressed:(id)sender {
  //  [self performSegueWithIdentifier:@"servicesSegue" sender:self];

    [PFFacebookUtils logInInBackgroundWithPublishPermissions:@[ @"publish_actions" ] block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else {
            NSLog(@"User now has publish permissions!");
            [self performSegueWithIdentifier:@"servicesSegue" sender:self];
        }
    }];
}

//-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
//
//   // [self performSegueWithIdentifier:@"servicesSegue" sender:self];
//
//
////    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissions block:^(PFUser *user, NSError *error) {
////        if (!user) {
////            NSLog(@"Uh oh. The user cancelled the Facebook login.");
////        } else if (user.isNew) {
////            NSLog(@"User signed up and logged in through Facebook!");
////        } else {
////            NSLog(@"User logged in through Facebook!");
////        }
////    }];
//
//    if (result.grantedPermissions && !error) {
//        [PFFacebookUtils logInInBackgroundWithPublishPermissions:@[ @"publish_actions" ] block:^(PFUser *user, NSError *error) {
//            if (!user) {
//                NSLog(@"Uh oh. The user cancelled the Facebook login.");
//            } else {
//                NSLog(@"User now has publish permissions!");
//                [self performSegueWithIdentifier:@"servicesSegue" sender:self];
//
//            }
//        }];
//    }
//}
//
//-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
//
//    NSLog(@"logged out");
//}

@end

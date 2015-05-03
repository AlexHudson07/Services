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

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *myButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{


    if ([PFUser currentUser] || [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {

        [self performSegueWithIdentifier:@"servicesSegue" sender:self];
    }
}

- (IBAction)onButtonPressed:(id)sender {

    [PFFacebookUtils logInInBackgroundWithReadPermissions:@[@"public_profile"] block: ^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else {
            NSLog(@"User now has publish permissions!");
            [self performSegueWithIdentifier:@"servicesSegue" sender:self];
        }
    }];



//    [PFFacebookUtils logInInBackgroundWithPublishPermissions:@[ @"publish_actions" ] block:^(PFUser *user, NSError *error) {
//        if (!user) {
//            NSLog(@"Uh oh. The user cancelled the Facebook login.");
//        } else {
//            NSLog(@"User now has publish permissions!");
//            [self performSegueWithIdentifier:@"servicesSegue" sender:self];
//        }
//    }];
}

-(IBAction)unwindFromSettings:(UIStoryboardSegue *) segue{}

@end

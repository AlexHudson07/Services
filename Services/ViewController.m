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
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textFieldShouldReturn:)];

    [self.view addGestureRecognizer:tap];
}

#pragma mark - UI Methods
//resigns the keyboard when the user presses the return key
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.userNameTextField resignFirstResponder];

    [self.numberTextField resignFirstResponder];

    return YES;
}

-(void)viewWillAppear:(BOOL)animated {

    self.navigationController.navigationBarHidden = YES;

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

            user[@"screenName"] = self.userNameTextField.text;

            user[@"phoneNumber"] = self.numberTextField.text;

            user[@"city"] = @"miami";

            [user saveEventually];

            [self performSegueWithIdentifier:@"servicesSegue" sender:self];
        }
    }];
}

-(IBAction)unwindFromSettings:(UIStoryboardSegue *) segue {}

@end

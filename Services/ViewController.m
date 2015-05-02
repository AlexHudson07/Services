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

@interface ViewController ()<FBSDKLoginButtonDelegate>
@property (strong, nonatomic) IBOutlet UIButton *myButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
    // Do any additional setup after loading the view, typically from a nib.

    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];

 //   self.myButton.enabled = false;

    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"servicesSegue" sender:self];
    }
}

-(void)viewWillAppear:(BOOL)animated{

//    if ([FBSDKAccessToken currentAccessToken]) {
//        // User is logged in, do work such as go to next view controller.
//
//        self.myButton.enabled = true;
//    }
}

- (IBAction)onButtonPressed:(id)sender {
  //  [self performSegueWithIdentifier:@"servicesSegue" sender:self];
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{

   // [self performSegueWithIdentifier:@"servicesSegue" sender:self];

    if (result.grantedPermissions && !error) {
        [self performSegueWithIdentifier:@"servicesSegue" sender:self];
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{

    NSLog(@"logged out");
}

@end

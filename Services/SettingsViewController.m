//
//  SettingsViewController.m
//  Services
//
//  Created by Alex Hudson on 5/2/15.
//  Copyright (c) 2015 HudsonApps. All rights reserved.
//

#import "SettingsViewController.h"
#import "Parse/Parse.h"

@interface SettingsViewController ()

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *cityTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Settings";

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25.f/255 green:116.f/255 blue:119.f/255 alpha:1];

    NSDictionary *dictionary =  @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSFontAttributeName:[UIFont fontWithName:@"Futura" size:35]
                                  };

    [self.navigationController.navigationBar setTitleTextAttributes: dictionary];


    //Back button
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"Futura" size:21]
       }
     forState:UIControlStateNormal];


    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textFieldShouldReturn:)];

    [self.view addGestureRecognizer:tap];

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25.f/255 green:116.f/255 blue:119.f/255 alpha:1];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UI Methods
//resigns the keyboard when the user presses the return key
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.nameTextField resignFirstResponder];
    [self.cityTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];

    return YES;
}

- (IBAction)onLogOutButtonPressed:(id)sender {

    [PFUser logOut];
}

@end

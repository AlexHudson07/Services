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


    PFQuery *query = [PFUser query];

    [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSDictionary *dictionary = objects[0];

        NSLog(@"%@", dictionary);

        self.nameTextField.text = [dictionary objectForKey:@"screenName"];
        self.cityTextField.text = [dictionary objectForKey:@"city"];
        self.emailTextField.text = [dictionary objectForKey:@"email"];
        self.phoneTextField.text = [dictionary objectForKey:@"phoneNumber"];
    }];

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

- (IBAction)onSaveButtonPressed:(id)sender {

    PFUser *user = [PFUser currentUser];

    if (self.nameTextField.text) {
        user[@"screenName"] = self.nameTextField.text;
    }

    if (self.phoneTextField.text) {
        user[@"phoneNumber"] = self.phoneTextField.text;
    }

    if (self.emailTextField.text) {
        user[@"email"] = self.emailTextField.text;
    }

    if (self.cityTextField.text) {
        user[@"city"] = self.cityTextField.text;
    }

    [user saveEventually];

}

- (IBAction)onLogOutButtonPressed:(id)sender {

    [PFUser logOut];
}

@end

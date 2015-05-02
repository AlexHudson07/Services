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

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textFieldShouldReturn:)];

    [self.view addGestureRecognizer:tap];
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

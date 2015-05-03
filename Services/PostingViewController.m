//
//  PostingViewController.m
//  Services
//
//  Created by Alex Hudson on 5/2/15.
//  Copyright (c) 2015 HudsonApps. All rights reserved.
//

#import "PostingViewController.h"
#import "Parse/Parse.h"

@interface PostingViewController ()<UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (strong, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) NSArray *categoriesArray;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) IBOutlet UISegmentedControl *wantingOrProvidingSegmentedControl;
@property BOOL iAmProviding;
@property NSString *screenName;
@property NSString *phoneNumber;

@end

@implementation PostingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Post";

    PFQuery *query = [PFUser query];

    [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        NSDictionary *dictionary = objects[0];

        NSLog(@"%@", dictionary);

        self.screenName = [dictionary objectForKey:@"screenName"];

        self.phoneNumber = [dictionary objectForKey:@"phoneNumber"];

        NSLog(@"");

    }];
        
    [PFCloud callFunctionInBackground:@"categories"
                       withParameters:@{}
                                block:^(NSDictionary *result, NSError *error) {
                                    if (!error) {
                                        // result is @"Hello world!"
                                        NSDictionary *dictionary = result;

                                        self.pickerData = [dictionary objectForKey:@"categories"];
                                        [self.categoryPicker reloadAllComponents];
                                    }
                                }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textFieldShouldReturn:)];

    [self.view addGestureRecognizer:tap];
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - UI Methods
//resigns the keyboard when the user presses the return key
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.descriptionTextView resignFirstResponder];

    return YES;
}
- (IBAction)onPostButtonPressed:(id)sender {

    NSString *string;
    NSString *message;

    if (self.iAmProviding) {
        string = @"Provide";
        message = @"The service you provide is posted";

    } else {
        string = @"Want";
        message = @"The service you need is posted";
    }

    PFObject *want = [PFObject objectWithClassName:string];

    want[@"screenName"] = self.screenName;
    want[@"phoneNumber"] = self.phoneNumber;
    want[@"category"] = self.category;
    want[@"description"] = self.descriptionTextView.text;
    want[@"city"] = @"Miami";
    want[@"state"] = @"Florida";
    want[@"country"] = @"USA";
    want[@"myuser"] = [PFUser currentUser];

    [want saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {


            UIAlertController * ac =   [UIAlertController
                                       alertControllerWithTitle:message
                                       message:nil
                                       preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * ation) {

                                                           [self performSegueWithIdentifier:@"unwindFromPostIdentifier" sender:self];
                                                       }];
            [ac addAction:ok];

            [self presentViewController:ac animated:YES completion:nil];
        } else {

        }
    }];
}

#pragma mark - Picker Methods

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.category = self.pickerData[row];

    NSLog(@"Category to be posted: %@", self.category);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
       // [tView setFont:[UIFont fontWithName:@"Quicksand-Regular" size:20]];
        tView.textColor = [UIColor colorWithRed:25/255.0f green:174/255.0f blue:236/255.0f alpha:1.0];
        tView.numberOfLines=3;
    }
    // Fill the label text here
    tView.text=[self.pickerData objectAtIndex:row];
    tView.textAlignment = NSTextAlignmentCenter;
    return tView;
}

- (IBAction)onSegmentPressed:(UISegmentedControl *)control {

    if (control.selectedSegmentIndex == 0) {
        NSLog(@"I want a service");
        self.iAmProviding = false;
    } else{
        NSLog(@"I want to provide a service");
        self.iAmProviding = true;
    }

}

@end

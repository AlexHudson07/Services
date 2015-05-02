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
@property (strong, nonatomic) IBOutlet UIPickerView *catagoryPicker;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) NSArray *catagoriesArray;

@end

@implementation PostingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Post";

    self.pickerData = @[ @"Electricians", @"Plumber"];


    [PFCloud callFunctionInBackground:@"categories"
                       withParameters:@{}
                                block:^(NSArray *result, NSError *error) {
                                    if (!error) {
                                        // result is @"Hello world!"
                                        self.catagoriesArray = result;
                                        [self.catagoryPicker reloadAllComponents];
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

    return YES;
}
- (IBAction)onPostButtonPressed:(id)sender {


    PFObject *want = [PFObject objectWithClassName:@"Want"];
    want[@"category"] = @"Medical/Doctor";
    want[@"city"] = @"Miami";
    want[@"description"] = self.descriptionTextView.text;
    want[@"screenName"] = [PFUser currentUser].username;

//    if ([self.catagoryPicker selectedRowInComponent:0] == 0){
//
//        want[@"location"] = @"Chicago";
//    }
//
//    if ([self.catagoryPicker selectedRowInComponent:0] == 1){
//
//        /// NSLog(@"test");
//    }

    [want saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {

             NSLog(@"test");
        } else {
            // There was a problem, check error.description
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
    if (row == 0) {
        //   NSLog(@"Atlanta");
    }
    if (row == 1){
        //    NSLog(@"Detroit");
    }
    if (row == 2) {
        //     NSLog(@"Chicago");
    }

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

@end

//
//  ServicesViewController.m
//  Services
//
//  Created by Alex Hudson on 5/2/15.
//  Copyright (c) 2015 HudsonApps. All rights reserved.
//

#import "ServicesViewController.h"
#import "ServiceCell.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "DetailViewController.h"

@interface ServicesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UITableView *servicesTableView;
@property (strong, nonatomic) NSArray *servicesArray;
@property (strong, nonatomic) NSArray *wantsArray;
@property (strong, nonatomic) NSArray *providesArray;
@property BOOL needs;

@end

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.servicesArray = [NSArray new];
    self.wantsArray = [NSArray new];

//    if ([FBSDKAccessToken currentAccessToken]) {
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"fetched user:%@", result);
//             }
//         }];
//    }

    self.needs = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;

    [self.servicesTableView reloadData];

    if (self.needs) {

        [PFCloud callFunctionInBackground:@"wants"
                           withParameters:@{}
                                    block:^(NSArray *result, NSError *error) {
                                        if (!error) {
                                            // result is @"Hello world!"
                                            self.servicesArray = result;

//                                            NSDictionary *dictionary = result[0];
//
//                                            NSString *s = [dictionary objectForKey:@"matches"];

                                            [self.servicesTableView reloadData];
                                        }
                                    }];
    } else {
        [PFCloud callFunctionInBackground:@"provides"
                           withParameters:@{}
                                    block:^(NSArray *result, NSError *error) {
                                        if (!error) {
                                            // result is @"Hello world!"
                                            self.servicesArray = result;

                                            //                                            NSDictionary *dictionary = result[0];
                                            //
                                            //                                            NSString *s = [dictionary objectForKey:@"matches"];
                                            
                                            [self.servicesTableView reloadData];
                                        }
                                    }];
    }


}
- (IBAction)onSettingsButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"settingsSegue" sender:self];
}

- (IBAction)onAddButtonPressed:(id)sender {

    [self performSegueWithIdentifier:@"servicesToAddSegue" sender:self];
}

//tells the table view how many cells there will be
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.servicesArray.count;
}

//fills the cells to with the info and images from the parse
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    NSDictionary *dictionary = [self.servicesArray objectAtIndex:indexPath.row];

    cell.categoryLabel.text = [dictionary objectForKey:@"category"];
    cell.cityLabel.text = [dictionary objectForKey:@"city"];

    NSNumber *number = [dictionary objectForKey:@"matches"];
    cell.matchesLabel.text = [number stringValue];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

      //  [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

- (IBAction)toggleControl:(UISegmentedControl *)control{
    if (control.selectedSegmentIndex == 0) {
        NSLog(@"The first one");

        self.needs = YES;
        [PFCloud callFunctionInBackground:@"wants"
                           withParameters:@{}
                                    block:^(NSArray *result, NSError *error) {
                                        if (!error) {
                                            // result is @"Hello world!"
                                            self.servicesArray = result;
                                        }
                                        [self.servicesTableView reloadData];

                                    }];
    }else{
        NSLog(@"The second one");

        self.needs = NO;
        [PFCloud callFunctionInBackground:@"provides"
                           withParameters:@{}
                                    block:^(NSArray *result, NSError *error) {
                                        if (!error) {
                                            // result is @"Hello world!"
                                            self.servicesArray = result;
                                        }
                                        [self.servicesTableView reloadData];

                                    }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailSegue"]) {

        DetailViewController *vc = segue.destinationViewController;
        NSIndexPath *myIndexPath = [self.servicesTableView indexPathForSelectedRow];
        NSDictionary *dictionary = [self.servicesArray objectAtIndex: myIndexPath.row ];
        vc.infoDictionary = dictionary;
        vc.amIProviding = !self.needs;
    }
}

-(IBAction)unwindFromPost:(UIStoryboardSegue *) segue{}

@end

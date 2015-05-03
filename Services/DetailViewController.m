//
//  DetailViewController.m
//  Services
//
//  Created by Alex Hudson on 5/2/15.
//  Copyright (c) 2015 HudsonApps. All rights reserved.
//

#import "DetailViewController.h"
#import <Parse/Parse.h>
#import "DetailTableViewCell.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *matchesArray;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Details";

   // NSLog(@"%@", self.infoDictionary);
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

    NSString *category = [self.infoDictionary objectForKey:@"category"];
    NSString *city = [self.infoDictionary objectForKey:@"city"];

    NSLog(@"%@", category);
    NSLog(@"%@", city);


    if (self.amIProviding) {

        [PFCloud callFunctionInBackground:@"providesMatch"
                           withParameters:@{@"category" : category, @"city" : city}
                                    block:^(NSArray *result, NSError *error) {
                                        if (!error) {
                                            // result is @"Hello world!"

                                            self.matchesArray = result;

                                            if (result) {
                                                NSDictionary *dictionary = [result objectAtIndex:0];
                                                NSLog(@"dictionary: %@", dictionary );
                                            }

                                            [self.detailTableView reloadData];
                                        }
                                    }];


    } else {
    [PFCloud callFunctionInBackground:@"wantsMatch"
                       withParameters:@{@"category" : category, @"city" : city}
                                block:^(NSArray *result, NSError *error) {
                                    if (!error) {
                                        // result is @"Hello world!"

                                        self.matchesArray = result;

                                        if (result) {
                                            NSDictionary *dictionary = [result objectAtIndex:0];
                                            NSLog(@"dictionary: %@", dictionary );
                                        }

                                        [self.detailTableView reloadData];
                                    }
                                }];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;

}
//tells the table view how many cells there will be
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.matchesArray.count;
}

//fills the cells to with the info and images from the parse
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    NSDictionary *dictionary = [self.matchesArray objectAtIndex:indexPath.row];

    cell.nameLabel.text = [dictionary objectForKey:@"screenName"];

    [cell.numberButton setTitle:[dictionary objectForKey:@"phoneNumber"] forState:UIControlStateNormal];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //  [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

@end

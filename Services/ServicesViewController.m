//
//  ServicesViewController.m
//  Services
//
//  Created by Alex Hudson on 5/2/15.
//  Copyright (c) 2015 HudsonApps. All rights reserved.
//

#import "ServicesViewController.h"

@interface ServicesViewController () <UITableViewDataSource, UITableViewDelegate>

@property NSArray * servicesArray;

@end

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.servicesArray = @[@1 , @2];
    // Do any additional setup after loading the view.
}

//tells the table view how many cells there will be
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.servicesArray.count;
}

//fills the cells to with the info and images from the parse
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{



    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.textLabel.text = @"test";

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

      //  [self performSegueWithIdentifier:@"detailSegue" sender:self];
}


@end

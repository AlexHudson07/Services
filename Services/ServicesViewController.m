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

    self.navigationItem.title = @"Services";

    UIImage *sprocket= [UIImage imageNamed:@"sprocket"];
    UIButton *face1 = [UIButton buttonWithType:UIButtonTypeCustom];
    face1.bounds = CGRectMake( 10, 0, sprocket.size.width, sprocket.size.height );
    [face1 addTarget:self action:@selector(goToSettings) forControlEvents:UIControlEventTouchUpInside];
    [face1 setImage:sprocket forState:UIControlStateNormal];
    UIBarButtonItem *backButton1 = [[UIBarButtonItem alloc] initWithCustomView:face1];
    self.navigationItem.rightBarButtonItem = backButton1;
    // Do any additional setup after loading the view.
}

-(void)goToSettings{
    NSLog(@"Going to settings");
    [self performSegueWithIdentifier:@"settingsSegue" sender:self];
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

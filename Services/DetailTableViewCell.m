//
//  DetailTableViewCell.m
//  Services
//
//  Created by Alex Hudson on 5/2/15.
//  Copyright (c) 2015 HudsonApps. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)onPhoneButtonPressed:(id)sender {

    UIApplication *myApp = [UIApplication sharedApplication];
    NSString *theCall = [NSString stringWithFormat:@"tel://%@",self.numberButton.titleLabel.text];
    NSLog(@"making call with %@",theCall);
    [myApp openURL:[NSURL URLWithString:theCall]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

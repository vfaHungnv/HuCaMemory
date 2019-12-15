//
//  TopViewController.m
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 3/20/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#import "TopViewController.h"

@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (IBAction)actStart:(id)sender {
    [self performSegueWithIdentifier:SEGUE_START sender:nil];
}

- (IBAction)actRanking:(id)sender {
    [self performSegueWithIdentifier:SEGUE_RANKING sender:nil];
}

- (IBAction)actManual:(id)sender {
    [self performSegueWithIdentifier:SEGUE_MANUAL sender:nil];
}

- (IBAction)actAbout:(id)sender {
    [self performSegueWithIdentifier:SEGUE_ABOUT sender:nil];
}

- (IBAction)actOtherGame:(id)sender {
    NSString *urlString = URL_ITUNES_APPLE;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end

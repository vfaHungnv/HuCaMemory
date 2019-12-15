//
//  ManualViewController.m
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 3/20/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#import "ManualViewController.h"

@interface ManualViewController ()

@end

@implementation ManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMoveTop:)];
    [tap setDelegate:self];
    tap.cancelsTouchesInView = NO;
    [_imgManual addGestureRecognizer:tap];
}

- (void)tapMoveTop:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backActionClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

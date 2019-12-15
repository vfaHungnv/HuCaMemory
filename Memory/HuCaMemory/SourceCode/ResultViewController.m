//
//  ResultViewController.m
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 4/10/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#import "ResultViewController.h"
#import "ScoreObject.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _lblScore.text = [NSString stringWithFormat:@"%d", _score];
    if ([ScoreObject checkScoreInTop:_score inFile:SCORE_FILE_NAME]) {
        _imgRankIn.hidden = NO;
    }
    else {
        _imgRankIn.hidden = YES;
    }
}

- (IBAction)actReplay:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actMoveTop:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)actOtherGame:(id)sender {
    NSString *urlString = URL_ITUNES_APPLE;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
@end

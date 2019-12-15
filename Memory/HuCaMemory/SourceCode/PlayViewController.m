//
//  PlayViewController.m
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 3/20/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#import "PlayViewController.h"
#import "ResultViewController.h"
#import "ScoreObject.h"

@interface PlayViewController ()
{
    int totalPoint;
    int intCurrentHuCaMemory;
    NSMutableArray *arrRandomPosition;
    NSMutableArray *arrChoosePosition;
}

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initSetup {
    _lblMaxHuCaMemory.text = [NSString stringWithFormat:@"%d", MAXHuCaMemory];
    intCurrentHuCaMemory = 1;
    totalPoint = 0;
    [_btnDone setEnabled:NO];
}

- (void)setExclusiveTouch {
    for (int i = 1; i <= 25; i++) {
        UIButton *btnItem = (UIButton *)[self.view viewWithTag:i];
        [btnItem setExclusiveTouch:YES];
    }
    [_btnDone setExclusiveTouch:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initSetup];
    [self setExclusiveTouch];
    [self showHuCaMemoryView];
    _lblTotalPoint.text = @"0 score";
}

- (void)showHuCaMemoryView {
    _lblCurrentHuCaMemory.text = [NSString stringWithFormat:@"%d", intCurrentHuCaMemory];
    _lblScore.hidden = YES;
    
    [self initValue];
    [self randomPosition];
    [self showRandomPosition];
    [self performSelector:@selector(resetStateScreen) withObject:nil afterDelay:3.0];
}

- (void)initValue {
    NSArray *arrValue = [NSArray arrayWithObjects:
                         [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1],
                         [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1],
                         [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1],
                         [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1],
                         [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1],
                         [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1],
                         [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1],
                         [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1], [NSNumber numberWithInt:-1],
                         [NSNumber numberWithInt:-1], nil];
    if (arrRandomPosition != nil) {
        [arrRandomPosition removeAllObjects];
        [arrRandomPosition addObjectsFromArray:arrValue];
    }
    else {
        arrRandomPosition = [[NSMutableArray alloc] initWithArray:arrValue];
    }
    
    if (arrChoosePosition != nil) {
        [arrChoosePosition removeAllObjects];
        [arrChoosePosition addObjectsFromArray:arrValue];
    }
    else {
        arrChoosePosition = [[NSMutableArray alloc] initWithArray:arrValue];
    }
}

- (void)randomPosition {
    int maxRandomPosition = (arc4random() % 5) + 5;
    for (int i = 0; i <= maxRandomPosition;) {
        int r = arc4random() % arrRandomPosition.count;
        if ([[arrRandomPosition objectAtIndex:r] intValue] == -1) {
            [arrRandomPosition replaceObjectAtIndex:r withObject:[NSNumber numberWithInt:r]];
            i++;
        }
    }
}

- (void)showRandomPosition {
    for (int i = 0; i < arrRandomPosition.count; i++) {
        UIButton *btnItem = (UIButton *)[self.view viewWithTag:(i + 1)];
        [btnItem setAlpha:1.0f];
        if ([[arrRandomPosition objectAtIndex:i] intValue] != -1) {
            [btnItem setImage:[UIImage imageNamed:SELECTROUND] forState:UIControlStateNormal];
        }
        else {
            [btnItem setImage:[UIImage imageNamed:NORMALROUND] forState:UIControlStateNormal];
        }
    }
    intCurrentHuCaMemory++;
}

- (void)resetStateScreen {
    for (int i = 0; i < arrRandomPosition.count; i++) {
        if ([[arrRandomPosition objectAtIndex:i] intValue] != -1) {
            UIButton *btnItem = (UIButton *)[self.view viewWithTag:(i + 1)];
            [btnItem setImage:[UIImage imageNamed:NORMALROUND] forState:UIControlStateNormal];
        }
    }
    [_btnDone setEnabled:YES];
}

- (IBAction)actClick:(id)sender {
    UIButton *btnItem = (UIButton *)sender;
    if ([[arrChoosePosition objectAtIndex:(btnItem.tag - 1)] intValue] == -1) {
        [arrChoosePosition replaceObjectAtIndex:(btnItem.tag - 1) withObject:[NSNumber numberWithLong:(btnItem.tag - 1)]];
        [btnItem setImage:[UIImage imageNamed:SELECTROUND] forState:UIControlStateNormal];
    }
    else {
        [arrChoosePosition replaceObjectAtIndex:(btnItem.tag - 1) withObject:[NSNumber numberWithInt:-1]];
        [btnItem setImage:[UIImage imageNamed:NORMALROUND] forState:UIControlStateNormal];
    }
}

- (IBAction)actDone:(id)sender {
    [_btnDone setEnabled:NO];
    int ok_count = 0;
    int point = 0;
    int total_click = 0;
    for (int i = 0; i < arrChoosePosition.count; i++) {
        UIButton *btnItem = (UIButton *)[self.view viewWithTag:(i + 1)];
//        DEVLOG(@"i = %d, choose = %d, random = %d", i, [[arrChoosePosition objectAtIndex:i] intValue], [[arrRandomPosition objectAtIndex:i] intValue]);
        if ([[arrChoosePosition objectAtIndex:i] intValue] == [[arrRandomPosition objectAtIndex:i] intValue]) {
            if ([[arrChoosePosition objectAtIndex:i] intValue] != -1) {
                ok_count++;
            }
        }
        if ([[arrChoosePosition objectAtIndex:i] intValue] != -1 || [[arrRandomPosition objectAtIndex:i] intValue] != -1) {
            total_click++;
        }
        if ([[arrRandomPosition objectAtIndex:i] intValue] != -1) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"position.x";
            animation.values = @[@0, @10, @-10, @10, @-5, @5, @-5, @0 ];
            animation.keyTimes = @[@0, @0.125, @0.25, @0.375, @0.5, @0.625, @0.75, @0.875, @1];
            animation.duration = 0.4;
            animation.additive = YES;
            [btnItem.layer addAnimation:animation forKey:@"shake"];
        }
        else {
            [btnItem setAlpha:.5f];
        }
    }
    point = (int)(ok_count * 100/total_click);
    totalPoint += point;
    _lblTotalPoint.text = [NSString stringWithFormat:@"%d score", totalPoint];
    [self showNextScreen:point];
}

- (void)showNextScreen:(int)point {
    _lblScore.text = [NSString stringWithFormat:@"%d%%", point];
    _lblScore.hidden = NO;
    if (intCurrentHuCaMemory <= MAXHuCaMemory) {
        [self performSelector:@selector(showHuCaMemoryView) withObject:nil afterDelay:1.5];
    }
    else {
        [self performSelector:@selector(showMoveResult) withObject:nil afterDelay:1.5];
    }
}

- (void)showMoveResult {
    [ScoreObject updateScore:totalPoint toFile:SCORE_FILE_NAME];
    [self performSegueWithIdentifier:SEGUE_RESULT sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:SEGUE_RESULT]) {
        ResultViewController *result = [segue destinationViewController];
        result.score = totalPoint;
    }
}
@end

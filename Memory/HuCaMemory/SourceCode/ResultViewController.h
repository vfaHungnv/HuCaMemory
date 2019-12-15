//
//  ResultViewController.h
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 4/10/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (nonatomic, assign) int score;
@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UIImageView *imgRankIn;
- (IBAction)actReplay:(id)sender;
- (IBAction)actMoveTop:(id)sender;
- (IBAction)actOtherGame:(id)sender;

@end

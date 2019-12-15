//
//  RankingViewController.h
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 3/20/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tvScore;

- (IBAction)actBack:(id)sender;
- (IBAction)actRateThisApp:(id)sender;

@end

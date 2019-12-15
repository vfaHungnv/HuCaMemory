//
//  ScoreObject.h
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 4/10/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreObject : NSObject

//Get list scores from file
+ (NSMutableArray *)getScoreFromFile:(NSString *)fileName;

//Update score to save to file
+ (void)updateScore:(int)score toFile:(NSString *)fileName;

//Check score in top file
+ (BOOL)checkScoreInTop:(int)score inFile:(NSString *)fileName;

@end

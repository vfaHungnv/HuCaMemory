//
//  ScoreObject.m
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 4/10/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#import "ScoreObject.h"

@implementation ScoreObject

//Get list scores from file
+ (NSMutableArray *)getScoreFromFile:(NSString *)fileName {
    NSString *fullPath = [self getStringForFileName:fileName];
    NSMutableArray *scoreFromData = [[NSMutableArray alloc] initWithContentsOfFile:fullPath];
    if (!scoreFromData) {
        scoreFromData = [[NSMutableArray alloc] initWithObjects:@0, @0, @0, @0, @0, nil];
        return scoreFromData;
    }
    if (scoreFromData.count > 1) {
        [scoreFromData sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 intValue] <= [obj2 intValue]) {
                return YES;
            }
            return NO;
        }];
    }
    return scoreFromData;
}

//Update score to save to file
+ (void)updateScore:(int)score toFile:(NSString *)fileName {
    NSString *fullPath = [self getStringForFileName:fileName];
    NSMutableArray *scoreFromData = [[NSMutableArray alloc] initWithContentsOfFile:fullPath];
    if (!scoreFromData) {
        scoreFromData = [[NSMutableArray alloc] initWithCapacity:1];
    }
    [scoreFromData addObject:[NSNumber numberWithInt:score]];
    if (scoreFromData.count > 1) {
        [scoreFromData sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj1 intValue] <= [obj2 intValue]) {
                return YES;
            }
            return NO;
        }];
    }
    if (scoreFromData.count > 5) {
        NSRange range = {5, scoreFromData.count - 5};
        [scoreFromData removeObjectsInRange:range];
    }
    else if (scoreFromData.count < 5) {
        for (int i = (int)scoreFromData.count; i < 5; i++) {
            [scoreFromData addObject:@0];
        }
    }
//    DEVLOG(@"Update score - %@", @[scoreFromData]);
    BOOL result = [scoreFromData writeToFile:fullPath atomically:YES];
    if (result) {
//        DEVLOG(@"Write to file sucessfully!");
    }
    else {
//        DEVLOG(@"Get error when writing to file");
    }
}

//Check score in top file
+ (BOOL)checkScoreInTop:(int)score inFile:(NSString *)fileName {
    NSMutableArray *scoreArray = [self getScoreFromFile:fileName];
    if (score > [[scoreArray lastObject] intValue]) {
        return  YES;
    }
    return NO;
}

+ (NSString *)getStringForFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}
@end

//
//  iDefine.h
//  HuCaMemory
//
//  Created by Nguyen Van Hung on 3/20/16.
//  Copyright © 2016 hungnv. All rights reserved.
//

#ifndef iDefine_h
#define iDefine_h

#define NORMALROUND @"round_01"
#define SELECTROUND @"round_02"
#define MAXHuCaMemory 1

//Sreen Size
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define APP_DELEGATE  ((AppDelegate*)[UIApplication sharedApplication].delegate)
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

//Segue
#define SEGUE_START @"start_id"
#define SEGUE_RANKING @"ranking_id"
#define SEGUE_MANUAL @"manual_id"
#define SEGUE_ABOUT @"about_id"
#define SEGUE_OTHER_GAME @"other_game_id"
#define SEGUE_RESULT @"result_id"

#define URL_ITUNES_APPLE  @"http://vnexpress.net"
#define TOTAL_SCORE @"total_score"
#define SCORE_FILE_NAME   @"score_file_name.plist"

#endif /* iDefine_h */

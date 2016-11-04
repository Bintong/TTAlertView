//
//  HBCommon.h
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#ifndef HBCommon_h
#define HBCommon_h

#pragma mark -
#pragma mark URLHOST Define

#if DEBUG

      #define kBaseHost        @"http://42.96.170.112/"

#elif DEVELOPER_DEBUG

      #define kBaseHost        @"http://42.96.170.112/"

#elif MOCK_DEBUG

      #define kBaseHost        @"http://116.236.184.236:9083/mockjsdata/5/"

#else

      #define kBaseHost        @"http://42.96.170.112/"

#endif

#pragma mark -
#pragma mark Common Define

#define APP_ID                 @""
#define APP_VERSION            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_DISPLAY_NAME       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define SCREEN_SIZE            SCREEN_BOUNDS.size
#define SCREEN_WIDTH           SCREEN_SIZE.width
#define SCREEN_HEIGHT          SCREEN_SIZE.height
#define SCREEN_BOUNDS          [[UIScreen mainScreen] bounds]

#define TAB_BAR_HEIGHT         [[APPDelegate rootController] tabBar].height
#define TAB_CONTENT_RECT       CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-TAB_BAR_HEIGHT)

#endif

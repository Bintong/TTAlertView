//
//  JFFrameDefine.h
//  JiuFuWallet
//
//  Created by BinTong on 2017/11/22.
//  Copyright © 2017年 jayden. All rights reserved.
//

#ifndef JFFrameDefine_h
#define JFFrameDefine_h

#define APP_VERSION            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define APP_DISPLAY_NAME       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define SCREEN_BOUNDS          [[UIScreen mainScreen] bounds]
#define SCREEN_SIZE            SCREEN_BOUNDS.size
#define SCREEN_WIDTH           SCREEN_SIZE.width
#define SCREEN_HEIGHT          SCREEN_SIZE.height

#define STATUSBAR_HEIGHT       [[UIApplication sharedApplication] statusBarFrame].size.height
#define NAVIGATION_HEIGHT      self.navigationController.navigationBar.height
//#define TAB_BAR_HEIGHT         APPDelegate.rootController.tabBar.height
#define TAB_CONTENT_RECT       CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT-TAB_BAR_HEIGHT)


#endif /* JFFrameDefine_h */

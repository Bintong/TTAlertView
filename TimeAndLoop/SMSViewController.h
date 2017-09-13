//
//  SMSViewController.h
//  TimeAndLoop
//
//  Created by BinTong on 2017/8/31.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageType) {
    PageOpenID,
    PageQuotaASpproved
};

@interface SMSViewController : UIViewController

@property(nonatomic, assign) PageType pageType;


@end

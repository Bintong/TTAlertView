//
//  LeakViewController.h
//  TimeAndLoop
//
//  Created by BinTong on 2017/9/13.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TestBlock)(void);

@interface LeakViewController : UIViewController

@property (nonatomic, copy) TestBlock block;


@end

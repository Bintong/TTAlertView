//
//  TTAlertViewController.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/3.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTAction.h"
@interface TTAlertViewController : UIViewController

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message andType:(int)type;

- (void)addAction:(TTAction *)action;

- (void)show;

@end

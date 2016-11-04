//
//  TTAlertView.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/4.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTAlertView : UIView <UITextFieldDelegate>




+ (void)show;


+ (void)showWithCommitBlock:(void(^)(NSString *codeString))success  andCannel:(dispatch_block_t)cannel;



@end

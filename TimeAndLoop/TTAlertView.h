//
//  TTAlertView.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/4.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTAlertView : UIView <UITextFieldDelegate>

+ (void)showAlertViewWithTitle:(NSString *)title commitBlock:(void(^)(NSString *codeString))commit cannel:(dispatch_block_t)cannel ;

+ (void)showAlertViewWithTitle:(NSString *)title
                   commitBlock:(void (^)(NSString *))commit
                    rightBlock:(dispatch_block_t)right
                        cannel:(dispatch_block_t)cannel;


+ (void)showAlertViewWithBigTitle:(NSString *)title
             andBottomDescribe:(NSString *)describe
                   commitBlock:(void(^)(NSString *codeString))commit
                        cannel:(dispatch_block_t)cannel;





@end

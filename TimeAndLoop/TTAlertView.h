//
//  TTAlertView.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/4.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RefreshButtonBlock)(UIButton *button);


@interface TTAlertView : UIView <UITextFieldDelegate>

+ (TTAlertView *)sharedAlertView;

+ (void)showAlertViewWithTitle:(NSString *)title bottomTitle:(NSString *)bottomTitle placeholder:(NSString *)place commitBlock:(void(^)(NSString *codeString))commit cannel:(dispatch_block_t)cannel;



/**
 有倒计时的情况弹框
 
 @param title 倒计时的title
 @param commit 提交
 @param right 倒计时按钮
 @param cannel 取消
 */
+ (void)showAlertViewWithTitle:(NSString *)title
                   commitBlock:(void (^)(NSString *))commit
                    rightBlock:(dispatch_block_t)right
                        cannel:(dispatch_block_t)cannel;

//没有副标题的
+ (void)showNOSubAlertViewTitle:(NSString *)title placeholder:(NSString *)place commitBlock:(void(^)(NSString *codeString))commit cannel:(dispatch_block_t)cannel;

//只有textField
+ (void)showTextFieldWithPlaceHolder:(NSString *)place commitBlock:(void(^)(NSString *codeString))commit cannel:(dispatch_block_t)cannel;


//没有textfield的声明弹框
+ (void)showAlertWithBigTitle:(NSString *)title  andBottomDescribe:(NSString *)describe BeginVerity:(dispatch_block_t)beginBlock buttonTitle:(NSString *)buttonTitle;


//验证码按钮

+ (void)showTextFieldWithVerificationPlaceHolder:(NSString *)place rightButton:(UIButton *)button
                                      rightClick:(RefreshButtonBlock)right
                                     commitBlock:(void(^)(NSString *codeString))commit
                                          cannel:(dispatch_block_t)cannel;

//更换title 提示
- (void)changeTitle:(NSString *)redTitle;

//消失
+ (void)dismiss;
 
@end

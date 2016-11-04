//
//  TTAlertView.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/4.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "TTAlertView.h"
#import <objc/runtime.h>

static UIWindow *alertWindow = nil;
static UITextField *textField = nil;
static char cannelKey;
static char sureKey;


@implementation TTAlertView
+ (TTAlertView *)sharedAlertView
{
    static TTAlertView *alert = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        alert = [[self alloc] init];
    });
    return alert;
}
+ (void)buildWindow {
    alertWindow = [[UIWindow alloc]initWithFrame:SCREEN_BOUNDS];
    alertWindow.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
    alertWindow.autoresizesSubviews = YES;
    alertWindow.hidden = NO;
    alertWindow.windowLevel = 100+ UIWindowLevelStatusBar;
    [alertWindow makeKeyAndVisible];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = text;
    return lbTitle;
}


+ (UITextField *)textFieldFrame:(CGRect )frame placeHolder:(NSString *)placeHolder {
    textField = [[UITextField alloc]initWithFrame:frame];
    [textField setBorderStyle:UITextBorderStyleNone];
    textField.placeholder = placeHolder;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.returnKeyType = UIReturnKeyDone;
    textField.font = [UIFont systemFontOfSize:14];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor colorWithRed:0xe3/255.0f green:0xf4/255.0f blue:0xfb/255.0f alpha:1];
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.layer.cornerRadius = 3;
    textField.layer.masksToBounds = YES;
    return textField;
 }

+ (void)buildCommenView: (void(^)(NSString *codeString))success andCannel:(dispatch_block_t)cannel {
    [TTAlertView buildWindow];
    CGRect bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 185);
    UIView *bgView = [[UIView alloc ]initWithFrame:bRect];
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [alertWindow addSubview:bgView];
    UILabel *lab = [TTAlertView labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(15,0, bgView.width - 30, 75) Text:@"hello world"];
    [bgView addSubview:lab];
    UITextField *midTextField = [TTAlertView textFieldFrame:CGRectMake(15, lab.bottom, bgView.width - 30, 40) placeHolder:@"请输入短信验证码"];
    [bgView addSubview:midTextField];
    
    UIButton *sureBt = [TTAlertView buildButtonWithFrame:CGRectMake(bgView.width/2, bgView.height - 44, bgView.width/2, 44) title:@"确定"];
    [sureBt setBackgroundColor:HB_COLOR_A];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &sureKey, success, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [sureBt addTarget:[TTAlertView sharedAlertView] action:@selector(sureCallActionBlock:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cannelBt = [TTAlertView buildButtonWithFrame:CGRectMake(0, bgView.height - 44, bgView.width/2, 44) title:@"取消"];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &cannelKey, cannel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [cannelBt setBackgroundColor:[UIColor colorWithRed:0xb1/255.0f green:0xb1/255.0f blue:0xb1/255.0f alpha:1]];
    [cannelBt addTarget:[TTAlertView  sharedAlertView]action:@selector(cannelCallActionBlock:) forControlEvents:UIControlEventTouchUpInside];
  
    [bgView addSubview:cannelBt];
    [bgView addSubview:sureBt];
}

+ (void)showWithCommitBlock:(void(^)(NSString *codeString))success  andCannel:(dispatch_block_t)cannel {
    dispatch_async(dispatch_get_main_queue(), ^{
        [TTAlertView buildCommenView:success andCannel:cannel];
    });
}


+ (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        [TTAlertView buildWindow];
        CGRect bRect = CGRectMake(0, 0, SCREEN_WIDTH - 60, 100);
        UIView *bgView = [[UIView alloc ]initWithFrame:bRect];
        bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        [alertWindow addSubview:bgView];
     
        UIButton *cannelBt = [TTAlertView buildButtonWithFrame:CGRectMake(0, 56, bgView.width/2, 44) title:@"取消"];
        UIButton *sureBt = [TTAlertView buildButtonWithFrame:CGRectMake(bgView.width/2, 56, bgView.width/2, 44) title:@"确定"];
        [bgView addSubview:cannelBt];
        [bgView addSubview:sureBt];
    });
}


- (void)cannelCallActionBlock: (id)sender {
     dispatch_block_t block_cannel = (dispatch_block_t)objc_getAssociatedObject(self, &cannelKey);
    if (block_cannel) {
        block_cannel();
    }
}

- (void)sureCallActionBlock: (id)sender {
    typedef void (^Block_sure)(NSString *codeString);

     Block_sure block_sure = (Block_sure)objc_getAssociatedObject(self, &sureKey);
    if (block_sure) {
        block_sure(textField.text);
        [TTAlertView dismiss];
    }
}

+ (UIButton *)buildButtonWithFrame:(CGRect)frame title:(NSString *)title{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    [bt setTitleColor:HB_COLOR_C forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.backgroundColor = [UIColor whiteColor];
    return bt;
}


+ (void)dismiss {
    dispatch_async(dispatch_get_main_queue(),^{
        for (UIView *subView in alertWindow.subviews) {
            [subView removeFromSuperview];
        }
        alertWindow.hidden = YES;
        [alertWindow resignKeyWindow];
        alertWindow.windowLevel = UIWindowLevelNormal;
        [[[UIApplication sharedApplication] delegate].window makeKeyAndVisible];
        alertWindow = nil;
    });
}


@end

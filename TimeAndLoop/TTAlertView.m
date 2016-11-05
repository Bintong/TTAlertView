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
static char rightKey;

@interface TTAlertView ()

@property(nonatomic, strong)UIView *alertView;

@end
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

+ (void)buildCommenView: (void(^)(NSString *codeString))success
            rightCommit:(dispatch_block_t)rightBlock
           hasRightView:(BOOL)right
              andCannel:(dispatch_block_t)cannel
              title:(NSString *)title
              subTitle:(NSString *)subTitle
              titleFont:(CGFloat)fontfloat {
    [TTAlertView buildWindow];
    CGRect bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 185);
    BOOL hasSubTitle = (subTitle != nil) && (subTitle.length > 0 );
    if (hasSubTitle) {
        bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 222);
    }
    
    UIView *bgView = [[UIView alloc ]initWithFrame:bRect];
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    [alertWindow addSubview:bgView];
    UILabel *lab = [TTAlertView labelWithFontSize:(fontfloat > 0 ?fontfloat:15) FontColor:HB_COLOR_B frame:CGRectMake(15,0, bgView.width - 30, 75) Text:title];
    [bgView addSubview:lab];
    //textField
    UITextField *midTextField = [TTAlertView textFieldFrame:CGRectMake(15, lab.bottom, bgView.width - 30, 40) placeHolder:@"请输入短信验证码"];
    if (right) {
        UIButton *rightButton =  [TTAlertView buildButtonWithFrame:CGRectMake(0, 0, 90, 40) title:@"获取验证码" andSel:@selector(getTheVerificationCode:)];
        objc_setAssociatedObject([TTAlertView sharedAlertView], &rightKey, rightBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [rightButton setBackgroundColor:HB_COLOR_A];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        midTextField.rightView = rightButton;
        midTextField.rightViewMode = UITextFieldViewModeAlways;
    }
    [bgView addSubview:midTextField];
    
    
    //subtitle
    if (hasSubTitle) {
        UILabel *subLab = [TTAlertView labelWithFontSize:12 FontColor:HB_COLOR_B frame:CGRectMake(midTextField.bottom + 20,0, bgView.width - 30, 20) Text:subTitle];
        subLab.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:subLab];
    }
    
    //button
    UIButton *sureBt = [TTAlertView buildButtonWithFrame:CGRectMake(bgView.width/2, bgView.height - 44, bgView.width/2, 44) title:@"提交" andSel:@selector(sureCallActionBlock:)];
    [sureBt setBackgroundColor:HB_COLOR_A];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &sureKey, success, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    
    UIButton *cannelBt = [TTAlertView buildButtonWithFrame:CGRectMake(0, bgView.height - 44, bgView.width/2, 44) title:@"取消" andSel:@selector(cannelCallActionBlock:)];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &cannelKey, cannel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [cannelBt setBackgroundColor:[UIColor colorWithRed:0xb1/255.0f green:0xb1/255.0f blue:0xb1/255.0f alpha:1]];
   
    [bgView addSubview:cannelBt];
    [bgView addSubview:sureBt];
    
    [TTAlertView sharedAlertView].alertView = bgView;
    [TTAlertView registerForKeyboardNotifications];
    
}


+ (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:[TTAlertView sharedAlertView]
                                             selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:[TTAlertView sharedAlertView] selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"hight_hitht:%f",kbSize.height);
    self.alertView.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT - kbSize.height)/2 + 15);
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"hight_hitht:%f",kbSize.height);
 
    
}

+ (void)showAlertViewWithTitle:(NSString *)title
                   commitBlock:(void(^)(NSString *codeString))commit
                        cannel:(dispatch_block_t)cannel {
    dispatch_async(dispatch_get_main_queue(), ^{
        [TTAlertView buildCommenView:commit  rightCommit:nil hasRightView:NO  andCannel:cannel title:title subTitle:nil titleFont:0];
    });
}
+ (void)showAlertViewWithTitle:(NSString *)title  commitBlock:(void (^)(NSString *))commit rightBlock:(dispatch_block_t)right cannel:(dispatch_block_t)cannel  {
    [TTAlertView buildCommenView:commit  rightCommit:right hasRightView:YES   andCannel:cannel title:title subTitle:nil titleFont:0];
}


+ (void)showAlertViewWithBigTitle:(NSString *)title
             andBottomDescribe:(NSString *)describe
                   commitBlock:(void(^)(NSString *codeString))commit
                        cannel:(dispatch_block_t)cannel {
    dispatch_async(dispatch_get_main_queue(), ^{
        [TTAlertView buildCommenView:commit rightCommit:nil hasRightView:NO andCannel:cannel title:title subTitle:describe titleFont:16];
    });
}




+ (void)show {

}


- (void)cannelCallActionBlock: (id)sender {
     dispatch_block_t block_cannel = (dispatch_block_t)objc_getAssociatedObject(self, &cannelKey);
    if (block_cannel) {
        block_cannel();
    }
}

- (void)getTheVerificationCode:(id)sender {
    dispatch_block_t block_right = (dispatch_block_t)objc_getAssociatedObject(self, &rightKey);
    if (block_right) {
        block_right();
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

+ (UIButton *)buildButtonWithFrame:(CGRect)frame title:(NSString *)title andSel:(SEL)selecter{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:16];
    [bt setTitleColor:HB_COLOR_C forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.backgroundColor = [UIColor whiteColor];
    [bt addTarget:[TTAlertView  sharedAlertView] action:selecter forControlEvents:UIControlEventTouchUpInside];
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

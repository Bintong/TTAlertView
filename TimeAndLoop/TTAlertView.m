//
//  TTAlertView.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/4.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "TTAlertView.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#define kshowViewTag  44376


static UIWindow *alertWindow = nil;
static UITextField *textField = nil;
static char cannelKey;
static char sureKey;
static char rightKey;
static char rightChangeImg;
static char okKey;


@interface TTAlertView ()

@property(nonatomic, strong) UIView *alertView;
@property(nonatomic, strong) UILabel *titleLabel;

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
    alertWindow = APPDelegate.window;
    UIView *alphaView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS ];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.8f;
    alphaView.tag = 100101;
    [alphaView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:[TTAlertView sharedAlertView] action:@selector(tapAction:)]];
    [APPDelegate.window addSubview:alphaView];
}

- (void)tapAction:(id)sender {
    
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


+ (void)buildDescripAlertViewTitle:(NSString *)title descrip:(NSString *)des buttonTitle:(NSString *)buttontitle bottomAction:(dispatch_block_t)action {
    [TTAlertView buildWindow];
    CGRect bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 185);
    
    UIView *bgView = [[UIView alloc ]initWithFrame:bRect];
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.tag = kshowViewTag;

    UILabel *lab = [TTAlertView labelWithFontSize:18 FontColor:HB_COLOR_B frame:CGRectMake(0,30, bgView.width, 18) Text:title];
    lab.font = [UIFont boldSystemFontOfSize:20];
    [bgView addSubview:lab];
    
    
    UILabel *subLab = [TTAlertView labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(15,lab.bottom + 15, bgView.width - 30, 0) Text:des];
    subLab.numberOfLines = 0;
    [subLab sizeToFit];
    subLab.textAlignment = NSTextAlignmentLeft;
    subLab.top = lab.bottom + 15;
    subLab.left = 15;
    [bgView addSubview:subLab];
    bgView.height =subLab.bottom + 30 + 44;
    
    //button
    UIButton *sureBt = [TTAlertView buildButtonWithFrame:CGRectMake(0, bgView.height - 44, bgView.width, 44) title:buttontitle andSel:@selector(okCallActionBlock:)];
    [sureBt setBackgroundColor:HB_COLOR_A];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &okKey, action, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [bgView addSubview:sureBt];
    [TTAlertView sharedAlertView].alertView = bgView;
    [TTAlertView registerForKeyboardNotifications];
    
    [TTAlertView beginAnimation:bgView dur:0.1];
    [alertWindow addSubview:bgView];
}


//

- (void)buildCommenView: (void(^)(NSString *codeString))success
            rightCommit:(dispatch_block_t)rightBlock
           hasRightView:(BOOL)right
         hasPlaceHolder:(NSString *)placeHolder
              andCannel:(dispatch_block_t)cannel
                  title:(NSString *)title
               subTitle:(NSString *)subTitle
              titleFont:(CGFloat)fontfloat
{
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
    bgView.tag = kshowViewTag;

    self.titleLabel = [TTAlertView labelWithFontSize:(fontfloat > 0 ?fontfloat:14) FontColor:HB_COLOR_B frame:CGRectMake(15,0, bgView.width - 30, 75) Text:title];
    [bgView addSubview:self.titleLabel];
    //textField
    UITextField *midTextField = [TTAlertView textFieldFrame:CGRectMake(15, self.titleLabel.bottom, bgView.width - 30, 40) placeHolder:placeHolder];
    if (right) {
        UIButton *rightButton =  [TTAlertView buildButtonWithFrame:CGRectMake(0, 0, 90, 40) title:@"获取验证码" andSel:@selector(getTheVerificationCode:)];
        objc_setAssociatedObject([TTAlertView sharedAlertView], &rightKey, rightBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [rightButton setBackgroundColor:HB_COLOR_A];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
        midTextField.rightView = rightButton;
        midTextField.rightViewMode = UITextFieldViewModeAlways;
        [[TTAlertView sharedAlertView] startTime:rightButton];
    }
    [bgView addSubview:midTextField];
    
    //subtitle
    if (hasSubTitle) {
        UILabel *subLab = [TTAlertView labelWithFontSize:12 FontColor:HB_COLOR_B frame:CGRectMake(20,midTextField.bottom + 20, bgView.width - 30, 20) Text:subTitle];
        subLab.textAlignment = NSTextAlignmentLeft;
        [subLab sizeToFit];
        subLab.left = 15;
        subLab.top = midTextField.bottom + 20;
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
    
    [TTAlertView beginAnimation:bgView dur:0.1];
    [alertWindow addSubview:bgView];
}



+ (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:[TTAlertView sharedAlertView]
                                             selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.alertView.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT - kbSize.height)/2 + 15);
}


+ (void)showAlertViewWithTitle:(NSString *)title bottomTitle:(NSString *)bottomTitle placeholder:(NSString *)place commitBlock:(void(^)(NSString *codeString))commit cannel:(dispatch_block_t)cannel {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [TTAlertView buildWindow];
        CGRect bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 185);
        bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 222);
        
        UIView *bgView = [[UIView alloc ]initWithFrame:bRect];
        bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 5;
        bgView.layer.masksToBounds = YES;
        bgView.tag = kshowViewTag;
        UILabel *titleLabel = [TTAlertView labelWithFontSize:18 FontColor:HB_COLOR_B frame:CGRectMake(15,0, bgView.width - 30, 75) Text:title];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [bgView addSubview:titleLabel];
        //textField
        UITextField *midTextField = [TTAlertView textFieldFrame:CGRectMake(15,titleLabel.bottom, bgView.width - 30, 40) placeHolder:place];
        [bgView addSubview:midTextField];
        
        UILabel *subLab = [TTAlertView labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(20,midTextField.bottom + 20, bgView.width - 30, 20) Text:bottomTitle];
        subLab.textAlignment = NSTextAlignmentLeft;
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:subLab.text];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(0x99, 0xcf, 0x17) range:NSMakeRange(12, 7)];
        [attributeStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(12, 7)];
        subLab.attributedText = attributeStr;
        [subLab sizeToFit];
        subLab.left = 15;
        subLab.top = midTextField.bottom + 20;
        subLab.height += 2;
        [bgView addSubview:subLab];
        
        //button
        UIButton *sureBt = [TTAlertView buildButtonWithFrame:CGRectMake(bgView.width/2, bgView.height - 44, bgView.width/2, 44) title:@"提交" andSel:@selector(sureCallActionBlock:)];
        [sureBt setBackgroundColor:HB_COLOR_A];
        objc_setAssociatedObject([TTAlertView sharedAlertView], &sureKey, commit, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        
        UIButton *cannelBt = [TTAlertView buildButtonWithFrame:CGRectMake(0, bgView.height - 44, bgView.width/2, 44) title:@"取消" andSel:@selector(cannelCallActionBlock:)];
        objc_setAssociatedObject([TTAlertView sharedAlertView], &cannelKey, cannel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [cannelBt setBackgroundColor:[UIColor colorWithRed:0xb1/255.0f green:0xb1/255.0f blue:0xb1/255.0f alpha:1]];
        
        [bgView addSubview:cannelBt];
        [bgView addSubview:sureBt];
        
        [[TTAlertView sharedAlertView] windowSetting:bgView];
 
    });
}

+ (void)showAlertViewWithTitle:(NSString *)title  commitBlock:(void (^)(NSString *))commit rightBlock:(dispatch_block_t)right cannel:(dispatch_block_t)cannel  {
    [[TTAlertView sharedAlertView] buildCommenView:commit  rightCommit:right hasRightView:YES  hasPlaceHolder:@"请输入短信验证码" andCannel:cannel title:title subTitle:nil titleFont:0];
}

+ (void)showNOSubAlertViewTitle:(NSString *)title
                    placeholder:(NSString *)place
                    commitBlock:(void(^)(NSString *codeString))commit
                         cannel:(dispatch_block_t)cannel {

    [TTAlertView buildWindow];
    CGRect bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 185);

    UIView *bgView = [[UIView alloc ]initWithFrame:bRect];
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.tag = kshowViewTag;

    UILabel *titleLabel = [TTAlertView labelWithFontSize:16 FontColor:HB_COLOR_B frame:CGRectMake(15,0, bgView.width - 30, 75) Text:title];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:titleLabel.text];
    [attribut addAttribute:NSForegroundColorAttributeName value:HB_COLOR_A range:NSMakeRange(7, 4)];
    [attribut addAttribute:NSForegroundColorAttributeName value:HB_COLOR_A range:NSMakeRange(12, 5)];
    titleLabel.attributedText = attribut;
    [bgView addSubview:titleLabel];
    //textField
    UITextField *midTextField = [TTAlertView textFieldFrame:CGRectMake(15,titleLabel.bottom, bgView.width - 30, 40) placeHolder:place];
    [bgView addSubview:midTextField];
    
    //button
    UIButton *sureBt = [TTAlertView buildButtonWithFrame:CGRectMake(bgView.width/2, bgView.height - 44, bgView.width/2, 44) title:@"提交" andSel:@selector(sureCallActionBlock:)];
    [sureBt setBackgroundColor:HB_COLOR_A];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &sureKey, commit, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    UIButton *cannelBt = [TTAlertView buildButtonWithFrame:CGRectMake(0, bgView.height - 44, bgView.width/2, 44) title:@"取消" andSel:@selector(cannelCallActionBlock:)];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &cannelKey, cannel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [cannelBt setBackgroundColor:[UIColor colorWithRed:0xb1/255.0f green:0xb1/255.0f blue:0xb1/255.0f alpha:1]];
    
    [bgView addSubview:cannelBt];
    [bgView addSubview:sureBt];
    
    
    [[TTAlertView sharedAlertView] windowSetting:bgView];

}

+ (void)showTextFieldWithPlaceHolder:(NSString *)place commitBlock:(void(^)(NSString *codeString))commit cannel:(dispatch_block_t)cannel {
    [TTAlertView buildWindow];
    CGRect bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 145);
    UIView *bgView = [[UIView alloc ]initWithFrame:bRect];
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.tag = kshowViewTag;

    UITextField *midTextField = [TTAlertView textFieldFrame:CGRectMake(15, (bgView.height -44-40)/2, bgView.width - 30, 40) placeHolder:place];
    [bgView addSubview:midTextField];
    UIButton *sureBt = [TTAlertView buildButtonWithFrame:CGRectMake(bgView.width/2, bgView.height - 44, bgView.width/2, 44) title:@"提交" andSel:@selector(sureCallActionBlock:)];
    [sureBt setBackgroundColor:HB_COLOR_A];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &sureKey, commit, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIButton *cannelBt = [TTAlertView buildButtonWithFrame:CGRectMake(0, bgView.height - 44, bgView.width/2, 44) title:@"取消" andSel:@selector(cannelCallActionBlock:)];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &cannelKey, cannel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [cannelBt setBackgroundColor:[UIColor colorWithRed:0xb1/255.0f green:0xb1/255.0f blue:0xb1/255.0f alpha:1]];
    
    [bgView addSubview:cannelBt];
    [bgView addSubview:sureBt];
    [[TTAlertView sharedAlertView] windowSetting:bgView];
}

+ (void)showTextFieldWithVerificationPlaceHolder:(NSString *)place rightButton:(UIButton *)button
                                      rightClick:(RefreshButtonBlock)right
                                     commitBlock:(void(^)(NSString *codeString))commit
                                          cannel:(dispatch_block_t)cannel {
    [TTAlertView buildWindow];
    CGRect bRect = CGRectMake(0, 0, SCREEN_WIDTH - 70, 145);
    
    
    UIView *bgView = [[UIView alloc ]initWithFrame:bRect];
    bgView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.tag = kshowViewTag;

    
    UITextField *midTextField = [TTAlertView textFieldFrame:CGRectMake(15, (bgView.height -44-40)/2, bgView.width - 30, 40) placeHolder:place];
    
    if (button) {
        button.frame = CGRectMake(0, 0, 90, 40);
        button.backgroundColor = [UIColor redColor];
        [button addTarget:[TTAlertView  sharedAlertView] action:@selector(refreshVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    objc_setAssociatedObject([TTAlertView sharedAlertView], &rightChangeImg, right, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    midTextField.rightView = button;
    midTextField.rightViewMode = UITextFieldViewModeAlways;
    [[TTAlertView sharedAlertView] getTheVerificationCode:button];
    [bgView addSubview:midTextField];
    
    //button
    UIButton *sureBt = [TTAlertView buildButtonWithFrame:CGRectMake(bgView.width/2, bgView.height - 44, bgView.width/2, 44) title:@"提交" andSel:@selector(sureCallActionBlock:)];
    [sureBt setBackgroundColor:HB_COLOR_A];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &sureKey, commit, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    UIButton *cannelBt = [TTAlertView buildButtonWithFrame:CGRectMake(0, bgView.height - 44, bgView.width/2, 44) title:@"取消" andSel:@selector(cannelCallActionBlock:)];
    objc_setAssociatedObject([TTAlertView sharedAlertView], &cannelKey, cannel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [cannelBt setBackgroundColor:[UIColor colorWithRed:0xb1/255.0f green:0xb1/255.0f blue:0xb1/255.0f alpha:1]];
    
    [bgView addSubview:cannelBt];
    [bgView addSubview:sureBt];
    
    [[TTAlertView sharedAlertView] windowSetting:bgView];
}


+ (void)showAlertWithBigTitle:(NSString *)title  andBottomDescribe:(NSString *)describe BeginVerity:(dispatch_block_t)beginBlock buttonTitle:(NSString *)buttonTitle{
    dispatch_async(dispatch_get_main_queue(), ^{
        [TTAlertView buildDescripAlertViewTitle:title descrip:describe buttonTitle:buttonTitle bottomAction:beginBlock];
    });
}


- (void)cannelCallActionBlock: (id)sender {
    dispatch_block_t block_cannel = (dispatch_block_t)objc_getAssociatedObject(self, &cannelKey);
    if (block_cannel) {
        block_cannel();
         
    }
}

- (void)refreshVerificationCode:(id)sender {
    RefreshButtonBlock refreshBlock = (RefreshButtonBlock)objc_getAssociatedObject(self, &rightChangeImg);
    if (refreshBlock) {
        refreshBlock(sender);
    }
}

- (void)getTheVerificationCode:(id)sender {
    dispatch_block_t block_right = (dispatch_block_t)objc_getAssociatedObject(self, &rightKey);
    if (block_right) {
                block_right();
        [[TTAlertView sharedAlertView] startTime:(UIButton *)sender];
    }
}

- (void)sureCallActionBlock: (id)sender {
    typedef void (^Block_sure)(NSString *codeString);
    Block_sure block_sure = (Block_sure)objc_getAssociatedObject(self, &sureKey);
    if (block_sure) {
        block_sure(textField.text);
        if (textField.text.length > 0) {
            [TTAlertView dismiss];
        }else {
            NSLog(@"提示，不能为空");
        }
        
    }
}

- (void)okCallActionBlock:(id)sender {
    typedef void (^Block_sure)();
    
    Block_sure block_sure = (Block_sure)objc_getAssociatedObject(self, &okKey);
    if (block_sure) {
        block_sure();
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
    [textField resignFirstResponder];
    UIView *backView = [alertWindow viewWithTag:kshowViewTag];
    UIView *bgView = [alertWindow viewWithTag:100101];
    bgView.hidden = YES;
    [bgView removeFromSuperview];
    if (backView)
    {
        for (UIView *subView in backView.subviews)
        {
            if ([subView isKindOfClass:[UIActivityIndicatorView class]])
            {
                [(UIActivityIndicatorView *)subView stopAnimating];
            }
            
            subView.hidden = YES;[subView removeFromSuperview];
        }
        
        backView.hidden = YES;[backView removeFromSuperview];
    }
}



-(void)startTime:(UIButton *)startActionButton{
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [startActionButton setTitle:@"重新发送" forState:UIControlStateNormal];
                [startActionButton setBackgroundColor:RGBCOLOR(0x99, 0xcf, 0x17)];
                startActionButton.userInteractionEnabled = YES;
            });
        }else{
            
            NSString *strTime = [NSString stringWithFormat:@"%.d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [startActionButton setTitle:[NSString stringWithFormat:@"%@S",strTime] forState:UIControlStateNormal];
                [startActionButton setBackgroundColor:HB_COLOR_A];
                [UIView commitAnimations];
                startActionButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


+(void)beginAnimation:(UIView *)outView dur:(CFTimeInterval)dur {
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = dur;
    animation.repeatCount = 1;
    animation.autoreverses = YES; // 动画结束时执行逆动画
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.05];
    [outView.layer addAnimation:animation forKey:@"scale-layer"];
    animation.removedOnCompletion = NO;
}

- (void)changeTitle:(NSString *)redTitle {
    self.titleLabel.text = redTitle;
    self.titleLabel.textColor = [UIColor redColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)windowSetting:(UIView *)bgView {
    self.alertView = bgView;
    [TTAlertView registerForKeyboardNotifications];
    [TTAlertView beginAnimation:bgView dur:0.1];
//    [alertWindow addSubview:bgView];
    [APPDelegate.window addSubview:bgView];
}

@end

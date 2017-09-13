//
//  SMSViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/8/31.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "SMSViewController.h"

@interface SMSViewController ()

@property(nonatomic, strong) UITableView *listView;

@property(nonatomic, strong) UITextField *textField;

@end

@implementation SMSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(0xf3,0xf3,0xf3);
    [self createListView];
    
    // Do any additional setup after loading the view.
}

- (void)createListView {
    
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    self.listView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.listView];
    
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
    [header bottomLineX:0 width:SCREEN_WIDTH color:kLineColor];
    header.backgroundColor = [UIColor whiteColor];
    self.listView.tableHeaderView = header;
    NSString *str;
    if (self.pageType == PageOpenID) {
        str = @"鉴于您的良好征信表现，厚本君已向华瑞银行推荐您的借款需求，稍后您会受到来自华瑞银行的短信验证码，请及时输入并提交！";
    }else {
        str = @"恭喜您！华瑞银行已批准您的借款申请，请输入您收到的华瑞银行借款申请验证码，只需一步即可实现资金到账！";
    }
    UILabel *la = [self labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(20, 20, SCREEN_WIDTH - 40, header.height - 40) Text:str];
    [header addSubview:la];
    
    
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 340)];
    footer.backgroundColor = [UIColor clearColor];
    self.listView.tableFooterView = footer;
    
    UILabel *phoneNumLabel = [self labelWithFontSize:14 FontColor:HB_COLOR_C frame:CGRectMake(20, 20, SCREEN_WIDTH - 40, 14) Text:@"已向18500154343的手机号码发送短信"];
    [footer addSubview:phoneNumLabel];
    
    
    UIView *textView = [[UIView alloc ]initWithFrame:CGRectMake(0, phoneNumLabel.bottom + 10, SCREEN_WIDTH, 40)];
    UITextField *midTextField = [self textFieldFrame:CGRectMake(20, 0,SCREEN_WIDTH - 40 , 40) placeHolder:@"请填写验证码"];
    [textView addSubview:midTextField];
    [textView topLineX:0 width:SCREEN_WIDTH color:nil];
    [textView bottomLineX:0 width:SCREEN_WIDTH color:nil];
    [footer addSubview:textView];
    
    
    UIButton *rightButton =  [self buildButtonWithFrame:CGRectMake(0, 8, 100, 24) title:@"获取验证码" andSel:@selector(getTheVerificationCode:)];
    
    
    
    
    [rightButton setBackgroundColor:kLineColor];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.cornerRadius = 4;
    
    midTextField.rightView = rightButton;
    midTextField.rightViewMode = UITextFieldViewModeAlways;
    [self  startTime:rightButton];
    
    
    
    UILabel *tiplabel = [self labelWithFontSize:12 FontColor:[UIColor redColor] frame:CGRectMake(20, textView.bottom + 10, SCREEN_WIDTH - 40, 12) Text:@"hello"];

    
    [footer addSubview:tiplabel];
    
    //提交按钮
    
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(20, tiplabel.bottom + 20 , SCREEN_WIDTH - 40, 44);
    [bt setTitle:@"验证码提交" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setBackgroundColor:HB_COLOR_A];
    bt.titleLabel.font = [UIFont systemFontOfSize:18];
    bt.layer.cornerRadius = 5;
    bt.layer.masksToBounds = YES;
    [bt addTarget:self action:@selector(submitCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.listView.tableFooterView addSubview:bt];
    
 }

#pragma mark - Action 

- (void)submitCode:(id)sender {
    
}

- (void)getTheVerificationCode:(id)sender {
    
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
                [startActionButton setBackgroundColor:HB_COLOR_A];
                startActionButton.userInteractionEnabled = YES;
            });
        }else{
            
            NSString *strTime = [NSString stringWithFormat:@"%.d", timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [startActionButton setTitle:[NSString stringWithFormat:@"%@S",strTime] forState:UIControlStateNormal];
                [startActionButton setBackgroundColor:kLineColor];
                [UIView commitAnimations];
                startActionButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


- (UITextField *)textFieldFrame:(CGRect )frame placeHolder:(NSString *)placeHolder {
    
    UITextField * textField = [[UITextField alloc]initWithFrame:frame];
    [textField setBorderStyle:UITextBorderStyleNone];
    textField.placeholder = placeHolder;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.returnKeyType = UIReturnKeyDone;
    textField.font = [UIFont systemFontOfSize:14];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.backgroundColor = [UIColor clearColor];
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.layer.cornerRadius = 3;
    textField.layer.masksToBounds = YES;
    
    

    
    
    return textField;
}

- (UIButton *)buildButtonWithFrame:(CGRect)frame title:(NSString *)title andSel:(SEL)selecter{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:16];
    [bt setTitleColor:HB_COLOR_C forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bt.backgroundColor = [UIColor whiteColor];
    [bt addTarget:self action:selecter forControlEvents:UIControlEventTouchUpInside];
    return bt;
}


- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = text;
    lbTitle.numberOfLines = 0;

    return lbTitle;
}


@end

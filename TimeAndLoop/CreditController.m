//
//  CreditController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/24.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "CreditController.h"
#import "CompleteDataViewController.h"
#define kSelectHeight 45
#define kInterval 35
@interface CreditController ()<UITextFieldDelegate>

@end

@implementation CreditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡贷";
    self.view.backgroundColor = HB_COLOR_G;
    [self creatView];
    
    NSLog(@"111%@",NSStringFromCGRect(self.view.frame));
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"222%@",NSStringFromCGRect(self.view.frame));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"333%@",NSStringFromCGRect(self.view.frame));
}

- (void)creatView {
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:scrollView];
    
    UIView *topBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 94, SCREEN_WIDTH, kSelectHeight)];
    topBgView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:topBgView];
    [topBgView topLineX:0 width:SCREEN_WIDTH color:nil];
    [topBgView bottomLineX:0 width:SCREEN_WIDTH color:nil];
    UILabel *lab = [self labelWithFontSize:14 FontColor:HB_COLOR_C frame:CGRectMake(10, 15, 55, 30) Text:@"借贷金额"];
    [topBgView addSubview:lab];

    UILabel *lab_des =  [self labelWithFontSize:12 FontColor:HB_COLOR_D frame:CGRectMake(10, topBgView.bottom + 5, 55, 30) Text:@"至少1000,以100递增"];
    [scrollView addSubview:lab_des];
    
    UITextField *topTextField = [[UITextField alloc]initWithFrame:CGRectMake(lab.right + 5, 15, SCREEN_WIDTH - lab.right - 5, 30)];
    [topBgView addSubview:topTextField];
    topTextField.   placeholder = @"100~1000";
    topTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    topTextField.font = [UIFont systemFontOfSize:14];
    topTextField.centerY = lab.centerY;
    topTextField.delegate = self;

    
    UIView *midView = [[UIView alloc ]initWithFrame:CGRectMake(0,  topBgView.bottom + kInterval , SCREEN_WIDTH, kSelectHeight)];
    midView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:midView];
    [midView topLineX:0 width:SCREEN_WIDTH color:[UIColor redColor]];
    [midView bottomLineX:0 width:SCREEN_WIDTH color:nil];
    UILabel *lab_mid = [self labelWithFontSize:14 FontColor:HB_COLOR_C frame:CGRectMake(10, 15, 55, 30) Text:@"借款期限"];
    [midView addSubview:lab_mid];
    
    UITextField *midTextField = [[UITextField alloc]initWithFrame:CGRectMake(lab_mid.right + 5, 15, SCREEN_WIDTH - lab_mid.right - 5, 30)];
    midTextField.tag = 102;
    [midView addSubview:midTextField];
    midTextField.placeholder = @"请输入借款期限";
    midTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    midTextField.font = [UIFont systemFontOfSize:14];
    midTextField.centerY = lab_mid.centerY;
    midTextField.delegate = self;
    [midView addSubview:midTextField];
    
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, midView.bottom + kInterval, SCREEN_WIDTH, kSelectHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView topLineX:0 width:SCREEN_WIDTH color:[UIColor redColor]];
    [bottomView bottomLineX:0 width:SCREEN_WIDTH color:nil];
    [scrollView addSubview:bottomView];
    
      UILabel *lab_bottom = [self labelWithFontSize:14 FontColor:HB_COLOR_C frame:CGRectMake(10, 15, 55, 30) Text:@"预计每月应还 ¥55.00~¥65.00"];
    [bottomView addSubview:lab_bottom];
    UILabel *lab_bottom_des =  [self labelWithFontSize:12 FontColor:HB_COLOR_D frame:CGRectMake(10, bottomView.bottom + 5, 55, 30) Text:@"实际每月还款金额根据您最终的评估结果确定"];
    [scrollView addSubview:lab_bottom_des];
    
    
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(15, bottomView.bottom + 35, SCREEN_WIDTH - 30, 44);
    [bt setTitle:@"立即申请" forState:UIControlStateNormal];
    [bt setTitleColor:HB_COLOR_C forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(applicationRightNow:) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:bt];
}


- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = text;
    [lbTitle sizeToFit];
    return lbTitle;
}


//TextFieldDelegate 
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 102) {
        NSLog(@"pick up segment");
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}


- (void)applicationRightNow:(id)sender {
    NSLog(@"开始申请");
    CompleteDataViewController *ctr = [[CompleteDataViewController alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

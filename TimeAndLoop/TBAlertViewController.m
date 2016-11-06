//
//  TBAlertViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/3.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "TBAlertViewController.h"
#import "TTAlertView.h"
@interface TBAlertViewController ()

@end

@implementation TBAlertViewController


- (void)dealloc {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HB_COLOR_G;
    UIButton *bt = [self buildButton:CGRectMake(44, 144, SCREEN_WIDTH - 88, 44)];
    bt.tag = 1;
    [bt setTitle:@"弹框1" forState:UIControlStateNormal];
    [self.view addSubview:bt];
    
    UIButton *bt_2 = [self buildButton:CGRectMake(44, bt.bottom+ 20, SCREEN_WIDTH - 88, 44)];
    bt_2.tag = 2;
    [bt_2 setTitle:@"弹框2" forState:UIControlStateNormal];
    [self.view addSubview:bt_2];
    
    UIButton *bt_3 = [self buildButton:CGRectMake(44, bt_2.bottom + 20, SCREEN_WIDTH - 88, 44)];
    bt_3.tag = 3;
    [bt_3 setTitle:@"弹框3" forState:UIControlStateNormal];
    [self.view addSubview:bt_3];
    
    // Do any additional setup after loading the view.
}

- (UIButton *)buildButton:(CGRect)frame {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitleColor:HB_COLOR_C forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(alertView_1:) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = [UIColor whiteColor];
    return bt;
}

- (void)alertView_1:(id)sender {
    UIButton *bt = (UIButton *)sender;
    if (bt.tag == 1) {
        [TTAlertView showAlertViewWithTitle:@"已向185****3212的手机号发送短信"  commitBlock:^(NSString *codeString) {
            NSLog(@"手动输入的text 是 %@",codeString);
        } cannel:^{
            NSLog(@"点击了取消");
        }];
    }
    
    if (bt.tag == 2) {
        [TTAlertView showAlertViewWithTitle:@"已向185****3212的手机号发送短信"
                                commitBlock:^(NSString *codeString) {
                                    NSLog(@"手动输入的text 是 %@",codeString);
                                } rightBlock:^{
                                    NSLog(@"还是获取验证码---倒计时开始");
                                } cannel:^{
                                    NSLog(@"点击了取消");
                                }];
    }
    
    if (bt.tag == 3) {
        [TTAlertView showAlertViewWithTitle:@"请使用手机发送CXXD至10010获取验证码"  commitBlock:^(NSString *codeString) {
            NSLog(@"手动输入的text 是 %@",codeString);
        } cannel:^{
            NSLog(@"点击了取消");
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
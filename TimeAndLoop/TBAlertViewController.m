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
    
    
    
    UIButton *bt_4 = [self buildButton:CGRectMake(44, bt_3.bottom + 20, SCREEN_WIDTH - 88, 44)];
    bt_4.tag = 4;
    [bt_4 setTitle:@"弹框4" forState:UIControlStateNormal];
    [self.view addSubview:bt_4];
    
    UIButton *bt_5 = [self buildButton:CGRectMake(44, bt_4.bottom + 20, SCREEN_WIDTH - 88, 44)];
    bt_5.tag = 5;
    [bt_5 setTitle:@"弹框5" forState:UIControlStateNormal];
    [self.view addSubview:bt_5];
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
        NSString *temp_phoneAccount = @"15810841102";
        NSString *phoneNum_After = [temp_phoneAccount stringByReplacingOccurrencesOfString:[temp_phoneAccount substringWithRange:NSMakeRange(3,4)] withString:@"****"];
        NSString *alertStr = [NSString stringWithFormat:@"已向%@的手机号发送短信",phoneNum_After];
        [TTAlertView showAlertViewWithTitle:alertStr
                                commitBlock:^(NSString *codeString) {
                                    NSLog(@"手动输入的text 是 %@",codeString);
                                } rightBlock:^{
                                    NSLog(@"还是获取验证码---倒计时开始");
                                } cannel:^{
                                    NSLog(@"点击了取消");
                                }];
    }
    
    if (bt.tag == 2) {
        
            [TTAlertView showAlertViewWithTitle:@"请输入查询密码" bottomTitle:@"若遗忘查询密码,可以致电运营商服务电话设置" placeholder:@"请输入查询密码" commitBlock:^(NSString *codeString) {
                
            } cannel:^{
                
            }];
        
    }
    
    if (bt.tag == 3) {
        [TTAlertView showNOSubAlertViewTitle:@"请编辑短信发送CXXD至10001获取验证码请编辑短信发送CXXD至10001获取验证码" placeholder:@"请输入短信验证码" commitBlock:^(NSString *codeString) {
            NSLog(@"code string %@",codeString );
//            [TTAlertView remove];
            
        } cannel:^{
            
        }];
    }
    
    if (bt.tag == 4) {
        [TTAlertView showTextFieldWithPlaceHolder:@"请输入动态口令密码" commitBlock:^(NSString *codeString) {
            
        } cannel:^{
            
        }];
    }
    
    if (bt.tag == 5) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.backgroundColor = [UIColor redColor];
        [TTAlertView showTextFieldWithVerificationPlaceHolder:@"请输入右侧图片验证码" rightButton:bt
                                                   rightClick:^(UIButton *button) {
                                                       
                                                   } commitBlock:^(NSString *codeString) {
                                                       
                                                   } cannel:^{
                                                       
                                                   }];
    }
    
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

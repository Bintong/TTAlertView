//
//  OnRoadViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/31.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "OnRoadViewController.h"

@interface OnRoadViewController ()

@end

@implementation OnRoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"温馨提示";
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,200)];
    self.view.backgroundColor = HB_COLOR_G;
    headerView.backgroundColor = [UIColor redColor];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, headerView.bottom + 15, SCREEN_WIDTH, 30)];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:14];
    lbTitle.textColor = HB_COLOR_B;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = @"很抱歉，您目前尚有未结清贷款， \n待结清后可再次申请！";
    
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(15, lbTitle.bottom+ 30, SCREEN_WIDTH - 30, 44);
    [bt setTitle:@"我知道了" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(clickIknow:) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = HB_COLOR_A;
    [self.view addSubview:headerView];
    [self.view addSubview:lbTitle];
    [self.view addSubview:bt];

    
    // Do any additional setup after loading the view.
}

- (void)clickIknow:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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

//
//  CompleteDataViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/24.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "CompleteDataViewController.h"
#import "HBStepView.h"
#import "PersonInfoController.h"
#import "OnRoadViewController.h"

#define kStepItemViewHeight 104

@interface CompleteDataViewController ()

@end

@implementation CompleteDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HB_COLOR_G;
    [self createView];
    // Do any additional setup after loading the view.
}

- (void)createView{
    int step = 6;
    NSArray *stepTitles = @[@"1.身份认证",@"2.资料填写",@"3.淘宝认证",@"4.手机认证",@"5.公积金认证",@"6.征信认证"];
//    NSArray *imageLinks = @[];
    HBStepView *stepView = nil;
    for (int i = 0; i< step; i ++) {
        if (i< 3) {
            stepView = [[HBStepView alloc]initWithTitle:stepTitles[i] andImageLink:nil andFrame: CGRectMake(i*(SCREEN_WIDTH/3), 64+ 144,SCREEN_WIDTH/3 , kStepItemViewHeight)];
        }else {
            stepView = [[HBStepView alloc]initWithTitle:stepTitles[i] andImageLink:nil andFrame: CGRectMake((i - 3)*(SCREEN_WIDTH/3), 64 + 144 + kStepItemViewHeight,SCREEN_WIDTH/3 ,kStepItemViewHeight)];
        }
        
        stepView.callBackBlock = ^{
            NSLog(@"i---- %d",i);
            [self selectedStepItem:i];
        };
        [self.view addSubview:stepView];
    }
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(15, 64 + 144 + kStepItemViewHeight*2 + 35, SCREEN_WIDTH - 30, 44);
    [bt setTitle:@"提交申请" forState:UIControlStateNormal];
    [bt setTitleColor:HB_COLOR_C forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(submitApplicationRightNow:) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bt];
}

- (void)selectedStepItem:(int)step {
    UIViewController *ctr = nil;
    
    switch (step) {
        case  0:
            ctr = [[OnRoadViewController alloc] init];
            break;
        case  1:
            ctr = [[PersonInfoController alloc] init];
            break;
            
        case  2:
            
            break;
        case  3:
            
            break;
        case  4:
            
            break;
        case  5:
            
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:ctr animated:YES];

}

- (void)submitApplicationRightNow:(id)sender {
    NSLog(@"提交申请");
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

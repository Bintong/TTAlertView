//
//  AlertTableController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/25.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "AlertTableController.h"
#import "TTAlertTable.h"
@interface AlertTableController ()

@end

@implementation AlertTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)linkPageShow:(id)sender {
    NSLog(@"联动");
    [TTAlertTable showTableAlertWithCallBack:^(NSDictionary *dic) {
        NSLog(@"--------dic ------->> %@",dic);
    }];
    
}

- (IBAction)noLinkPageShow:(id)sender {
    NSLog(@"非联动");
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

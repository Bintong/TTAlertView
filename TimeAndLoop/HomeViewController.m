//
//  HomeViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/12/15.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNetManager.h"
#import "SelecterToolsScrolView.h"
#import "SelecterContentScrollView.h"
#import "IFanrViewController.h"
#import "RenrenViewController.h"
#import "DZNSegmentedControl.h"
@interface HomeViewController ()

@property(nonatomic,retain)NSArray *titleArr;
@property(nonatomic,retain)NSMutableArray *vcArr;
@property(nonatomic,retain)SelecterToolsScrolView *selectTools;
@property(nonatomic,retain)SelecterContentScrollView *contentScrView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"萌下";
    _titleArr = @[@"爱范儿",@"人人产品经理"];
    
    
//    HomeNetManager *net =   [[HomeNetManager alloc] init];
//    [net requestHomeData:^(id result) {
//        NSLog(@"---------reslut----%@",result);
//    }];
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

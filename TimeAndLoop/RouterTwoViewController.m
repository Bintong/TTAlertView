//
//  RouterTwoViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/21.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "RouterTwoViewController.h"
#import "DCURLRouter.h"
#import "UIViewController+DCURLRouter.h"

@interface RouterTwoViewController ()

@end

@implementation RouterTwoViewController

- (id)init {
    self = [super init];
    if (self) {
        NSLog(@"title_jf %@ ",self.params[@"title_jf"]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.bounds = CGRectMake(0, 0, 200, 40);
    NSLog(@"title_jf %@ ",self.params[@"title_jf"]);
    self.name = self.params[@"name"];
    self.age = self.params[@"age"];
    label.text = self.params[@"title_jf"];//self.name !=nil ? [NSString stringWithFormat:@"id-%@,age-%@",self.name,self.age] : @"";
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:label];
    // Do any additional setup after loading the view.
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

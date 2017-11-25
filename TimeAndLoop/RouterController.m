//
//  RouterController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/20.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "RouterController.h"
#import "DCURLRouter.h"
@interface RouterController ()

@end

@implementation RouterController


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    UIButton *btn = [UIButton new];
    btn.bounds = CGRectMake(0, 0, 200, 50);
    btn.center = self.view.center;
    [btn setTitle:@"Common Push" forState:UIControlStateNormal];
    btn.tag = 0;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:btn];
    self.view.backgroundColor = [UIColor greenColor];
    
    // Do any additional setup after loading the view.
}

-(void)btnClick:(UIButton *) sender{
    if (sender.tag == 0) {
     
        [DCURLRouter pushURLString:@"dariel://item2?name=nsdn&age= 18" animated:YES];

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

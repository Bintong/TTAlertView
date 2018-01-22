//
//  RouterController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/20.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "RouterController.h"
#import "DCURLRouter.h"
#import "JFRouter.h"
#import "UIViewController+Router.h"

@interface RouterController ()

@end

@implementation RouterController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self  insertViewControllerJFBlock];
    
    UIButton *btn = [UIButton new];
    btn.bounds = CGRectMake(0, 0, 200, 50);
    btn.center = self.view.center;
    [btn setTitle:@"Common Push" forState:UIControlStateNormal];
    btn.tag = 0;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:btn];
    self.view.backgroundColor = [UIColor greenColor];
    
    
    UIButton *btn1 = [UIButton new];
    btn1.bounds = CGRectMake(0, 0, 200, 50);
    btn1.left = btn.left;
    btn1.top = btn.bottom + 5;
    [btn1 setTitle:@"JFPush" forState:UIControlStateNormal];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [UIButton new];
    btn2.bounds = CGRectMake(0, 0, 200, 50);
    btn2.left = btn1.left;
    btn2.top = btn1.bottom + 5;
    [btn2 setTitle:@"block" forState:UIControlStateNormal];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:btn2];
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)btnClick:(UIButton *) sender{
    if (sender.tag == 0) {
     
        [DCURLRouter pushURLString:@"dariel://item2?name=nsdn&age= 18" animated:YES];

    }else if(sender.tag == 1){
 
        UIViewController *v = [[JFRouter shared] matchController:@"hello"];
        [self.navigationController pushViewController:v animated:YES];
    }else if(sender.tag == 2){
        JFRouterBlock block = [[JFRouter shared] matchBlock:@"hello"];
        UIViewController *v = block(@{@"title_jf":@"blocktitle",@"subTitle":@"hello world"},nil);
        [self.navigationController pushViewController:v animated:YES];
    }
    
}

- (void)insertViewControllerJFController {
    Class c = NSClassFromString(@"RouterTwoViewController");

    [[JFRouter shared] map:@"hello" toControllerClass:c];
    
}

- (void)insertViewControllerJFBlock {
    [[JFRouter shared] map:@"hello" toBlock:^id(NSDictionary *params,id aCallback) {
        id viewController = nil;
        Class c = NSClassFromString(@"RouterTwoViewController");
        viewController = [[c alloc] init];
        [(UIViewController *)viewController setParams:params];
        return viewController;
    }];
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

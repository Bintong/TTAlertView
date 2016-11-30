//
//  ViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/21.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "ViewController.h"
#import "KVOViewController.h"
#import "TBAlertViewController.h"
#import "RunLoopDemoViewController.h"
#import "AlertTableController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *ar = @[@"kvo",@"-----",@"自定义alertView",@"runloop_autorelease",@"弹出tableview"];
    _arr = ar;
    
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    [table reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CMainCell = @"CMainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: CMainCell];
    }
    
    cell.textLabel.text = _arr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *ctr ;
    if (indexPath.row == 0) {
        ctr = [[KVOViewController alloc] init];
    }
    if (indexPath.row == 1) {
        ctr = [[ViewController alloc] init];
        
    }
    if (indexPath.row == 2) {
        ctr = [[TBAlertViewController alloc] init];
    }
    if (indexPath.row == 3) {
        ctr = [[RunLoopDemoViewController alloc] init];
    }
    if (indexPath.row == 4) {
        ctr = [[AlertTableController alloc] init];
    }
    [self.navigationController pushViewController:ctr animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

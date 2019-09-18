//
//  USMainViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/9/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "USMainViewController.h"
#import "KChartViewController.h"
@interface USMainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *arr;

@end

@implementation USMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *ar = @[@"k线" ,@"Texure" ];
    _arr = ar;
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds];
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
        ctr = [[KChartViewController alloc] init];
    }
    [self.navigationController pushViewController:ctr animated:YES];
    
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

//
//  ViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/21.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "ViewController.h"
#import "KVOViewController.h"
#import "CreditController.h"
#import "TBAlertViewController.h"
#import "TextFieldViewController.h"
#import "ResultViewController.h"
#import "InfoPutController.h"
#import "SMSViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *ar = @[@"kvo",@"厚本金融",@"自定义alertView",@"textfield",@"net get",@"固话",@"result",@"信息第二部填写",@"通知",@"验证码的页面ui"];
    
    
    _arr = ar;
    
    UITableView *table = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    [table reloadData];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"",@"2",@"",@"3",@"", nil];
    NSString *key1 = @"2";
    NSString *key2 = @"key2";
    NSDictionary *dict = @{@"1":key1,@"2":@"",@"3":key2,@"4": @(false)};
    NSLog(@"----------dic is %@",dict);
    
    NSString *str = [dict objectForKey:@"3"];
    NSLog(@"djkfdj=======str is %ld--------------%@",str.integerValue,str);
    
    
    NSURL *url = [NSURL URLWithString:nil];
    
    NSLog(@"==== is %@",url.absoluteURL);
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
        ctr = [[CreditController alloc] init];
        
    }
    if (indexPath.row == 2) {
        ctr = [[TBAlertViewController alloc] init];
    }
    
    if (indexPath.row == 3) {
        ctr = [[TextFieldViewController alloc] init];
    }
    
    if (indexPath.row == 6) {
        ctr = [[ResultViewController alloc] init];
    }
    if (indexPath.row == 7) {
        ctr = [[InfoPutController alloc] init];
    }
    if (indexPath.row == 9){
        ctr = [[ SMSViewController alloc]init];
    }
    [self.navigationController pushViewController:ctr animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

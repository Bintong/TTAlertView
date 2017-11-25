//
//  JFSurpriseViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFSurpriseViewController.h"
#import "JFSupriseCell.h"
@interface JFSurpriseViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *listData;
@end

@implementation JFSurpriseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JF_COLOR_BG;
    self.title = @"惊喜计划";
    self.listData = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];

    [self buildListView];

}

- (void)buildListView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    self.listView.showsVerticalScrollIndicator = NO;
    
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.rowHeight = 50;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    lineview.backgroundColor = JF_COLOR_BG;
    self.listView.tableHeaderView = lineview;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFSupriseCell *cell = [JFSupriseCell cellWithTableView:tableView];
    return cell;
}


@end

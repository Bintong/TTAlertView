//
//  TableListViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2018/2/7.
//  Copyright © 2018年 TongBin. All rights reserved.
//

#import "TableListViewController.h"

@interface TableListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *listView;

@end

@implementation TableListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    NSArray *actions = @[shareItem,addItem];
    self.navigationItem.rightBarButtonItems = actions;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self buildListView];
    
    // Do any additional setup after loading the view.
}

- (void)buildListView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStyleGrouped];
//    self.listView.top =  64;
//    self.listView.height = SCREEN_HEIGHT - 64 ;
//    self.listView.backgroundColor = [self.resourceService colorForKey:COLOR_TABLEVIEW_BACKGROUND_COLOR];
    
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.pagingEnabled = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
    if (@available(iOS 11.0, *)) {
        self.listView.estimatedRowHeight = 0;
        self.listView.estimatedSectionHeaderHeight = 0;
        self.listView.estimatedSectionFooterHeight = 0;
        self.listView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
//    self.listView.mj_header = [JFRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNet)];
//    [self.listView.mj_header beginRefreshing];
    [self.view addSubview:self.listView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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

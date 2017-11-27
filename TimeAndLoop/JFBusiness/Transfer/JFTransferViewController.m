//
//  JFTransferViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/27.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFTransferViewController.h"
#import "JFTransferCell.h"
@interface JFTransferViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *listData;
@end

@implementation JFTransferViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转让标";
    self.view.backgroundColor = JF_COLOR_BG;
    [self buildListView];
}
- (void)buildListView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStyleGrouped];
    self.listView.showsVerticalScrollIndicator = NO;
    
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.rowHeight = 50;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
}

#pragma mark - DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFTransferCell *cell = [JFTransferCell cellWithTableView:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55 ;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeaderView;
    if (section == 0) {
        sectionHeaderView = [self creatTopTitleView:@"正在转让"];
    }else {
        sectionHeaderView = [self creatTopTitleView:@"已完成标"];
    }

    sectionHeaderView.backgroundColor = JF_COLOR_BG;
    return sectionHeaderView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    sectionFooterView.backgroundColor = [UIColor redColor];
    
    sectionFooterView.backgroundColor = JF_COLOR_BG;
    return sectionFooterView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (UIView *)creatTopTitleView:(NSString *)title {
    UIView *faView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    faView.backgroundColor = JF_COLOR_BG;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0,10, SCREEN_WIDTH , 45)];
    [faView addSubview:leftView];
    leftView.backgroundColor = [UIColor whiteColor];
    [leftView bottomLineX:0 width:SCREEN_WIDTH color:kLineColor];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH/5, leftView.height)];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:14];
    lbTitle.textColor = JF_COLOR_B;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = title;
    
    lbTitle.font = [UIFont boldSystemFontOfSize:14];
    lbTitle.textAlignment = NSTextAlignmentLeft;
    [leftView addSubview:lbTitle];
    
 
    return faView;
}



@end

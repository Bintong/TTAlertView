//
//  JFRegularViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/24.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFRegularViewController.h"
#import "JFRegularCell.h"

@interface JFRegularViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *listData;
@end

@implementation JFRegularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HB_COLOR_BG;
    self.title = @"网贷";
    
    
    [self buildListView];
    [self refreshData];
    
    self.listData = @[@"1",@"2"];
    // Do any additional setup after loading the view.
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
    
    //header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,180)];
    headerView.backgroundColor = [UIColor clearColor];
    self.listView.tableHeaderView = headerView;
    
    
    
    UIView *topHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    topHeaderView.backgroundColor = [UIColor whiteColor];
    [topHeaderView bottomLineX:0 width:1 color:kLineColor];
    
    UILabel *netLoanLab = [self labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(20, 0, 78, 60) Text:@"网贷总资产:"];
    [topHeaderView addSubview:netLoanLab];
    UILabel *numLab = [self labelWithFontSize:13 FontColor:HB_COLOR_B frame:CGRectMake(netLoanLab.right , 0, 20, 60) Text:@"1234567元"];
    [numLab sizeToFit];
    numLab.left = netLoanLab.right + 5;
    numLab.centerY = netLoanLab.centerY;
    [topHeaderView addSubview:numLab];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(numLab.right + 5, 0, 20, 20)];
    imageView.backgroundColor = [UIColor redColor];
    imageView.centerY = topHeaderView.centerY;
    [topHeaderView addSubview:imageView];
    
    UIImageView *imageRigView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 0, 20, 20)];
    imageRigView.backgroundColor = [UIColor redColor];
    imageRigView.centerY = topHeaderView.centerY;
    [topHeaderView addSubview:imageRigView];
    
    UILabel *syLab = [self labelWithFontSize:12 FontColor:HB_COLOR_C frame:CGRectMake(0, 0, SCREEN_WIDTH/3, 12) Text:@"昨天 +6.40"];
    syLab.centerY = topHeaderView.centerY;
    syLab.right = imageRigView.left - 5;
    syLab.textAlignment = NSTextAlignmentRight;
    [topHeaderView addSubview:syLab];
    [headerView addSubview:topHeaderView];
    //scrollview
 
    UIView *banner = [[UIView alloc] initWithFrame:CGRectMake(topHeaderView.bottom + 10, 0, SCREEN_WIDTH, 100)];
    [headerView addSubview:banner];
    //
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 151;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFRegularCell *cell = [JFRegularCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (void)refreshData {
    
}
- (UIButton *)createButtonTitle:(NSString *)title Frame:(CGRect)frame SEL:(SEL)selector {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    if(title){ [bt setTitle:title forState:UIControlStateNormal];}
    [bt setTitleColor:JF_COLOR_B forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor clearColor]];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    if (selector) {[bt addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];}
    return bt;
}

- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = text;
    return lbTitle;
}

@end

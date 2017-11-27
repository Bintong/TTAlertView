//
//  JFNetLoanViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFNetLoanViewController.h"
#import "JFNetLoanCell.h"
#import "JFNetOtherCell.h"
#import "JFNetLoanViewMananger.h"
#import "JFTransferViewController.h"


@interface JFNetLoanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *listData;

@end

@implementation JFNetLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HB_COLOR_BG;
    self.title = @"定期";
    
    [self buildListView];
    [self refreshData];
    
    self.listData = [NSMutableArray arrayWithArray:@[@"1",@"2",@"1",@"2",@"1",@"2",@"1",@"2"]];
    
    [self insertCustomView];
}

- (void)refreshData {
    
}
- (void)insertCustomView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 590+370/2 + 30)];
    footerView.backgroundColor = JF_COLOR_BG;
    JFNetLoanViewMananger *vm = [JFNetLoanViewMananger sharedManager];
    UIView *zqView = [vm buildZqView];
    zqView.top = 10;
    [footerView addSubview:zqView];
    
    UIView *jxView = [vm buildJxItemView];
    jxView.top = zqView.bottom + 10;
    [footerView addSubview:jxView];
    
    UIView *zrView = [vm buildZrView];
    zrView.top = jxView.bottom + 10;
    [footerView addSubview:zrView];
    self.listView.tableFooterView = footerView;
    
    vm.block =  ^(InvestType type){
        //NSLog(@"type is ------> %lld",type);
        JFTransferViewController *ctr = [[JFTransferViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    };
    
    
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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,225)];
    headerView.backgroundColor = [UIColor clearColor];
    self.listView.tableHeaderView = headerView;
    
    
    //top
    UIView *topHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    topHeaderView.backgroundColor = [UIColor whiteColor];
    [topHeaderView bottomLineX:0 width:1 color:kLineColor];
    
    UILabel *netLoanLab = [self labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(20, 0, 78, 60) Text:@"网贷总资产:"];
    [topHeaderView addSubview:netLoanLab];
    UILabel *numLab = [self labelWithFontSize:12 FontColor:HB_COLOR_B frame:CGRectMake(netLoanLab.right , 0, 20, 60) Text:@"1234567元"];
    [numLab sizeToFit];
    numLab.left = netLoanLab.right + 5;
    numLab.centerY = netLoanLab.centerY;
    [topHeaderView addSubview:numLab];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(numLab.right + 5, 0, 16, 10)];
    imageView.image = [UIImage imageNamed:@"CombinedShape.png"];
    imageView.centerY = topHeaderView.centerY;
    [topHeaderView addSubview:imageView];
    
    UIImageView *imageRigView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 0, 11, 6)];
    imageRigView.image = [UIImage imageNamed:@"Page_1.png"];
    imageRigView.centerY = topHeaderView.centerY;
    [topHeaderView addSubview:imageRigView];
    
    UILabel *syLab = [self labelWithFontSize:12 FontColor:HB_COLOR_C frame:CGRectMake(0, 0, SCREEN_WIDTH/3, 12) Text:@"昨天 +6.40"];
    syLab.centerY = topHeaderView.centerY;
    syLab.right = imageRigView.left - 5;
    syLab.textAlignment = NSTextAlignmentRight;
    [topHeaderView addSubview:syLab];
    [headerView addSubview:topHeaderView];
    //scrollview
    
    UIView *banner = [[UIView alloc] initWithFrame:CGRectMake(0, topHeaderView.bottom + 10, SCREEN_WIDTH, 100)];
    banner.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:banner];
    //titleView
    
    UIView *titleView = [self creatTopTitleView:@"季度账户"];
    titleView.top = banner.bottom + 10;
    [titleView bottomLineX:0 width:SCREEN_WIDTH color:kLineColor];
    [headerView addSubview:titleView];
    
}

- (UIView *)creatTopTitleView:(NSString *)title {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 45)];
    leftView.backgroundColor = [UIColor whiteColor];
    
    [leftView bottomLineX:0 width:SCREEN_WIDTH color:JF_COLOR_D];
    UILabel *titleLable = [self labelWithFontSize:14 FontColor:JF_COLOR_B frame:CGRectMake(20, 0, SCREEN_WIDTH/2, leftView.height) Text:title];
    titleLable.font = [UIFont boldSystemFontOfSize:14];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [leftView addSubview:titleLable];
    
    return leftView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFNetLoanCell *cell = [JFNetLoanCell cellWithTableView:tableView];
    return cell;
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

//
//  JFCurrentViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/29.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFCurrentViewController.h"
#import "JFCurrentCell.h"
@interface JFCurrentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *listView;
@property (nonatomic,strong) NSMutableArray *listData;
@property (nonatomic,strong) UILabel *numLab;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *topHeaderView;
@property (nonatomic, strong) UIView *banner;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *detailView;

@end

@implementation JFCurrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活期";
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
    //header
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,225)];
    self.headerView.backgroundColor = [UIColor clearColor];
    self.listView.tableHeaderView = self.headerView;
    //top
    self.topHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    self.topHeaderView.backgroundColor = [UIColor whiteColor];
    [self.topHeaderView bottomLineX:0 width:1 color:kLineColor];
    
    UILabel *netLoanLab = [self labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(20, 0, 78, 60) Text:@"活期中资产: "];
    [self.topHeaderView addSubview:netLoanLab];
    self.numLab = [self labelWithFontSize:12 FontColor:HB_COLOR_B frame:CGRectMake(netLoanLab.right , 0, 20, 60) Text:@"12343456567元"];
    [self.numLab sizeToFit];
    self.numLab.left = netLoanLab.right + 5;
    self.numLab.centerY = netLoanLab.centerY;
    [self.topHeaderView addSubview:self.numLab];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(self.numLab.right + 5, 0, 50, 60);
    [bt setImage:[UIImage imageNamed:@"CombinedShape.png"] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@"CombinedHidden.png"] forState:UIControlStateSelected];

    bt.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0,  10);
    [bt addTarget:self action:@selector(touchEye:) forControlEvents:UIControlEventTouchUpInside];
    [self.topHeaderView addSubview:bt];
    
    UIImageView *imageRigView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 40, 0, 11, 6)];
    imageRigView.image = [UIImage imageNamed:@"Page_1.png"];
    imageRigView.centerY = self.topHeaderView.centerY;
    [self.topHeaderView addSubview:imageRigView];
    
    UILabel *syLab = [self labelWithFontSize:12 FontColor:HB_COLOR_C frame:CGRectMake(0, 0, SCREEN_WIDTH/3, 12) Text:@"昨天 +6.40"];
    syLab.centerY = self.topHeaderView.centerY;
    syLab.right = imageRigView.left - 5;
    syLab.textAlignment = NSTextAlignmentRight;
    [self.topHeaderView addSubview:syLab];
    [self.topHeaderView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHeaderView:)]];
    
    [self.headerView addSubview:self.topHeaderView];
    //scrollview
    
    self.banner = [[UIView alloc] initWithFrame:CGRectMake(0, self.topHeaderView.bottom + 10, SCREEN_WIDTH, 100)];
    self.banner.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.banner];
    
    self.titleView = [self creatTopTitleView:@"日账户"];
    self.titleView.top = self.banner.bottom + 10;
    [self.titleView bottomLineX:0 width:SCREEN_WIDTH color:kLineColor];
    [self.headerView addSubview:self.titleView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 190;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFCurrentCell *cell = [JFCurrentCell cellWithTableView:tableView];
    return cell;
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

- (UIView *)creatTopTitleView:(NSString *)title {
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 45)];
    leftView.backgroundColor = [UIColor whiteColor];
    
    [leftView bottomLineX:0 width:SCREEN_WIDTH color:JF_COLOR_D];
    UILabel *titleLable = [self labelWithFontSize:14 FontColor:JF_COLOR_B frame:CGRectMake(20, 0, SCREEN_WIDTH/2, leftView.height) Text:title];
    titleLable.font = [UIFont boldSystemFontOfSize:14];
    titleLable.textAlignment = NSTextAlignmentLeft;
    
    UILabel *sub = [self labelWithFontSize:14 FontColor:JF_COLOR_B frame:CGRectMake(SCREEN_WIDTH - 40 - SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 14) Text:@"已有34566人次投资"];
    
    sub.textAlignment = NSTextAlignmentRight;
    sub.centerY = titleLable.centerY;
    
    [leftView addSubview:sub];
    [leftView addSubview:titleLable];
    
    return leftView;
}

- (void)touchEye:(id)sender {
    UIButton *eye = (UIButton *)sender;
    eye.selected = !eye.selected;
    if (eye.selected) {
        self.numLab .text = @"***********";
    }else {
        self.numLab .text = @"12343456567元";
    }
}

- (void)tapHeaderView:(id)sender {
//    NSLog(@"nap");
    if (self.headerView.height == 225) {
        self.listView.tableHeaderView.height += 60;
        self.listView.tableHeaderView = self.headerView;
        self.topHeaderView.top = 0;
        self.detailView = [self makeDetailView];
        self.detailView.top = self.topHeaderView.bottom;
        [_headerView addSubview:self.detailView];
        self.banner.top = self.detailView.bottom + 10;
        self.titleView.top = self.banner.bottom + 10;
        
    }else{
        self.headerView.height -= 60;
        self.listView.tableHeaderView = self.headerView;
        [self.detailView removeFromSuperview];
        self.topHeaderView.top = 0;
        self.banner.top = self.topHeaderView.bottom + 10;
        self.titleView.top = self.banner.bottom + 10;
    }
}


- (UIView *)makeDetailView {
    UIView *detail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 73)];
    detail.backgroundColor = [UIColor blueColor];
    return detail;
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

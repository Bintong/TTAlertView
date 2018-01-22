//
//  JFInvestViewController.m
//  JiuFuWallet
//
//  Created by BinTong on 2017/11/22.
//  Copyright © 2017年 jayden. All rights reserved.
//

#import "JFInvestViewController.h"
#import "JFInvestCell.h"
//#import "JFFrameDefine.h"
#import "JFInvestTitleView.h"
//#import "JFBannerView.h"
#import "JFBaoItemView.h"
#import "JFInvestViewModel.h"
#import "JFRegularViewController.h"
#import "JFNetLoanViewController.h"
#import "JFCurrentViewController.h"
#import "JFRegularCell.h"

static NSString *cellIde = @"InvestCell";

@interface JFInvestViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *listView;

@end

@implementation JFInvestViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"投资";
    
    self.view.backgroundColor = JF_COLOR_BG;
    //from net
    //
    JFInvestViewModel *investVM =  [[JFInvestViewModel alloc] init];

    __weak typeof(self)weakSelf = self;
    investVM.block = ^(InvestType type){
        JFNetLoanViewController *ctr = [[JFNetLoanViewController alloc] init];
        [weakSelf.navigationController pushViewController:ctr animated:YES];
    };
    [self buildView];

}

- (void)buildView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStyleGrouped];
    self.listView.showsVerticalScrollIndicator = NO;
    
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.rowHeight = 50;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    //headerView
    JFInvestTitleView *itemView = [[JFInvestTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    itemView.projects = @[@"玖富宝",@"玖富宝1",@"玖富宝2",@"玖富宝3",@"玖富宝4",@"玖富宝5",@"玖富宝6"];
    [itemView loadView];
    itemView.backgroundColor = [UIColor whiteColor];
    headerView.backgroundColor = JF_COLOR_BG;
    
    //bannner
    UIView *bannerView = [[UIView alloc]initWithFrame:CGRectMake(0, itemView.bottom + 10 , SCREEN_WIDTH, 100)];
    
    //jiufubao
    JFBaoItemView * jiububaoView = [[JFBaoItemView alloc] initItemView:nil andFrame:CGRectMake(0, bannerView.bottom + 5, SCREEN_WIDTH, 190)];
  
    jiububaoView.jfbCallBack = ^(){
        
    };
    [headerView addSubview:itemView];
    [headerView addSubview:bannerView];
    [headerView addSubview:jiububaoView];
    headerView.height = itemView.height + bannerView.height + jiububaoView.height + 5;
    self.listView.tableHeaderView = headerView;
}


- (void)pushToJFB:(id)sender {
    
}
#pragma mark - tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return 3;
    }else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55 ;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionHeaderView;
    if (section == 0) {
        sectionHeaderView = [self creatTopTitleView:@"网贷" andSubtitle:@"已有3654出借" hasMore:YES andType:InvestNetLoan];
    }else if (section == 1)  {
        sectionHeaderView = [self creatTopTitleView:@"活期" andSubtitle:nil hasMore:YES andType:InvestCurrent];
    }else if (section == 2) {
        sectionHeaderView = [self creatTopTitleView:@"定期" andSubtitle:nil hasMore:YES andType:InvestRegular];
    }
    
    sectionHeaderView.backgroundColor = JF_COLOR_BG;
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFInvestCell *myCell;
    myCell = [JFInvestCell cellWithTableView:tableView];
    if (indexPath.section == 2) {
        JFRegularCell *cell = [JFRegularCell cellWithTableView:tableView hasProgress:NO];
        return cell;
    }
    return myCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return 100;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    sectionFooterView.backgroundColor = [UIColor redColor];
    sectionFooterView.backgroundColor = JF_COLOR_BG;
    return sectionFooterView;
}


- (UIView *)creatTopTitleView:(NSString *)title andSubtitle:(NSString *)subtitle hasMore:(BOOL)more andType:(InvestType)type{
    UIView *faView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
    faView.backgroundColor = JF_COLOR_BG;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0,10, SCREEN_WIDTH , 45)];
    [faView addSubview:leftView];
    leftView.backgroundColor = [UIColor whiteColor];
    [leftView bottomLineX:0 width:SCREEN_WIDTH color:kLineColor];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH/5, leftView.height)];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont boldSystemFontOfSize:16];
    lbTitle.textColor = JF_COLOR_B;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = title;
    [leftView addSubview:lbTitle];
    
    if (subtitle && subtitle.length > 0) {
        [lbTitle sizeToFit];
        
        lbTitle.left = 20;
        lbTitle.centerY = faView.centerY;
        
        UILabel *lbsubTitle = [[UILabel alloc] initWithFrame:CGRectMake(lbTitle.right+5, 0, SCREEN_WIDTH/5, leftView.height)];
        lbsubTitle.text = subtitle;
        lbsubTitle.backgroundColor = [UIColor clearColor];
        lbsubTitle.font = [UIFont systemFontOfSize:14];
        lbsubTitle.textColor = JF_COLOR_C;
        [lbsubTitle sizeToFit];
        lbsubTitle.left = lbTitle.right + 5;
        lbsubTitle.centerY = lbTitle.centerY;
        [leftView addSubview:lbsubTitle];
        
    }
    
    if (more) {
        UIButton *bt = [self createButtonTitle:@"更多" Frame:CGRectMake(SCREEN_WIDTH - 20 - 70, 0, 70, 45) SEL:@selector(tempPushToNetLoan:)];
        [bt setImage:[UIImage imageNamed:@"Page_2.png"] forState:UIControlStateNormal];
        bt.titleLabel.textAlignment = NSTextAlignmentRight;
        bt.backgroundColor = [UIColor clearColor];

        bt.imageEdgeInsets = UIEdgeInsetsMake(0, bt.titleLabel.width + bt.titleLabel.right + 6, 0,  -(bt.titleLabel.width + bt.titleLabel.right)-6);

        bt.tag = type;
        [leftView addSubview:bt];
    }
    
    return faView;
}

- (UIButton *)createButtonTitle:(NSString *)title Frame:(CGRect)frame SEL:(SEL)selector {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    if(title){ [bt setTitle:title forState:UIControlStateNormal];}
    [bt setTitleColor:JF_COLOR_Blue forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor clearColor]];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    if (selector) {[bt addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];}
    
    return bt;
}

- (void)tempPushToNetLoan:(id)sender {
    UIButton *bt = (UIButton *)sender;
    if (bt.tag == InvestNetLoan) {
        JFNetLoanViewController *ctr = [[JFNetLoanViewController alloc]init];
        [self.navigationController pushViewController:ctr animated:YES];
    }else if(bt.tag == InvestCurrent){
        //活期
        JFCurrentViewController *ctr = [[JFCurrentViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }else if(bt.tag == InvestRegular){
        JFRegularViewController *ctr = [[JFRegularViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}


@end

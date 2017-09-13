//
//  ResultViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/3/2.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@property(nonatomic, strong) UITableView *listView;

@end

@implementation ResultViewController


- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.title = @"温馨提示";
    [self createView];
     
}

- (void)createView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    self.listView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.listView];
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    header.backgroundColor = [UIColor redColor];
    self.listView.tableHeaderView = header;
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"successFace.png"]];
    img.center = header.center;
    [header addSubview:img];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 200 - 20)];
    self.listView.tableFooterView = footer;
    
    UILabel *la = [self labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(0, 0, SCREEN_WIDTH, 100) Text:@"您已提交借款申请,请前往我的借款查看进度"];
    //    请耐心等待,\n放款成功后我们将通过短信告知您!
    la.numberOfLines = 0;
    [self.listView.tableFooterView addSubview:la];
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(20, la.bottom, SCREEN_WIDTH - 40, 44);
    [bt setTitle:@"查看我的借款进度" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setBackgroundColor:HB_COLOR_A];
    bt.titleLabel.font = [UIFont systemFontOfSize:18];
    bt.layer.cornerRadius = 5;
    bt.layer.masksToBounds = YES;
    [bt addTarget:self action:@selector(goToXloanDuring:) forControlEvents:UIControlEventTouchUpInside];
    [self.listView.tableFooterView addSubview:bt];
    
    UIButton *homeBt = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBt.frame = CGRectMake(20, bt.bottom + 20, SCREEN_WIDTH - 40, 44);
    [homeBt setTitle:@"返回首页" forState:UIControlStateNormal];
    [homeBt setTitleColor:HB_COLOR_B forState:UIControlStateNormal];
    [homeBt setBackgroundColor:[UIColor whiteColor]];
    homeBt.titleLabel.font = [UIFont systemFontOfSize:18];
    homeBt.layer.cornerRadius = 5;
    homeBt.layer.masksToBounds = YES;
    homeBt.layer.borderColor = HB_COLOR_C.CGColor;
    homeBt.layer.borderWidth = 1;
    [homeBt addTarget:self action:@selector(gotoHomeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.listView.tableFooterView addSubview:homeBt];
    
    
}

- (void)goToXloanDuring:(id)sender {

    NSLog(@"去 借款");
//    HBMyLoanDetailController *ctr = [[HBMyLoanDetailController alloc] initWithApplyId:self.strId];
//    [self.navigationController pushViewController:ctr animated:YES];
//    [HBStatic endPage:Page_submit withApplyId:HBXloanFlow.xloanStep.applyID inArea:@"S_CTP" operation:Operation_click additionInfo:nil];
    
}

- (void)gotoHomeView:(id)sender {

    NSLog(@"回首页");
//    
//    for (UIViewController *ctr in self.navigationController.viewControllers) {
//        if ([ctr isKindOfClass:NSClassFromString(@"HomeViewController")]) {
//            [self.navigationController popToViewController:ctr animated:YES];
//        }
//    }
//    [HBStatic endPage:Page_submit withApplyId:HBXloanFlow.xloanStep.applyID inArea:@"S_RTH" operation:Operation_click additionInfo:nil];
}

- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = text;
    return lbTitle;
}

@end

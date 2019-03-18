//
//  AsyDrawController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/28.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "AsyDrawController.h"
#import "AsyCusView.h"

#import "AsyCusCell.h"
@interface AsyDrawController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *listView;
@property (strong, nonatomic) NSArray *dataArray;


@end

@implementation AsyDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf",@"helo",@"wo",@"wdf"];
    [self buildTableView];
    // Do any additional setup after loading the view.
}

- (void)buildTableView {
    self.listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.listView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;

    self.listView.height = SCREEN_HEIGHT - 20;
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.rowHeight = 46;
    self.listView.showsVerticalScrollIndicator = NO;
    self.listView.pagingEnabled = NO;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
    [self.view addSubview:self.listView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AsyCusCell *cell = [AsyCusCell cellWithTableView:tableView];
    cell.cellTitleString = [self.dataArray objectAtIndex:indexPath.row];
    [cell setNeedsLayout];
    return cell;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSString *textStr = @"";
//    AsyCusView *v = [[AsyCusView alloc] initWithFrame:CGRectMake(50, 200, [UIScreen mainScreen].bounds.size.width - 2 * 50, 5000)];
//    v.text = textStr;
//    v.font = [UIFont systemFontOfSize:16];
//    v.textColor = [UIColor redColor];
//    [self.view addSubview:v];
//    [v.layer setNeedsDisplay];
    
    
    [self buildTableView];
    
    
    
    
//    YYTLabel *lb = [[YYTLabel alloc] initWithFrame:CGRectMake(50, 200, [UIScreen mainScreen].bounds.size.width - 2 * 50, 5000)];
//    lb.text = textStr;
//    lb.font = [UIFont systemFontOfSize:16];
//    lb.te
//    [self.view addSubview:lb];
//    [lb.layer setNeedsDisplay];
  
    
    
//
//    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, [UIScreen mainScreen].bounds.size.width - 2 * 50, 5000)];
//    l.text = textStr;
//    l.font = [UIFont systemFontOfSize:16];
//    l.numberOfLines = 0;
//    l.textColor = [UIColor blueColor];
//    [self.view addSubview:l];
    //    [v.layer setNeedsLayout];
    
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

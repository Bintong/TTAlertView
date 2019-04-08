//
//  SCViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/12.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "SCViewController.h"
#import "SculptNormlTextController.h"
#import "SculptDrawImgController.h"
#import "SculptSysController.h"
#import "SculptFrameController.h"
#import "TravelViewController.h"
@interface SCViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *listView;
@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation SCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"一个游记",@"一个列表",@"一本书demo"]; //@[@"普通文本渲染",@"文本渲染 控制布局",@"普通渲染图片方式",@"同步绘制",@"列表渲染"];
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
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *ctr ;
    if (indexPath.row == 0) {
        ctr = [[TravelViewController alloc] init];
//        ctr = [[SculptSysController alloc] init];
    }else if(indexPath.row == 2){
        ctr = [[SculptFrameController alloc] init];
        
    }else if(indexPath.row == 2){
        ctr = [[SculptDrawImgController alloc] init];
    }else if(indexPath.row == 3){
        ctr = [[SculptSysController alloc] init];
    }
    [self.navigationController pushViewController:ctr animated:YES];
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

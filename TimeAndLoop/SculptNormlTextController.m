//
//  SculptNormlTextController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/12.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "SculptNormlTextController.h"
#import "SculptItem.h"
#import "TBAsyView.h"
#import "NSAttributedString+tb_async.h"
@interface SculptNormlTextController ()

@end

@implementation SculptNormlTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    SculptItem *item = [SculptItem itemWithText:@"hello world"];
    [item appendText:@"hello world"];
    [item appendText:@"hello world"];
//    [item appendText:@"hello world"];
//    [item appendImageWithName:@"123" size:CGSizeMake(15, 15)];
//    [item appendText:@"hello world"];
//    [item appendText:@"hello world"];
    
    TBAsyView *v = [[TBAsyView alloc] initWithFrame:CGRectZero];
    v.attributedItem = item;
    CGSize size =  [item.resultString tb_sizeConstrainedToWidth:self.view.frame.size.width - 20];//后期编写layout 文件 根据内容动态大小
    v.frame = CGRectMake(10, 100, size.width, size.height);
 
    
    [self.view addSubview:v];
    
    
    // Do any additional setup after loading the view.
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

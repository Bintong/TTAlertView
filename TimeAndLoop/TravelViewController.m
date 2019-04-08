//
//  TravelViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/4/3.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TravelViewController.h"
#import "CoreTextData.h"
#import "CTDisplayView.h"
#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"

@interface TravelViewController ()

@end

@implementation TravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    CTDisplayView *dispaleView = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    dispaleView.backgroundColor = [UIColor whiteColor];
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
//    config.textColor = [UIColor redColor];
    config.width = dispaleView.width;
    
   
    NSString *path = [[NSBundle mainBundle] pathForResource:@"travel" ofType:@"json"];
    //创建绘制数据实例
    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
    dispaleView.data = data;
    dispaleView.height = data.height;
    dispaleView.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:dispaleView];

     
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

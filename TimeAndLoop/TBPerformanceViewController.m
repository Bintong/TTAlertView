//
//  TBPerformanceViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/19.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TBPerformanceViewController.h"
#import "TBPerforFPS.h"
@interface TBPerformanceViewController ()

@end

@implementation TBPerformanceViewController
- (IBAction)fpsAction:(id)sender {
    //debug
    [[TBPerforFPS sharedInstance] open];
    //release no use
}

- (IBAction)cpuAction:(id)sender {
    //debug
//    [[TBPerforFPS sharedInstance] close];
    
//    
//    kern_return_t kr;
//    task_info_data_t tinfo;
//    mach_msg_type_number_t task_info_count;
    //release no use
}

- (IBAction)gpuAction:(id)sender {
    //debug
    [[TBPerforFPS sharedInstance] close];
    //release no use
}

- (IBAction)memeryAction:(id)sender {
    //debug
    [[TBPerforFPS sharedInstance] open];
    //release no use
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

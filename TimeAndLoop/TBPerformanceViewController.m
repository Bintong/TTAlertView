//
//  TBPerformanceViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/19.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TBPerformanceViewController.h"
#import "TBPerforFPS.h"
#import "TBCupUse.h"
#import "TBMemeryUse.h"
#import "TBNetReachability.h"

@interface TBPerformanceViewController ()

@end

@implementation TBPerformanceViewController
- (IBAction)fpsAction:(id)sender {
    //debug
    [[TBPerforFPS sharedInstance] open];
    //release no use
}

- (IBAction)cpuAction:(id)sender {
    
    TBCupUse *cpu = [[TBCupUse alloc] init];
    [cpu cpuUse];
 
}

- (IBAction)gpuAction:(id)sender {
    //debug
    [[TBPerforFPS sharedInstance] close];
    //release no use
}

- (IBAction)memeryAction:(id)sender {
    //debug
    NSLog(@"memery use is %f mb", [TBMemeryUse usedMemoryInMB]);
     //release no use
}
- (IBAction)netReachability:(id)sender {
    //debug
    NSLog(@"net is reach is %d", [TBNetReachability socketReachabilityTest]);
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

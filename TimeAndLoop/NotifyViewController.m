//
//  NotifyViewController.m
//  TimeAndLoop
//
//  Created by Bin  Tong on 2017/5/31.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "NotifyViewController.h"

@interface NotifyViewController ()
@property (strong, nonatomic) NSTimer *timer ;
@end

@implementation NotifyViewController

-(void)dealloc {
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeShow) userInfo:nil repeats:YES];
    
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)addobsserverRunLoop {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopObserverContext context = {
        0,()
    }
}

- (void)timeShow {
    NSLog(@"time ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

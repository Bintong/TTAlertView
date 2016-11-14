//
//  RunLoopDemoViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/14.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "RunLoopDemoViewController.h"

@interface RunLoopDemoViewController ()

@end

@implementation RunLoopDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //new thread
    NSThread *newThread = [[NSThread alloc] initWithTarget:self selector:@selector(testThread:) object:nil];
 
    [newThread start];
    
}

- (void)testThread:(id)sender {
    NSLog(@"new log");
    
    
    NSRunLoop *lo = [NSRunLoop currentRunLoop];
    NSTimer *ti = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(log) userInfo:nil repeats:YES];
    //[lo addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    //[lo addTimer: forMode:NSDefaultRunLoopMode];
    //创建observer
  //  CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
    //    NSLog(@"----监听到RunLoop状态---%zd", activity);
    //});
    
    
    // 添加观察者：监听RunLoop的状态
    //CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // 释放Observer
    //CFRelease(observer);
    //仅仅一个就够了，其他的可以省略
    [lo run];


}

- (void)log {
    NSLog(@"new thred");
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

//
//  RunLoopDemoViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/14.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "RunLoopDemoViewController.h"

typedef void(^RunLoopBlock)(void);


@interface RunLoopDemoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSThread *thread1;
@property(nonatomic, strong) NSThread *thread2;
@property(nonatomic, strong) NSThread *thread3;
@property(nonatomic, strong) NSThread *thread4;

@property (strong, nonatomic) NSTimer *timer ;
@property (strong, nonatomic) NSTimer *timerrunloop;

@property(nonatomic, strong) NSMutableArray *tasks;
@property(nonatomic, assign) NSUInteger maxLength;
@property(nonatomic, strong) UITableView *listView;




@end

@implementation RunLoopDemoViewController
- (void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tasks = [NSMutableArray array];
    _maxLength = 18;
    
    
//    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(createRunLoopByNormal) object:nil];
//    [self.thread1 start];
//    
//    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(createRunloopByCFObserver) object:nil];
//    [self.thread2 start];
//    
//    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(createRunLoopByTimer) object:nil];
//    [self.thread3 start];
//    self.thread4 = [[NSThread alloc] initWithTarget:self selector:@selector(createRunloopByCFSource) object:nil];
//    [self.thread4 start];
    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timeShow) userInfo:nil repeats:YES];
//    
//    
//    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self addobsserverRunLoop];
    _timerrunloop = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeMethod) userInfo:nil repeats:YES];
}



- (void)createTableView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    self.listView.showsVerticalScrollIndicator = NO;

    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.rowHeight = 50;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
}
- (void)timeMethod{
    
}

//添加新任务
- (void)addTask:(RunLoopBlock)block {
    [self.tasks addObject:block];
    if (self.tasks.count > self.maxLength) {
        [self.tasks removeObjectAtIndex:0];
    }
}
static void CallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    NSLog(@"run loop call back");
    
    NSLog(@"%@",info);
    RunLoopDemoViewController *vc = (__bridge RunLoopDemoViewController *)info;
    if (vc.tasks.count == 0) {
        return;
    }
    RunLoopBlock task = vc.tasks.firstObject;
    task();
    [vc.tasks removeObjectAtIndex:0];
}

- (void)addobsserverRunLoop {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
   //第一一个上下文
    CFRunLoopObserverContext context = {
      0,(__bridge void *)(self),&CFRetain,&CFRelease,NULL
    };
    
    //创建一个观察者
    static CFRunLoopObserverRef defaultObserver;
    defaultObserver  = CFRunLoopObserverCreate(NULL, kCFRunLoopAfterWaiting, YES, 0, &CallBack, &context);
    
    //添加runloop的观察者
    //模式
    CFRunLoopAddObserver(runloop, defaultObserver, kCFRunLoopCommonModes);
    
    CFRelease(defaultObserver);
    
}

//- (void)timeShow {
//    NSLog(@"time ");
//}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CMainCell = @"CMainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: CMainCell];
    }
    
//    cell.textLabel.text = _arr[indexPath.row];
    [self addTask:^{
        
    }];
    [self addTask:^{
        
    }];
    [self addTask:^{
        
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (IBAction)runloop1:(id)sender {
    //每次都能输出,说明存活
    [self performSelector:@selector(testLog:) onThread:self.thread1 withObject:nil waitUntilDone:NO];
    
}

- (IBAction)runloop2:(id)sender {
    [self performSelector:@selector(testLog:) onThread:self.thread2 withObject:nil waitUntilDone:NO];

    
}

- (IBAction)runloop3:(id)sender {
    //为保青春，用timer
    [self performSelector:@selector(testLog:) onThread:self.thread3 withObject:nil waitUntilDone:NO];
}

- (IBAction)runloop4:(id)sender {
      [self performSelector:@selector(testLog:) onThread:self.thread4 withObject:nil waitUntilDone:NO];
}

- (void)createRunLoopByNormal {
    @autoreleasepool {
        [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] run];
    }
}

- (void)createRunloopByCFObserver {
    @autoreleasepool {
        CFRunLoopRef runloop = CFRunLoopGetCurrent();
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
            NSLog(@"runloop activity ---------->>>%zd",activity);
        });
        
        CFRunLoopAddObserver(runloop, observer, kCFRunLoopDefaultMode);
        CFRelease(observer);
        CFRunLoopRun();
    }
}

- (void)createRunLoopByTimer {
    @autoreleasepool {
        CFRunLoopRef runloop = CFRunLoopGetCurrent();;
        CFRunLoopTimerRef timer = CFRunLoopTimerCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, 0, ^(CFRunLoopTimerRef timer) {
            NSLog(@"timer is ---------->>>%zd",timer);
        });
        CFRunLoopAddTimer(runloop, timer, kCFRunLoopDefaultMode);
        CFRelease(timer);
        CFRunLoopRun();
        
    };
}

- (void)createRunloopByCFSource {
    @autoreleasepool {
        CFRunLoopRef runloop = CFRunLoopGetCurrent();
        CFRunLoopSourceContext source_context ;
        bzero(&source_context, sizeof(source_context));
        CFRunLoopSourceRef source = CFRunLoopSourceCreate(CFAllocatorGetDefault(), 0, &source_context);
        CFRunLoopAddSource(runloop, source, kCFRunLoopDefaultMode);
        CFRelease(source);
        CFRunLoopRun();
    };
}

- (void)testLog:(id)sender {
    NSLog(@"------->new log");
    
    
//    NSRunLoop *lo = [NSRunLoop currentRunLoop];
//    NSTimer *ti = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(log) userInfo:nil repeats:YES];
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
//    [lo run];


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

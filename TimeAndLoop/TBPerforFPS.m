//
//  TBPerforFPS.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/19.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TBPerforFPS.h"
@interface TBPerforFPS()

@property (copy,nonatomic) void (^fpsHandler)(NSInteger fpsValue);
@property (strong , nonatomic) CADisplayLink *displayLink;
@property (assign, nonatomic) NSTimeInterval lastTime;
@property (assign, nonatomic) NSUInteger count;

@end

@implementation TBPerforFPS
- (void)dealloc {
    [self.displayLink setPaused:YES];
    [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

+ (TBPerforFPS *)sharedInstance {
    static TBPerforFPS *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TBPerforFPS alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
       
    }
    return self;
}
- (void)createFPSViewWithDisplay:(CADisplayLink *)disLink{
     if (_lastTime == 0) {
        _lastTime = disLink.timestamp;
        return;
    }
    
    _count ++;
    NSTimeInterval interval = disLink.timestamp - _lastTime;
    if (interval < 1) {
        return;
    }
    _lastTime = disLink.timestamp;
    float fps = _count/interval;
    _count = 0;
    NSString *text = [NSString stringWithFormat:@"%d fps",(int)round(fps)];
    
    NSLog(@"fps is %@",text);
    if (_fpsHandler) {
        _fpsHandler((int)round(fps));
    }
    
}

- (void)open{
    [self.displayLink setPaused:NO];
    //显示ui
}

- (void)openWithAcitonHandle:(void (^)(NSInteger fpsValue))handler {
    [self open ];
    self.fpsHandler = handler;
}

- (void)close {
    NSLog(@"close fps");
    [self.displayLink setPaused:YES];
}

- (void)applicationDidBecomeActiveNotification:(NSNotificationCenter *)notification {
    [self.displayLink setPaused:NO];
}

- (void)applicationWillResignActiveNotification:(NSNotificationCenter *)notification  {
    [self.displayLink setPaused:YES];
}

@end

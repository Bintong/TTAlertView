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

@property (copy,nonatomic)NSString *lastFPSText;

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
- (NSString *)createFPSViewWithDisplay:(CADisplayLink *)disLink{
    //执行次数
    _count ++;
    //当前时间戳
    if(_lastTime == 0){
        _lastTime = disLink.timestamp;
    }
    CFTimeInterval timePassed = disLink.timestamp - _lastTime;
    
    if(timePassed >= 1.f) {
        CGFloat fps = _count/timePassed;
        printf("----fps:%.1f, timePassed:%f\n", fps, timePassed);
        
        //reset
        _lastTime = disLink.timestamp;
        _count = 0;
        _lastFPSText = [NSString stringWithFormat:@"%d fps",(int)round(fps)];
        return _lastFPSText;
    }else {
      return _lastFPSText;
    }
}

    


- (void)open{
    [self.displayLink setPaused:NO];
    //显示ui
}

- (void)openWithAcitonHandle:(void (^)(NSInteger fpsValue))handler {
    [self open];
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

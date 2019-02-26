//
//  TBPerformanceBoard.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/26.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TBPerformanceBoard.h"
#import "TBPerforFPS.h"
#import "TBCupUse.h"
#import "TBMemeryUse.h"
#import "TBNetReachability.h"
@interface TBPerformanceBoard()

@property (strong , nonatomic) CADisplayLink *displayLink;

@end


@implementation TBPerformanceBoard
- (void)open{
    [self.displayLink setPaused:NO];
}

- (void)close {
    NSLog(@"close fps");
    [self.displayLink setPaused:YES];
}

- (void)createPeroformanceBoard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:nil];
    
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
//    _displayLink.frameInterval = 60;
    [_displayLink setPaused:YES];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayLinkTick:(CADisplayLink *)disLink {
    
    [TBCupUse cpuUse];
    [TBMemeryUse usedMemoryInMB];
    [TBNetReachability socketReachabilityTest];
    [[TBPerforFPS sharedInstance] createFPSViewWithDisplay:disLink];
//    if (_lastTime == 0) {
//        _lastTime = disLink.timestamp;
//        return;
//    }
//
//    _count ++;
//    NSTimeInterval interval = disLink.timestamp - _lastTime;
//    if (interval < 1) {
//        return;
//    }
//    _lastTime = disLink.timestamp;
//    float fps = _count/interval;
//    _count = 0;
//    NSString *text = [NSString stringWithFormat:@"%d fps",(int)round(fps)];
//
//    NSLog(@"fps is %@",text);
//    if (_fpsHandler) {
//        _fpsHandler((int)round(fps));
//    }
    
}


- (void)applicationDidBecomeActiveNotification:(NSNotificationCenter *)notification {
    [self.displayLink setPaused:NO];
}

- (void)applicationWillResignActiveNotification:(NSNotificationCenter *)notification  {
    [self.displayLink setPaused:YES];
}

@end

//
//  ObservationInfo.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/21.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "ObservationInfo.h"

@implementation ObservationInfo


- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(void(^)(id observedObject, NSString *observedKey, id oldValue, id newValue))block {
    
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
    
}

@end

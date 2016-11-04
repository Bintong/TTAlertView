//
//  ObservationInfo.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/21.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObservationInfo : NSObject

@property(nonatomic, weak) NSObject *observer;
@property(nonatomic, copy) NSString *key;
@property(nonatomic, copy) void(^block)(id observedObject, NSString *observedKey, id oldValue, id newValue);

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(void(^)(id observedObject, NSString *observedKey, id oldValue, id newValue))block;

@end

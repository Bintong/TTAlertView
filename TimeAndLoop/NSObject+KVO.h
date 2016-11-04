//
//  NSObject+KVO.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/21.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);


@interface NSObject (KVO)

- (void)tb_addObserver:(NSObject *)observer
                forKey:(NSString *)key
             withBlock:(ObservingBlock)block;

- (void)tb_removeObserver:(NSObject *)observer forKey: (NSString *)key;

@end

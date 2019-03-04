//
//  TBMemeryUse.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/23.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBMemeryUse : NSObject

+ (TBMemeryUse *)sharedInstance;


- (CGFloat)usedMemoryInMBWithLink:(CADisplayLink *)disLink;

@end

NS_ASSUME_NONNULL_END

//
//  MyProxy.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/1.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyProxy : NSProxy{
//再内部hold住一个要hook的对象
    id _innerObject;
}

+(instancetype)proxyWithObj:(id)object;

@end

NS_ASSUME_NONNULL_END

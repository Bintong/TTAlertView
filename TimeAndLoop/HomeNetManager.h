//
//  HomeNetManager.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/12/16.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
@interface HomeNetManager : NSObject

- (void)requestHomeData:(void(^)(id result))retHandler;

@end

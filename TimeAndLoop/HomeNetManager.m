//
//  HomeNetManager.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/12/16.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "HomeNetManager.h"

@implementation HomeNetManager

- (void)requestHomeData:(void(^)(id result))retHandler {
    [HttpRequest getWithURLString:@"http://127.0.0.1:5000/api/v1/xia_ifanr" parameters:nil success:^(id responseObject) {
        retHandler(responseObject);
    } failure:^(NSError *error) {
        retHandler(error);
    }];
}
@end

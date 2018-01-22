
//
//  UIViewController+Router.m
//  TimeAndLoop
//
//  Created by BinTong on 2018/1/22.
//  Copyright © 2018年 TongBin. All rights reserved.
//

#import "UIViewController+Router.h"
#import <objc/message.h>
#import <objc/runtime.h>
@implementation UIViewController (Router)
- (void)setParams:(NSDictionary *)params{
    objc_setAssociatedObject(self, @selector(params), params, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSDictionary *)params{
    return objc_getAssociatedObject(self, _cmd);
}
@end

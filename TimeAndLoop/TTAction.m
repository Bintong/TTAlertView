//
//  TTAction.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/3.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "TTAction.h"

@interface TTAction ()

@property(nonatomic, copy) NSString *actionTitle;
@property(nonatomic, copy) dispatch_block_t action;

@end

@implementation TTAction

- (void)dealloc {
    
}

+ (TTAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action {
    TTAction *ttaction = [[self alloc] initTitle:title action:action];
    return ttaction;
}

- (id)initTitle:(NSString *)title action:(dispatch_block_t)action {
    self = [super init];
    if (self) {
        _actionTitle = title;
        _action = action;
    }
    return self;
}

@end

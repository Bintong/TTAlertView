//
//  TTAction.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/3.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAction : NSObject

+ (TTAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action;

@end

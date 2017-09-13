//
//  HBStepView.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/25.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBStepView : UIView

@property(nonatomic, copy) void(^callBackBlock)();


- (id)initWithTitle:(NSString *)title andImageLink:(NSString *)link andFrame:(CGRect)rect;


@end

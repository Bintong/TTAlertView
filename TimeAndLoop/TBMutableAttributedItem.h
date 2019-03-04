//
//  TBMutableAttributedItem.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/2.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBMutableAttributedItem : NSObject

/*
 第一版本 仅仅支持存文本 颜色 字体大小
 
 */

+ (instancetype)itemWithText:(nullable NSString *)text;

- (void)setFont:(UIFont *)fontsize;

- (void)setTextColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

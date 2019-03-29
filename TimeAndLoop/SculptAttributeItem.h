//
//  SculptAttributeItem.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/28.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SculptAttributeItem : NSObject

+ (instancetype)itemWithText:(nullable NSString *)text;

- (void)setFont:(UIFont *)font;

- (void)setColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

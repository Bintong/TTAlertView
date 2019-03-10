//
//  TBCoreAttributedItem.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/8.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBCoreAttributedItem : NSObject

@property (nonatomic,copy)NSString *text;
@property (nonatomic,strong)UIFont *font;
@property (nonatomic,strong)UIColor *color;


+ (instancetype)itemWithText:(NSString *)text;

- (void)setFont:(UIFont *)font;
- (void)setColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

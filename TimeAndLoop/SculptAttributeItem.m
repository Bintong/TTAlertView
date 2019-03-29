//
//  SculptAttributeItem.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/28.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "SculptAttributeItem.h"
@interface SculptAttributeItem ()

@property (nonatomic, strong) NSMutableAttributedString *textStorage;

@end

@implementation SculptAttributeItem
- (id)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _textStorage = [[NSMutableAttributedString alloc] initWithString:text];
        [_textStorage  addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, text.length)];//初始化
        [_textStorage  addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, text.length)];
    }
    return self;
}

+ (instancetype)itemWithText:(nullable NSString *)text {
    SculptAttributeItem *item = [[SculptAttributeItem alloc] initWithText:text];
    return item;
}

- (void)setFont:(UIFont *)font {
    [_textStorage  addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _textStorage.length)];
}

- (void)setColor:(UIColor *)color {
    [_textStorage  addAttribute:NSFontAttributeName value:color range:NSMakeRange(0, _textStorage.length)];
}

@end

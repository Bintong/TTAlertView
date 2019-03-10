//
//  TBCoreAttributedItem.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/8.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TBCoreAttributedItem.h"
#import "NSMutableAttributedString+TBTextProperty.h"
#include <CoreText/CoreText.h>

@interface TBCoreAttributedItem() {
    NSMutableAttributedString *_textStorage;
}

@end

@implementation TBCoreAttributedItem


+ (instancetype)itemWithText:(NSString *)text {
    TBCoreAttributedItem *t = [[TBCoreAttributedItem alloc] initWithText:text];
//    t setFont:_
    return t;
}

- (id)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _textStorage = [[NSMutableAttributedString alloc] initWithString:text];//要 安全判断
        _font = [UIFont systemFontOfSize:14];
        _text = text;
        [_textStorage tba_setFont:[UIFont systemFontOfSize:14]];
        [_textStorage addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, _textStorage.length - 1)];
        
    }
    return self;
}

//- (void)setFont:(UIFont *)font {
//    
//}
//
//- (void)setColor:(UIColor *)color {
//    
//}

@end

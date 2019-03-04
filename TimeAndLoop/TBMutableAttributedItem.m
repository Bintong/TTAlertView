//
//  TBMutableAttributedItem.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/2.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TBMutableAttributedItem.h"


@interface TBMutableAttributedItem () {
    NSMutableAttributedString *_textStorage;
}
@end

@implementation TBMutableAttributedItem
+ (instancetype)itemWithText:(nullable NSString *)text {
    return nil;
}

- (id)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _textStorage = [[NSMutableAttributedString alloc] initWithString:text];
        [_textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [text length])];
        [_textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [text length])];
    }
    return self;
}

- (void)setFont:(UIFont *)fontsize {
    [_textStorage addAttribute:NSFontAttributeName value:fontsize range:NSMakeRange(0, [_textStorage length])];

}

- (void)setTextColor:(UIColor *)color {
    [_textStorage addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [_textStorage length])];

    
}
@end

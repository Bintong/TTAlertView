//
//  NSMutableAttributedString+TBTextProperty.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/8.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "NSMutableAttributedString+TBTextProperty.h"
#include <CoreText/CoreText.h>
#include <CoreFoundation/CoreFoundation.h>
#include <CoreGraphics/CoreGraphics.h>
@implementation NSMutableAttributedString (TBTextProperty)

- (void)tba_setFont:(UIFont *)font{
    [self tba_setFont:font inRange:NSMakeRange(0, self.length)];
}

- (void)tba_setFont:(UIFont *)font inRange:(NSRange)range {
    range = [self tba_effectiveRangeWithRange:range];
    if (!font) {
        [self removeAttribute:(NSString*)kCTFontAttributeName range:range];
    }else {
        [self addAttribute:(NSString*)kCTFontAttributeName value:font range:range];
    }
}

- (NSRange)tba_effectiveRangeWithRange:(NSRange)range {
    NSInteger stringLength = self.length;
    
    if (range.location == NSNotFound ||
        range.location > stringLength)
    {
        range.location = 0;
    }
    
    if (range.location + range.length > stringLength)
    {
        range.length = stringLength - range.location;
    }
    
    return range;
}



@end

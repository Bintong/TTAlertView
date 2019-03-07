//
//  YYTLabel.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/6.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "YYTLabel.h"
#import <CoreText/CoreText.h>
@implementation YYTLabel

+ (Class)layerClass {
    return YYAsyncLayer.class;
}

- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
    
    NSString *text = _text;
    UIFont *font = _font;
    
    YYAsyncLayerDisplayTask *task = [YYAsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer *layer) {
        
    };
    
    task.display = ^(CGContextRef context, CGSize size, BOOL(^isCancelled)(void)) {
        if (isCancelled()) return;
        //在这里由于绘制文字会颠倒
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            CGContextTranslateCTM(context, 0, self.bounds.size.height);
            CGContextScaleCTM(context, 1.0, -1.0);
        }];
        NSAttributedString* str = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:_font}];
        CGContextSetTextPosition(context, 0, font.pointSize);
        CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)str);
        CTLineDraw(line, context);
    };
    
    task.didDisplay = ^(CALayer *layer, BOOL finished) {
        if (finished) {
            // finished
        } else {
            // cancelled
        }
    };
    
    return task;
}

- (void)setText:(NSString *)text {
    _text = text.copy;
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}
- (void)setFont:(UIFont *)font {
    _font = font;
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[YYTransaction transactionWithTarget:self selector:@selector(contentsNeedUpdated)] commit];
}

- (void)contentsNeedUpdated {
    [self.layer setNeedsDisplay];
}
@end

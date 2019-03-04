//
//  AsyCusView.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/28.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "AsyCusView.h"
#import "AsyCusLayer.h"
#import <CoreText/CoreText.h>

@implementation AsyCusView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
+ (Class)layerClass
{
    return [AsyCusLayer class];
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}
- (void)setCenter:(CGPoint)center
{
    [super setCenter:center];
}
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
}





- (void)drawRect:(CGRect)rect{
    NSLog(@"%s",__func__);
}

- (void)displayLayer:(CALayer *)layer {
    NSLog(@"%s",__func__);
    NSLog(@"--是不是main Thread %d",[[NSThread currentThread] isMainThread]);
    ///异步绘制的入口
//    dispatch_queue_t draw_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t draw_queue = dispatch_queue_create("com.thread.my", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(draw_queue, ^{
        CGSize size = self.bounds.size;
        CGFloat scale = [UIScreen mainScreen].scale;
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [self draw:context size:size];
        //获取上下文
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = (__bridge id)(image.CGImage);
        });
    
    });
    
    
}

- (void)draw:(CGContextRef)context size:(CGSize)size {
    //将坐标系上下翻转。因为底层坐标系和UIKit的坐标系原点位置不同。
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0,-1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    
    
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    [attString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, self.text.length)];
    
    
    CTFramesetterRef frameseter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameseter, CFRangeMake(0, attString.length), path, NULL);
    
    CTFrameDraw(frame, context);
    
}

- (void)displayLayer:(AsyCusLayer *)layer
                rect:(CGRect)rect
         drawStarted:(AsyncDrawCallback)startCallBack
        drawFinished:(AsyncDrawCallback)endCallback
         interrupted:(AsyncDrawCallback)interruptedCallBack{
    
//    CGSize contextSize = layer.bounds.size;
//    BOOL contextSizeValid = contextSize.width >=1 && contextSize.height >=1;
//    CGContextRef context = NULL;
//    BOOL drawingFinish = YES;
    
}


@end

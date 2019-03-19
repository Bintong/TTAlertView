//
//  CTDisplayView.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "CTDisplayView.h"
#import "CoreTextImageData.h"
@implementation CTDisplayView

//重写drawRect方法
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    //1.获取当前绘图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.旋转坐坐标系(默认和UIKit坐标是相反的)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //3.绘制内容
//    if (self.data) {
//        CTFrameDraw(self.data.ctFrame, context);
//    }
    if (self.data) {
        
        CTFrameDraw(self.data.ctFrame, context);
        for (CoreTextImageData *imageData in self.data.imageArray) {
            
            UIImage *image = [UIImage imageNamed:imageData.name];
            CGContextDrawImage(context, imageData.imagePostion, image.CGImage);
        }
    }
    
    [super drawRect:rect];
    
    
    
    
}

@end

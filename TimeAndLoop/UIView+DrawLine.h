//
//  UIView+DrawLine.h
//  PanoramicVideo
//
//  Created by zftank on 16/9/1.
//  Copyright © 2016年 PanoramicVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLineSpace  (1.0/[UIScreen mainScreen].scale)

@interface UIView (DrawLine)

//画一条横线
- (void)lineX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width color:(UIColor *)color;

//在顶部画一条横线
- (void)topLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color;

//在底部画一条横线
- (void)bottomLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color;

//画一条竖线
- (void)lineX:(CGFloat)x lineY:(CGFloat)y height:(CGFloat)height color:(UIColor *)color;

@end

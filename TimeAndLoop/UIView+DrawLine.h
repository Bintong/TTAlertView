//
//  UIView+DrawLine.h
//  PanoramicVideo
//
//  Created by zftank on 16/9/1.
//  Copyright © 2016年 PanoramicVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLineSpace  (1.0/[UIScreen mainScreen].scale)

#define kLineColor  [UIColor colorHexString:@"DEDEDE"]

@interface UIView (DrawLine)

#pragma mark -
#pragma mark Draw Horizontal

//画一条横线
- (UIView *)lineX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width color:(UIColor *)color;

//在顶部画一条横线
- (UIView *)topLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color;

//在底部画一条横线
- (UIView *)bottomLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color;

//获取一条横线
+ (UIView *)drawLineX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width space:(CGFloat)space color:(UIColor *)color;

#pragma mark -
#pragma mark Draw Vertical

//画一条竖线
- (UIView *)lineX:(CGFloat)x lineY:(CGFloat)y height:(CGFloat)height color:(UIColor *)color;

//在中间画一条竖线
- (UIView *)centreLineY:(CGFloat)y height:(CGFloat)height color:(UIColor *)color;

@end

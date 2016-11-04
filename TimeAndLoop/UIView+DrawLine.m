//
//  UIView+DrawLine.m
//  PanoramicVideo
//
//  Created by zftank on 16/9/1.
//  Copyright © 2016年 PanoramicVideo. All rights reserved.
//

#import "UIView+DrawLine.h"

@implementation UIView (DrawLine)

//画一条横线
- (void)lineX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width color:(UIColor *)color {
    
    CGRect rect = CGRectMake(x,y,width,kLineSpace);
    UIView *lineView = [[UIView alloc] initWithFrame:rect];
    lineView.userInteractionEnabled = NO;
    lineView.backgroundColor = color;
    
    if ([self isKindOfClass:[UITableViewCell class]])
    {
        [[(UITableViewCell *)self contentView] addSubview:lineView];
    }
    else
    {
        [self addSubview:lineView];
    }
}

- (void)topLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color {

    [self lineX:x lineY:0 width:width color:color];
}

- (void)bottomLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color {

    [self lineX:x lineY:self.height-kLineSpace width:width color:color];
}

//画一条竖线
- (void)lineX:(CGFloat)x lineY:(CGFloat)y height:(CGFloat)height color:(UIColor *)color {
    
    CGRect rect = CGRectMake(x,y,kLineSpace,height);
    UIView *lineView = [[UIView alloc] initWithFrame:rect];
    lineView.userInteractionEnabled = NO;
    lineView.backgroundColor = color;
    
    if ([self isKindOfClass:[UITableViewCell class]])
    {
        [[(UITableViewCell *)self contentView] addSubview:lineView];
    }
    else
    {
        [self addSubview:lineView];
    }
}

@end

//
//  UIView+DrawLine.m
//  PanoramicVideo
//
//  Created by zftank on 16/9/1.
//  Copyright © 2016年 PanoramicVideo. All rights reserved.
//

#import "UIView+DrawLine.h"

@implementation UIView (DrawLine)

#pragma mark -
#pragma mark Draw Horizontal

- (UIView *)drawX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width color:(UIColor *)color value:(UIViewAutoresizing)value {
    
    if (!color)
    {
        color = kLineColor;
    }
    
    CGRect rect = CGRectMake(x,y,width,kLineSpace);
    UIView *lineView = [[UIView alloc] initWithFrame:rect];
    lineView.autoresizingMask = value;
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
    
    return lineView;
}

- (UIView *)lineX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width color:(UIColor *)color {
    
    return [self drawX:x lineY:y width:width color:color value:UIViewAutoresizingNone];
}

- (UIView *)topLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color {
    
    return [self drawX:x lineY:0 width:width color:color value:UIViewAutoresizingFlexibleBottomMargin];
}

- (UIView *)bottomLineX:(CGFloat)x width:(CGFloat)width color:(UIColor *)color {
    
    return [self drawX:x lineY:self.height-kLineSpace width:width color:color value:UIViewAutoresizingFlexibleTopMargin];
}

+ (UIView *)drawLineX:(CGFloat)x lineY:(CGFloat)y width:(CGFloat)width space:(CGFloat)space color:(UIColor *)color {
    
    if (!color)
    {
        color = kLineColor;
    }
    
    CGRect rect = CGRectMake(x,y,width,space);
    UIView *lineView = [[UIView alloc] initWithFrame:rect];
    lineView.autoresizingMask = UIViewAutoresizingNone;
    lineView.userInteractionEnabled = NO;
    lineView.backgroundColor = color;
    return lineView;
}

#pragma mark -
#pragma mark Draw Vertical

- (UIView *)lineX:(CGFloat)x lineY:(CGFloat)y height:(CGFloat)height color:(UIColor *)color {
    
    if (!color)
    {
        color = kLineColor;
    }
    
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
    
    return lineView;
}

- (UIView *)centreLineY:(CGFloat)y height:(CGFloat)height color:(UIColor *)color {
    
    return [self lineX:(SCREEN_WIDTH-kLineSpace)/2 lineY:y height:height color:color];
}

@end

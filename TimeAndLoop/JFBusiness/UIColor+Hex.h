//
//  UIColor+Hex.h
//  MobileSale
//
//  Created by tongbin on 15/12/22.
//  Copyright © 2015年 MobileSale. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JF_COLOR_A       [UIColor colorHexString:@"#F15B5A"] //用于需要突出和强调的文字、按钮和icon
#define JF_COLOR_B       [UIColor colorHexString:@"2d2f46"] //用于较为重要的文字信息、内页标题等
#define JF_COLOR_C       [UIColor colorHexString:@"81849f"]
#define JF_COLOR_D       [UIColor colorHexString:@"B2B4C6"] //label 没有内容的文案


#define JF_COLOR_BG RGBCOLOR(0xF6,0xF5,0xF7) //背景
#define JF_COLOR_Blue RGBCOLOR(0x3a,0x72,0xef) //背景


@interface UIColor (Hex)

+ (UIColor *)colorHexString:(NSString *)hex;

+ (UIColor *)colorHexString:(NSString *)hex alpha:(CGFloat)alpha;

@end

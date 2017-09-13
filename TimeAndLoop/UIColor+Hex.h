//
//  UIColor+Hex.h
//  MobileSale
//
//  Created by zftank on 15/12/22.
//  Copyright © 2015年 MobileSale. All rights reserved.
//

#import <UIKit/UIKit.h>
//
//#define HB_COLOR_A       [UIColor colorHexString:@"009EE2"] //用于需要突出和强调的文字、按钮和icon
//#define HB_COLOR_B       [UIColor colorHexString:@"4d4d4d"] //用于较为重要的文字信息、内页标题等
//#define HB_COLOR_C       [UIColor colorHexString:@"7b7b7b"] //用于普通段落信息 引导词
//#define HB_COLOR_D       [UIColor colorHexString:@"999999"] //用于辅助、此要的文字信息、普通按钮的描边
//#define HB_COLOR_E       [UIColor colorHexString:@"cccccc"] //用于特别弱的文字
//#define HB_COLOR_F       [UIColor colorHexString:@"eceded"] //用于模块分割的底色
//#define HB_COLOR_G       [UIColor colorHexString:@"f3f3f3"] //用于模块分割的底色
//#define HB_COLOR_GRAY    [UIColor colorHexString:@"b1b1b1"] //按钮未点击的颜色
//#define HB_GRAY_Button   [UIColor colorHexString:@"dedede"] //按钮未点击的颜色

@interface UIColor (Hex)

+ (UIColor *)colorHexString:(NSString *)hex;

+ (UIColor *)colorHexString:(NSString *)hex alpha:(CGFloat)alpha;

@end

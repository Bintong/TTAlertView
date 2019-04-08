//
//  CTFrameParserConfig.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//用于配置绘制的参数，例如文字颜色、大小、行间距等
@interface CTFrameParserConfig : NSObject

@property (nonatomic ,assign)CGFloat width;
@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat lineSpace;
@property (nonatomic, assign)CGFloat paragraphSpace;
@property (nonatomic, assign)CGFloat headIndent;
@property (nonatomic, assign)CGFloat tailIndent;
@property (nonatomic, strong)UIColor *textColor;

@end

NS_ASSUME_NONNULL_END

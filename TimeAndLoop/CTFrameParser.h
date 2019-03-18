//
//  CTFrameParser.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
@class CTFrameParserConfig;

//用于生成最后绘制界面需要的CTFrameRef实例
@interface CTFrameParser : NSObject

/**
 *  配置信息格式化
 *
 *  @param config 配置信息
 */
+(NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config;

/**
 *  给内容设置配置信息
 *
 *  @param content 内容
 *  @param config  配置信息
 *
 */
+(CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config;

@end



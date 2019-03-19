//
//  CoreTextUtils.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/19.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextLinkData.h"
#import "CoreTextData.h"

NS_ASSUME_NONNULL_BEGIN
//用于检测链接是否被点击
@interface CoreTextUtils : NSObject
+(CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(CoreTextData *)data;

@end

NS_ASSUME_NONNULL_END

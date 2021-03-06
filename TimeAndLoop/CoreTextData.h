//
//  CoreTextData.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
NS_ASSUME_NONNULL_BEGIN
//用于保存由CTFrameParser类生成的CTFrameRef实例，以及CTFrameRef实际绘制需要的高度
@interface CoreTextData : NSObject

@property (assign,nonatomic)CTFrameRef ctFrame; //被保存的对象

@property (assign,nonatomic)CGFloat height;

@property (strong,nonatomic)NSArray *imageArray;

@property (strong,nonatomic)NSArray *linkArray;

@end

NS_ASSUME_NONNULL_END

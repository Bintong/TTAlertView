//
//  CoreTextImageData.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreTextImageData : NSObject

//图片资源名称
@property (copy,nonatomic) NSString *name;
//图片位置的起始点
@property (assign,nonatomic) CGFloat position;
//图片的尺寸
@property (assign,nonatomic) CGRect imagePostion;

@end

NS_ASSUME_NONNULL_END

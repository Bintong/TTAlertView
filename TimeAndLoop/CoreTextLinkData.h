//
//  CoreTextLinkData.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/19.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreTextLinkData : NSObject

@property (copy, nonatomic)NSString *title;
@property (copy, nonatomic)NSString *url;
@property (assign, nonatomic)NSRange range;

@end

NS_ASSUME_NONNULL_END

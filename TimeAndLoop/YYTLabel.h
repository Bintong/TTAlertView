//
//  YYTLabel.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/6.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTransaction.h"
#import "YYAsyncLayer.h"
NS_ASSUME_NONNULL_BEGIN

@interface YYTLabel : UIView <YYAsyncLayerDelegate>
@property (copy,nonatomic) NSString *text;
@property (copy,nonatomic) UIFont *font;
@end

NS_ASSUME_NONNULL_END

//
//  CTDisplayView.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreTextData.h"
NS_ASSUME_NONNULL_BEGIN
//持有CoreTextData类实例，负责将CFFrameRef绘制在界面上
@interface CTDisplayView : UIView
@property(strong,nonatomic)CoreTextData *data;
@end

NS_ASSUME_NONNULL_END

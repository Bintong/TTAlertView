//
//  TBPerforFPS.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/19.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TBPerforFPS : NSObject


@property (nonatomic,strong)UILabel *fpsLabel;

+ (TBPerforFPS *)sharedInstance;
- (void)createFPSViewWithDisplay:(CADisplayLink *)disLink;
- (void)open;
- (void)openWithAcitonHandle:(void (^)(NSInteger fpsValue))handler;
- (void)close;


@end

NS_ASSUME_NONNULL_END

//
//  AsyCusView.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/28.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AsyncDrawCallback)(BOOL drawInBackground);

@interface AsyCusView : UIView

//设置文字内容
@property(nonatomic, copy) NSString *text;
//设置字体
@property(nonatomic, strong) UIFont *font;



@end

NS_ASSUME_NONNULL_END

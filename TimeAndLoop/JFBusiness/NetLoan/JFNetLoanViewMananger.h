//
//  JFNetLoanViewMananger.h
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>


//typedef NS_ENUM(NSInteger, InvestType) {
//    InvestNetLoan,//网贷
//    InvestRegular,//定期
//    InvestCurrent,//活期
//    InvestTransfer, //转让
//    InvestFeatured //精选
//
//};
typedef void(^CallBack)(InvestType type);


@interface JFNetLoanViewMananger : NSObject
@property(nonatomic, copy) CallBack block;

+ (JFNetLoanViewMananger *)sharedManager;

- (UIView *)buildJxItemView ;//精选标
- (UIView *)buildZqView;// 专区
- (UIView *)buildZrView;// 转让

@end

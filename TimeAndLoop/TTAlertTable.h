//
//  TTAlertTable.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/25.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAlertTable : NSObject

@property(nonatomic, strong) NSArray *datas;
@property(nonatomic, assign) BOOL linkAge;

+ (void)showTableAlertWithCallBack:(void (^)(NSDictionary *dic))callBackDictionary;


@end

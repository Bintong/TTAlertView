//
//  PlaceAreaInfo.h
//  HBankXLoan
//
//  Created by BinTong on 2017/1/12.
//  Copyright © 2017年 HBankXLoan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceAreaInfo : NSObject

@property(nonatomic, copy) NSString *areaCode;
@property(nonatomic, copy) NSString *areaName;

- (id)initWiteDataSource:(NSDictionary *)source;

- (void)analyzeDataSource:(NSDictionary *)source;

@end

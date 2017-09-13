//
//  PlaceProvinceInfo.h
//  HBankXLoan
//
//  Created by BinTong on 2017/1/12.
//  Copyright © 2017年 HBankXLoan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlaceCityInfo;

@interface PlaceProvinceInfo : NSObject

@property(nonatomic, copy) NSString *provinceCode;
@property(nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSArray<PlaceCityInfo *> *cityList;

- (id)initWiteDataSource:(NSDictionary *)source;

- (void)analyzeDataSource:(NSDictionary *)source;

@end

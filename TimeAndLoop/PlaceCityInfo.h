//
//  PlaceCityInfo.h
//  HBankXLoan
//
//  Created by BinTong on 2017/1/12.
//  Copyright © 2017年 HBankXLoan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PlaceAreaInfo;

@interface PlaceCityInfo : NSObject

/** 城市Id，绑卡时需要 */
@property (nonatomic, copy) NSString *cityCode;
/** 城市名 */
@property (nonatomic, copy) NSString *cityName;

@property(nonatomic, copy) NSArray<PlaceAreaInfo *> *areaList;

- (id)initWiteDataSource:(NSDictionary *)source;

- (void)analyzeDataSource:(NSDictionary *)source;

@end

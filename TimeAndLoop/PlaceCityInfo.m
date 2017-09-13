//
//  PlaceCityInfo.m
//  HBankXLoan
//
//  Created by BinTong on 2017/1/12.
//  Copyright © 2017年 HBankXLoan. All rights reserved.
//

#import "PlaceCityInfo.h"

@implementation PlaceCityInfo

- (id)initWiteDataSource:(NSDictionary *)source {
    self = [super init];
    if (self) {
        if ([HBCheckValid checkDictionaryValid:source]) {
            self.cityCode = [source customForKey:@"cityCode"];
            self.cityName = [source customForKey:@"cityName"];
            self.areaList = [source customForKey:@"areaList"];
        }
    }
    return self;
}

- (void)analyzeDataSource:(NSDictionary *)source {
    if ([HBCheckValid checkDictionaryValid:source]) {
        self.cityCode = [source customForKey:@"cityCode"];
        self.cityName = [source customForKey:@"cityName"];
        self.areaList = [source customForKey:@"areaList"];
    }
}

@end

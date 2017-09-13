




//
//  PlaceProvinceInfo.m
//  HBankXLoan
//
//  Created by BinTong on 2017/1/12.
//  Copyright © 2017年 HBankXLoan. All rights reserved.
//

#import "PlaceProvinceInfo.h"

@implementation PlaceProvinceInfo

- (id)initWiteDataSource:(NSDictionary *)source {
    self = [super init];
    if (self) {
        if ([HBCheckValid checkDictionaryValid:source]) {
            self.provinceCode = [source customForKey:@"provinceCode"];
            self.provinceName = [source customForKey:@"provinceName"];
            self.cityList = [source customForKey:@"cityList"];
        }
    }
    return self;
}

- (void)analyzeDataSource:(NSDictionary *)source {
    if ([HBCheckValid checkDictionaryValid:source]) {
        self.provinceCode = [source customForKey:@"provinceCode"];
        self.provinceName = [source customForKey:@"provinceName"];
        self.cityList = [source customForKey:@"cityList"];
    }
}

@end






//
//  PlaceAreaInfo.m
//  HBankXLoan
//
//  Created by BinTong on 2017/1/12.
//  Copyright © 2017年 HBankXLoan. All rights reserved.
//

#import "PlaceAreaInfo.h"

@implementation PlaceAreaInfo

- (id)initWiteDataSource:(NSDictionary *)source {
    self = [super init];
    if (self) {
        if ([HBCheckValid checkDictionaryValid:source]) {
            self.areaCode = [source customForKey:@"areaCode"];
            self.areaName = [source customForKey:@"areaName"];
        }
    }
    return self;
}

- (void)analyzeDataSource:(NSDictionary *)source {
    if ([HBCheckValid checkDictionaryValid:source]) {
        self.areaCode = [source customForKey:@"areaCode"];
        self.areaName = [source customForKey:@"areaName"];
    }
}

@end

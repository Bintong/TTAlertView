
//
//  InfoPutObject.m
//  HBankXLoan
//
//  Created by BinTong on 2016/12/12.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import "InfoPutObject.h"

@implementation InfoPutItemPlaceModel

- (void)analyzeDataSource:(NSDictionary *)source andType:(PlaceType)type{
    if ([HBCheckValid checkDictionaryValid:source]) {
        switch (type) {
            case PlaceProvince:
                _provinceInfo = [[PlaceProvinceInfo alloc] initWiteDataSource:source];
                break;
            case PlaceCity:
                _cityInfo = [[PlaceCityInfo alloc] initWiteDataSource:source];
                break;
            case PlaceArea:
                _areaInfo = [[PlaceAreaInfo alloc] initWiteDataSource:source];
                break;
            default:
                break;
        }
    }
}

@end

@implementation InfoPutItemModel

- (void)analyzeDataSource:(NSDictionary *)source {
    if ([HBCheckValid checkDictionaryValid:source]) {
        self.code = [source customForKey:@"code"];
        self.msg = [source customForKey:@"msg"];
    }
}

@end

@implementation InfoPutObject


- (void)analyzeNoUpdateDataSource:(id)source {
    self.version = [source customForKey:@"data.version"];
    self.marriageStatus = [source customForKey:@"data.marriageStatus"];
}

- (void)analyzeDataSource:(id)source {
    self.version = [source customForKey:@"data.version"];
    self.marriageStatus = [source customForKey:@"data.marriageStatus"];
    //婚姻
    NSArray *marriageStatusList = [source customForKey:@"data.marriageStatusList"];
    self.maritalStatusArray = [self transformNetDataToInfoArray:marriageStatusList];
    //最高学历
    NSArray *degreeList = [source customForKey:@"data.degreeList"];
    self.educationArray= [self transformNetDataToInfoArray:degreeList];
    //月收入
    NSArray *incomeList = [source customForKey:@"data.incomeList"];
    self.incomeArray = [self transformNetDataToInfoArray:incomeList];
    //财力
    NSArray *financialSituationList = [source customForKey:@"data.financialSituationList"];
    self.financialArray = [self transformNetDataToInfoArray:financialSituationList];
    
    //省//市//区域
    NSArray *provinceList = [source customForKey:@"data.provinceList"];
    self.provinceArray = [self transformNetPlaceToInfoArray:provinceList type:PlaceProvince];
    
    //公司行业列表
    NSArray *companyIndustryList = [source customForKey:@"data.companyIndustryList"];
    self.industryArray = [self transformNetDataToInfoArray:companyIndustryList];
    //公司类型
    NSArray *companyTypeList = [source customForKey:@"data.companyTypeList"];
    self.unitProperties = [self transformNetDataToInfoArray:companyTypeList];
    //工龄列表
    NSArray *workYearList = [source customForKey:@"data.workYearList"];
    self.lengthArray = [self transformNetDataToInfoArray:workYearList];
    //联系人关系列表
    NSArray *relationshipList = [source customForKey:@"data.relationshipList"];
    self.relationshipArray = [self transformNetDataToInfoArray:relationshipList];
}


- (NSMutableArray *)transformNetDataToInfoArray :(NSArray *)dataArray{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in dataArray){
        InfoPutItemModel *item = [[InfoPutItemModel alloc] init];
        [item analyzeDataSource:dic];
        [arr addObject:item];
    }
    return arr;
}

- (NSMutableArray *)transformNetPlaceToInfoArray:(NSArray *)placeArray type:(PlaceType)type{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in placeArray){
        InfoPutItemPlaceModel *item = [[InfoPutItemPlaceModel alloc] init];
        [item analyzeDataSource:dic andType:type];
        [arr addObject:item];
    }
    return arr;
}

@end

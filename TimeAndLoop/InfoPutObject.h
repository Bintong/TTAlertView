//
//  InfoPutObject.h
//  HBankXLoan
//
//  Created by BinTong on 2016/12/12.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaceAreaInfo.h"
#import "PlaceCityInfo.h"
#import "PlaceProvinceInfo.h"

typedef NS_ENUM(NSInteger ,PlaceType) {
    PlaceProvince,
    PlaceCity,
    PlaceArea
};

@interface InfoPutItemPlaceModel : NSObject

@property(nonatomic, strong) PlaceAreaInfo *areaInfo;
@property(nonatomic, strong) PlaceCityInfo *cityInfo;
@property(nonatomic, strong) PlaceProvinceInfo *provinceInfo;

- (void)analyzeDataSource:(NSDictionary *)source andType:(PlaceType)type;

@end


@interface InfoPutItemModel : NSObject

@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *msg;

- (void)analyzeDataSource:(NSDictionary *)source;

@end

@interface InfoPutObject : NSObject

@property (nonatomic,copy) NSString *version; //版本
@property (nonatomic,assign) BOOL marriageStatus; //已婚、是否
@property(nonatomic, strong) NSMutableArray *maritalStatusArray; //婚姻
@property(nonatomic, strong) NSMutableArray *educationArray; //学历
@property(nonatomic, strong) NSMutableArray *incomeArray; //月收入
@property(nonatomic, strong) NSMutableArray *financialArray; // 财力状况
@property(nonatomic, strong) NSMutableArray *provinceArray; //省份
@property(nonatomic, strong) NSMutableArray *cityArray; //城市
@property(nonatomic, strong) NSMutableArray *areaArray; //区域
@property(nonatomic, strong) NSMutableArray *industryArray; //行业
@property(nonatomic, strong) NSMutableArray *unitProperties; //单位性质
@property(nonatomic, strong) NSMutableArray *lengthArray;//工龄
@property(nonatomic, strong) NSMutableArray *relationshipArray;//关系

- (void)analyzeDataSource:(id)source;

- (void)analyzeNoUpdateDataSource:(id)source;

- (NSMutableArray *)transformNetPlaceToInfoArray:(NSArray *)placeArray type:(PlaceType)type;

@end

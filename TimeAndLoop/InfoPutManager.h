//
//  InfoPutManager.h
//  HBankXLoan
//
//  Created by BinTong on 2016/12/12.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//


#import "InfoPutObject.h"

typedef NS_ENUM(NSInteger,ShowStep) {
    
    ShowStep_Base = 1,
    ShowStep_Address,
    ShowStep_work,
    ShowStep_communicat,
    ShowStep_Done
};

@interface InfoPutManager : NSObject

@property(nonatomic, strong) InfoPutObject *itemInfo;
@property(nonatomic, strong) NSArray *cityDataList;
@property(nonatomic, strong) NSArray *areaDataList;

//获取信息
- (void)downSelectInfoResult:(void(^)(id *result))retHandler;
//选对应的cell
- (void)selectPickerData:(NSInteger)index atStep:(NSInteger)step callBack:(void (^)(NSArray * data,BOOL showAble))showAble;
- (NSString *)selectPickerKey:(NSInteger)index atStep:(NSInteger)step;
- (BOOL)chargeInfoInputAll:(NSDictionary *)dic atStep:(NSInteger)step;
//点击保存 4个动作
- (void)didSaveInfo:(NSDictionary *)dic result:(void(^)(id *result))retHandler;

//轨迹信息收集
- (void)trajectoryInfoCollectionKey:(NSString *)key value:(NSString *)value  timeInterval:(CGFloat)time;
- (void)trajectorySaveStep:(NSInteger)step;
- (void)traChangeSubmit;
- (void)trajectoryBeforeStep;
@end

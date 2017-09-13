
//
//  InfoPutManager.m
//  HBankXLoan
//
//  Created by BinTong on 2016/12/12.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import "InfoPutManager.h"

#define kAuthData    @"kAuthData"

@interface InfoPutManager ()

@property(nonatomic, strong) NSMutableArray *traArray;
@property(nonatomic, strong) NSMutableArray *finally_traArray;
@property(nonatomic, strong) NSDictionary *trakeyDic;

@end

@implementation InfoPutManager

- (id)init{
    self = [super init];
    if (self) {
        _traArray = [NSMutableArray array];
        _finally_traArray = [NSMutableArray array];
        _trakeyDic =  @{@"marriageState":@"IDDI_MARRIAGE"
                        ,@"degree":@"IDDI_EDU"
                        ,@"incomeRange":@"IDDI_INCM"
                        ,@"financialSituation":@"IDDI_FS"
                        ,@"province":@"IDDI_ADDR_PRN"
                        ,@"city":@"IDDI_ADDR_CTY"
                        ,@"detailAddress":@"IDDI_ADDR"//详细地址
                        ,@"industry":@"IDDI_JOB_INDUSTRY"
                        ,@"companyName":@"IDDI_JOB_CO"
                        ,@"type":@"IDDI_JOB_CT"
                        ,@"workPhone":@"IDDI_JOB_PHN"
                        ,@"workYear":@"IDDI_JOB_YOS"
                        ,@"name":@"IDDI_CTCT_NAME"
                        ,@"mobile":@"IDDI_CTCT_PHN"
                        ,@"relationship":@"IDDI_CTCT_RLAT"};
    }
    return self;
}

- (void)downSelectInfoResult:(void(^)(id *result))retHandler {
   
    NSString *version = @"1.0";
    
    InfoPutObject *input = [FileManager objectForKey:kAuthData catalogue:LogCommon];
    
    if (input)
    {
        version = input.version;
    }
    
//    HTTPDetails *details = [[HTTPDetails alloc] init];
//    details.requestMethod = PostMethod;
//    details.requestUrl = [NSString stringWithFormat:@"%@loanMaterial/getDirectories",kBaseHost];
//    details.requestBody = @{@"version":version};
//    
//    [HTTPLink requestData:self details:details success:^(HTTPDetails *result)
//    {
//        if (result.success)
//        {
//            NSDictionary *dty = [result.resultData customForKey:@"data"];
//            
//            if ([HBCheckValid checkDictionaryValid:dty] && [dty allKeys].count > 2)
//            {
//                self.itemInfo = [[InfoPutObject alloc] init];
//                [self.itemInfo analyzeDataSource:result.resultData];
//                [FileManager setObject:self.itemInfo forKey:kAuthData catalogue:LogCommon];
//            }
//            else
//            {
//                [self failDown];
//                self.itemInfo.marriageStatus = [dty customForKey:@"marriageStatus"];
//            }
//        }
//        else
//        {
//            [self failDown];
//        }
//        
//        if (retHandler)
//        {
//            retHandler(result);
//        }
//    }
//    failure:^(HTTPDetails *result)
//    {
//        [self failDown];
//        
//        if (retHandler)
//        {
//            retHandler(result);
//        }
//    }];
}

- (void)failDown {
    
    InfoPutObject *input = [FileManager objectForKey:kAuthData catalogue:LogCommon];
    
    if (input)
    {
        self.itemInfo = input;
    }
    else
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"auth" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.itemInfo = [[InfoPutObject alloc] init];
        [self.itemInfo analyzeDataSource:result];
        self.itemInfo.version = @"1.0";
        [FileManager setObject:self.itemInfo forKey:kAuthData catalogue:LogCommon];
    }
}

- (void)didSaveInfo:(NSDictionary *)dic result:(void(^)(id *result))retHandler {
    
//    HTTPDetails *details = [[HTTPDetails alloc] init];
//    details.requestMethod = PostMethod;
//    details.requestUrl = [NSString stringWithFormat:@"%@loanMaterial/saveLoanMaterial",kBaseHost];
//    details.requestBody = dic;
//    [HTTPLink requestData:self details:details success:^(HTTPDetails *result){
//        if (result.success) {
//            
//        }
//        if (retHandler) {
//            retHandler(result);
//        }
//        
//    }failure:^(HTTPDetails *result) {
//        
//        if (retHandler) {
//            retHandler(result);
//        }
//        
//    }];
}

- (void)selectPickerData:(NSInteger)index atStep:(NSInteger)step callBack:(void (^)(NSArray * data,BOOL showAble))showAble {
    if (step == ShowStep_Base) {
        if (index == 1) {
            showAble(self.itemInfo.maritalStatusArray, YES);
        }
        if (index == 2) {
            showAble(self.itemInfo.educationArray, YES);
        }
        if (index == 3) {
            showAble(self.itemInfo.incomeArray, YES);
        }
        if (index == 4) {
            showAble(self.itemInfo.financialArray, YES);
        }
    }
    
    if (step == ShowStep_Address) {
        if (index == 2) {
            showAble(self.itemInfo.provinceArray, YES);
        }
        if (index == 3) {
            self.itemInfo.cityArray = [self.itemInfo transformNetPlaceToInfoArray:self.cityDataList type:PlaceCity];
            showAble(self.itemInfo.cityArray, YES);
        }
        if (index == 4) {
            self.itemInfo.areaArray = [self.itemInfo transformNetPlaceToInfoArray:self.areaDataList type:PlaceArea];
            showAble(self.itemInfo.areaArray, self.itemInfo.areaArray.count > 0? YES:NO);
        }
        if (index == 5) {
            showAble(nil, NO);
        }
    }
    if (step == ShowStep_work) {
        if (index == 3) {
            showAble(self.itemInfo.industryArray ,YES);
        }
        if (index == 4) {
            showAble(nil ,NO);
        }
        
        if (index == 5) {
            showAble(self.itemInfo.unitProperties ,YES);
        }
        if (index == 6) {
            showAble(nil ,NO);
        }
        if (index == 7) {
            showAble(self.itemInfo.lengthArray ,YES);
        }
    }
    
    if (step == ShowStep_communicat) {
        if (index == 4) {
            showAble(nil ,NO);
        }
        if (index == 5) {
            showAble(nil ,NO);
        }
        if (index == 6) {
            showAble(self.itemInfo.relationshipArray ,YES);
        }
    }
}

- (NSString *)selectPickerKey:(NSInteger)index atStep:(NSInteger)step {
    if (step == ShowStep_Base) {
        if (index == 1) {
            return @"marriageState";
        }
        if (index == 2) {
            return @"degree";
        }
        
        if (index == 3) {
            return @"incomeRange";
        }
        if (index == 4) {
            return @"financialSituation";
        }
    }
    
    if (step == ShowStep_Address) {
        if (index == 2) {
            return @"province";
        }
        if (index == 3) {
            return @"city";
        }
        if (index == 4) {
            return @"area";
        }
        if (index == 5) {
            return @"detailAddress";
        }
    }
    if (step == ShowStep_work) {
        if (index == 3) {
            return @"industry";
        }
        
        if (index == 4) {
            return @"companyName";
        }
        
        if (index == 5) {
            return @"type";
        }
        if (index == 6) {
            return @"workPhone";
        }
        if (index == 7) {
            return @"workYear";
        }
    }
    if (step == ShowStep_communicat) {
        if (index == 4) {
            return @"name";
        }
        if (index == 5) {
            return @"mobile";
        }
        if (index == 6) {
            return @"relationship";
        }
    }
    return nil;
}

- (BOOL)chargeInfoInputAll:(NSDictionary *)dic atStep:(NSInteger)step {
//    if (step == ShowStep_Base) {
//        NSArray *arr = [dic allKeys];
//        if (arr.count < 4) {
//            NSSet *set = [NSSet setWithArray:arr];
//            if (![set containsObject:@"marriageState"]) {
//                [HBShowHUD showTips:@"请填写婚姻状况" duration:2.0];
//            } else if(![set containsObject:@"degree"]){
//                [HBShowHUD showTips:@"请填写学历状况" duration:2.0];
//            } else if(![set containsObject:@"incomeRange"]){
//                [HBShowHUD showTips:@"请填写收入状况" duration:2.0];
//            } else if(![set containsObject:@"financialSituation"]){
//                [HBShowHUD showTips:@"请填写财力状况" duration:2.0];
//            }
//            
//            
//            
//            return NO;
//        }else {
//            
//            return YES;
//        }
//    }else if (step == ShowStep_Address){
//        NSArray *arr = [dic allKeys];
//        if (arr.count < 4) {
//            NSSet *set = [NSSet setWithArray:arr];
//            if (![set containsObject:@"province"]) {
//                [HBShowHUD showTips:@"请填写所在省份" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"city"]){
//                [HBShowHUD showTips:@"请填写所在城市" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"area"]){
//                [HBShowHUD showTips:@"请填写所在区域" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"detailAddress"]){
//                [HBShowHUD showTips:@"请填写详细地址" duration:2.0];
//                return NO;
//            }
//        }else {
//            NSString *detailAddressStr = [dic objectForKey:@"detailAddress"];
//            if (detailAddressStr.length > 100) {
//                [HBShowHUD showTips:@"输入字符过多" duration:2.0];
//                return NO;
//            }else {
//                return YES;
//            }
//        }
//    }else if (step == ShowStep_work){
//        NSArray *arr = [dic allKeys];
//        if (arr.count < 5) {
//            NSSet *set = [NSSet setWithArray:arr];
//            if (![set containsObject:@"industry"]) {
//                [HBShowHUD showTips:@"请填写所在行业" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"companyName"]){
//                [HBShowHUD showTips:@"请填写工作单位" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"type"]){
//                [HBShowHUD showTips:@"请填写单位性质" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"workPhone"]){
//                [HBShowHUD showTips:@"请填写单位电话" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"workYear"]){
//                [HBShowHUD showTips:@"请填写公司工龄" duration:2.0];
//                return NO;
//            }
//            
//            //先判断是否填写，
//            //然后判断是否规范
//          
//        }else {
//            NSString *companyNameStr = [dic objectForKey:@"companyName"];
//            NSString *phoneNumStr = [dic objectForKey:@"workPhone"];
//            if (companyNameStr.length > 80) {
//                [HBShowHUD showTips:@"填写字段过长" duration:2.0];
//                return NO;
//            }else if(phoneNumStr.length > 20) {
//                [HBShowHUD showTips:@"请填写正确的电话号码" duration:2.0];
//                return NO;
//            }else if(![phoneNumStr isPhoneNumber] && ![phoneNumStr validateTelphone]) {
//                [HBShowHUD showTips:@"请填写正确的电话号码" duration:2.0];
//                return NO;
//            }else {
//                return YES;
//            }
//            
//            
//        }
//    }else if (step == ShowStep_communicat){
//        NSArray *arr = [dic allKeys];
//        if (arr.count < 3) {
//            NSSet *set = [NSSet setWithArray:arr];
//            if (![set containsObject:@"name"]) {
//                [HBShowHUD showTips:@"请填写姓名" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"mobile"]){
//                [HBShowHUD showTips:@"请填写手机号码" duration:2.0];
//                return NO;
//            } else if(![set containsObject:@"relationship"]){
//                [HBShowHUD showTips:@"请填写关系" duration:2.0];
//                return NO;
//            }
//            
//        }else {
//            NSString *name = [dic objectForKey:@"name"];
//            NSString *mobile = [dic objectForKey:@"mobile"];
//            if (name.length > 20) {
//                [HBShowHUD showTips:@"请填写正确联系人姓名" duration:2.0];
//                return NO;
//            }else if(![mobile isPhoneNumber]) {
//                [HBShowHUD showTips:@"联系人手机号码格式错误" duration:2.0];
//                return NO;
//            }else {
//                return YES;
//            }
//            
//        }
//    }
    return NO;
}

- (void)trajectoryInfoCollectionKey:(NSString *)key value:(NSString *)value timeInterval:(CGFloat)time {
    
    NSString *obj = [self.trakeyDic objectForKey:key];
    if (obj) {
        if ([self.traArray indexOfObject:obj]  == NSNotFound) {
            [self.traArray addObject:obj];
        }else{
            [self.finally_traArray addObject:obj];
        }
    }
}

//点击保存
- (void)trajectorySaveStep:(NSInteger)step {
 
//    NSString *traStr = @"";
//    switch (step) {
//        case 1:
//           traStr = @"IDDI_BASE_SAVE";
//            break;
//        case 2:
//            traStr = @"IDDI_ADDR_SAVE";
//            break;
//        case 3:
//            traStr = @"IDDI_JOB_SAVE";
//            break;
//        case 4:
//            [self trajectorySubmit];
//            break;
//        default:
//            break;
//    }
//    
//    if (traStr.length > 0) {
//        [HBStatic ongoingPage:Page_identifyDI withApplyId:HBXloanFlow.xloanStep.applyID inArea:traStr operation:Operation_click additionInfo:nil];
//    }
}

- (void)traChangeSubmit{
//    if (self.finally_traArray.count > 0) {
//        NSMutableString *mutableStr = nil;
//        for (NSString *str in self.finally_traArray) {
//            mutableStr = [NSMutableString stringWithFormat:@""];
//            [mutableStr appendString:[NSString stringWithFormat:@"%@/",str]];
//        }
//        
//        [mutableStr deleteCharactersInRange:NSMakeRange(mutableStr.length - 1, 1)];
//        [self.finally_traArray removeAllObjects];
//        
//        [HBStatic ongoingPage:Page_identifyDI withApplyId:HBXloanFlow.xloanStep.applyID inArea:mutableStr operation:Operation_change additionInfo:nil];
//    }
}

//点击提交
- (void)trajectorySubmit {
//    NSString *traStr = @"IDDI_VLD";
//    [HBStatic endPage:Page_identifyDI withApplyId:HBXloanFlow.xloanStep.applyID inArea:traStr operation:Operation_submit additionInfo:nil];
}

//点击上一不
- (void)trajectoryBeforeStep {
//    NSString *traStr = @"IDDI_PREV";
//    [HBStatic leavePage:Page_identifyDI withApplyId:HBXloanFlow.xloanStep.applyID inArea:traStr operation:Operation_click additionInfo:nil];
}

@end

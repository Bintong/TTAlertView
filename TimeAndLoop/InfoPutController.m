

//
//  InfoPutController.m
//  HBankXLoan
//
//  Created by BinTong on 2016/11/21.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import "InfoPutController.h"
#import "InfoPutCell.h"
#import "InfoPutViewManager.h"


@interface InfoPutController ()<UITableViewDelegate, UITableViewDataSource,InfoPutViewDelegate,UITextFieldDelegate>

@property(nonatomic, strong) UITableView *listView;
@property(nonatomic, strong) NSMutableArray *listData;

//temp
@property(nonatomic, strong) NSArray *array1;
@property(nonatomic, assign) CGFloat KBheight;
@property(nonatomic, strong) UILabel *pickerLabel;
//net
@property(nonatomic, strong) InfoPutManager *dataManager;
@property(nonatomic, copy) NSString * netKey;
@property(nonatomic, copy) NSString * netValue;
@property(nonatomic, strong) NSMutableDictionary *netDic;


@property(nonatomic, strong) UITextField *beginEditTextField;

@end

@implementation InfoPutController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信息认证";
    
    
    [self createView];
    [self createListContents];
    [self registerForKeyboardNotifications];
    self.netDic = [NSMutableDictionary dictionary];
    [InfoPutViewManager sharedManager].deleage = self;
    self.dataManager = [[InfoPutManager alloc] init];
    self.view.backgroundColor = [UIColor colorHexString:@"F3F3F3"];

//    [HBShowHUD showLoading];
//    
//    
//    [self.dataManager downSelectInfoResult:^(HTTPDetails *result) {
//        [HBShowHUD dismissLoading];
//        if (result.success) {
//            if (self.step == ShowStep_communicat) {
//                [self marriedUpdateUI];
//            }
//        }else {
//            [HBShowHUD showTips:result.message duration:2.0];
//        }
//    } ];
    // tip
    if (self.step == 0) {
        self.step = ShowStep_Base;
    }
    
    [self handleViewsTag:self.step];
//    [HBStatic startPage:Page_identifyDI withApplyId:HBXloanFlow.xloanStep.applyID];
    
}

- (void)createView {
    self.listView = [[UITableView alloc] initWithFrame:SCREEN_BOUNDS style:UITableViewStylePlain];
    
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.listView.rowHeight = 46;
    self.listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listView];
    
    //header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 170)];
    img.image = [UIImage imageNamed:@"zz_zltx_bg.png"];
    UIImageView *centerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zz_zltx.png"]];
    centerImg.centerY = img.centerY;
    centerImg.centerX = img.centerX;
    UIImageView *triangleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"triangle.png"]];
    triangleImg.centerX = (SCREEN_WIDTH - 70)/5* 1 + 35 - 10 + 6+ 3;
    triangleImg.top = img.top;
    [header addSubview:img];
    [header addSubview:centerImg];
    [header addSubview:triangleImg];
    self.listView.tableHeaderView = header;
}

- (void)createListContents {
    self.listData = [NSMutableArray array];
    UIView *view1 = [InfoPutViewManager buildUnSelectedViewTitle:@"基本资料" atIndex:1 andList:self.listView];
    UIView *view2 = [InfoPutViewManager buildUnSelectedViewTitle:@"居住地址" atIndex:2 andList:self.listView];
    UIView *view3 = [InfoPutViewManager buildUnSelectedViewTitle:@"工作信息" atIndex:3 andList:self.listView];
    UIView *view4 = [InfoPutViewManager buildUnSelectedViewTitle:@"常用联系人" atIndex:4 andList:self.listView];
    [self.listData addObject:view1];
    [self.listData addObject:view2];
    [self.listData addObject:view3];
    [self.listData addObject:view4];
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *view =  [self.listData objectAtIndex:indexPath.row];
    return view.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoPutCell *myCell = [InfoPutCell cellWithTableView:tableView index:indexPath];
    [myCell refreshAccessoryView:[self.listData objectAtIndex:indexPath.row]];
    return myCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoPutCell *cell =(InfoPutCell *)[tableView cellForRowAtIndexPath:indexPath] ;
    id saveBt =  [cell.accessoryView.subviews objectAtIndex:0];
    if ([saveBt isKindOfClass:[UIButton class]]) {
        return;
    }
    NSLog(@"---subview count ----%ld",cell.accessoryView.subviews.count);
    self.pickerLabel = [cell.accessoryView.subviews objectAtIndex:2];
//    [self.dataManager selectPickerData:indexPath.row atStep:self.step callBack:^(NSArray *data, BOOL showAble) {
//        if (showAble) {
//            if (data.count > 0) {
//                [self alertTableViewShowData:data index:indexPath.row atStep:self.step];
//            }
//            
//        }else {
//            if (self.step == ShowStep_Address && indexPath.row == 10) {
//                [HBShowHUD showTips:@"请先选择城市" duration:2.0];
//            }else if (self.step == ShowStep_communicat && indexPath.row == 6){
//                //提示 配偶信息不可更改
//            }
//        }
//    }];

}


- (void)handleViewsTag:(NSUInteger)tag {
    if (tag == 1) {
        self.array1 = [NSArray arrayWithArray:[InfoPutViewManager buildBaseInfoViews]];
        [self insertArray:self.array1 inOldArray:self.listData atIndex:1];
        //change ui
//        [self changeUIColorCount:1];
        [self.listView reloadData];
        self.step = ShowStep_Base;
    }
    if (tag == 2) {
        [InfoPutViewManager sharedManager].control = self;
        self.array1 = [NSArray arrayWithArray:[InfoPutViewManager buildAddressViews]];
        [self insertArray:self.array1 inOldArray:self.listData atIndex:2];
        [self changeUIColorCount:1];
        [self.listView reloadData];
    }
    
    if (tag == 3) {
        [InfoPutViewManager sharedManager].control = self;
        self.array1 = [NSArray arrayWithArray:[InfoPutViewManager buildWorkViews]];
        [self insertArray:self.array1 inOldArray:self.listData atIndex:3];
        [self changeUIColorCount:2];
        [self.listView reloadData];
    }
    if (tag == 4) {
        [InfoPutViewManager sharedManager].control = self;
        self.array1 = [NSArray arrayWithArray:[InfoPutViewManager buildCommunicateViews]];
        [self insertArray:self.array1 inOldArray:self.listData atIndex:4];
        [self changeUIColorCount:3];
        [self.listView reloadData];
    }
    [self umeng:tag];
}

- (void)insertArray:(NSArray *)newAdditions inOldArray:(NSMutableArray *)oldArray atIndex:(NSUInteger)index{
    
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    for(NSUInteger i = index;i < newAdditions.count+index;i++){
        [indexes addIndex:i];
    }
    [oldArray insertObjects:newAdditions atIndexes:indexes];
}
#pragma mark - ShowAlertTable
- (void)alertTableViewShowData:(NSArray*)alertListData index:(NSInteger)indexCode atStep:(NSInteger)step{
    [self.view endEditing:YES];
//    [ShowTableManager showTable:alertListData callBack:^(NSInteger index)
//    {
//        id model = alertListData[index];
//        
//        if ([model isKindOfClass:NSClassFromString(@"InfoPutItemModel")]) {
//            self.pickerLabel.text = [model valueForKey:@"msg"];
//            self.netValue = [model valueForKey:@"code"];
//            if ((step == 1)&& indexCode == 1) {
//                if (index == 1) {
//                    self.dataManager.itemInfo.marriageStatus = YES;
//                }else {
//                    self.dataManager.itemInfo.marriageStatus = NO;
//                }
//            }
//
//        }else if ([model isKindOfClass:NSClassFromString(@"InfoPutItemPlaceModel")]){
//            if ([model valueForKey:@"provinceInfo"]) {
//                NSString *provinceName = [[model valueForKey:@"provinceInfo"] valueForKey:@"provinceName"];
//                NSString *provinceCode = [[model valueForKey:@"provinceInfo"] valueForKey:@"provinceCode"];
//                self.pickerLabel.text = provinceName;
//                self.netValue = provinceCode;
//                PlaceProvinceInfo *info =[model valueForKey:@"provinceInfo"];
//                self.dataManager.cityDataList = info.cityList;
//                self.dataManager.areaDataList = @[];
//                [self changeCityAndArea];
//            }else if([model valueForKey:@"cityInfo"]) {
//                NSString *cityName = [[model valueForKey:@"cityInfo"] valueForKey:@"cityName"];
//                NSString *cityCode = [[model valueForKey:@"cityInfo"] valueForKey:@"cityCode"];
//                self.pickerLabel.text = cityName;
//                self.netValue = cityCode;
//                PlaceCityInfo *info =[model valueForKey:@"cityInfo"];
//                self.dataManager.areaDataList = info.areaList;
//                [FileManager setObject:[NSString stringWithFormat:@"%@&%@",cityCode,cityName] forKey:@"selectCityInfo"
//                             catalogue:LogCommon];
//                [self changeArea];
//            }else if([model valueForKey:@"areaInfo"]) {
//                NSString *areaName = [[model valueForKey:@"areaInfo"] valueForKey:@"areaName"];
//                NSString *areaCode = [[model valueForKey:@"areaInfo"] valueForKey:@"areaCode"];
//                self.pickerLabel.text = areaName;
//                self.netValue = areaCode;
//            }
//        }
//        self.pickerLabel.textColor = HB_COLOR_B;
//        self.netKey = [self.dataManager selectPickerKey:indexCode atStep:self.step];
//        [self.netDic setObject:self.netValue forKey:self.netKey];
//        //add Trajectory info
//        [self.dataManager trajectoryInfoCollectionKey:self.netKey value:self.pickerLabel.text  timeInterval:[[NSDate date] timeIntervalSince1970]];
//        
//    }];
}

#pragma mark - TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.beginEditTextField = textField;
//    [self editTextField:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.beginEditTextField.text.length > 0) {
//        if (self.beginEditTextField.text != textField.text){
            NSString *key = [self.dataManager selectPickerKey:textField.tag atStep:self.step];
            [self.dataManager trajectoryInfoCollectionKey:key value:textField.text  timeInterval:[[NSDate date] timeIntervalSince1970]];
        }
//    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - InfoViewManagerDelegate
- (void)didSelectedShow:(NSInteger)tag{
    
//    if (tag == self.step) {
//        [HBShowHUD showTips:@"请完成当前步骤" duration:1.0];
//    } else if(tag < self.step){
//        //点击上一步
//        switch (tag) {
//            case 1:
//                [HBShowHUD showTips:@"基本资料已认证完成" duration:1.0];
//                
//                break;
//            case 2:
//                [HBShowHUD showTips:@"地址信息已认证完成" duration:1.0];
//                
//                break;
//            case 3:
//                [HBShowHUD showTips:@"工作信息已认证完成" duration:1.0];
//                
//                break;
//            case 4:
//                [HBShowHUD showTips:@"常用联系人已认证完成" duration:1.0];
//                
//                break;
//                
//            default:
//                break;
//        }
//
//        
//        [self.dataManager trajectoryBeforeStep];
//    }else {
//        switch (self.step) {
//            case 1:
//                [HBShowHUD showTips:@"请先完成基本资料" duration:1.0];
//                
//                break;
//            case 2:
//                [HBShowHUD showTips:@"请先完成地址信息" duration:1.0];
//                
//                break;
//            case 3:
//                [HBShowHUD showTips:@"请先完成工作信息" duration:1.0];
//                
//                break;
//            case 4:
//                [HBShowHUD showTips:@"请先完成常用联系人" duration:1.0];
//                
//                break;
//                
//            default:
//                break;
//        }
//    }
}

- (void)didSelectedSave {
//    [self editTextField:NO];
    NSString *firstKey = @"";
    NSString *typeString = @"";
    

    if (self.step == ShowStep_Base) {
        firstKey = @"basicInfo";
        typeString = @"BASEINFO";
    }
    if (self.step == ShowStep_Address) {
      
        UIView *view = [self.array1 objectAtIndex:3];
        UITextField *textField = [view viewWithTag:5];
        [self buildTextFieldNetDic:textField];
        firstKey = @"address";
        typeString = @"ADDRESS";
        
    }
    
    if (self.step == ShowStep_work) {
        UIView *view_company = [self.array1 objectAtIndex:1];
        UITextField *text_company = [view_company viewWithTag:4];
        [self buildTextFieldNetDic:text_company];

        UIView *view_phone = [self.array1 objectAtIndex:3];
        UITextField *text_phone = [view_phone viewWithTag:6];
        [self buildTextFieldNetDic:text_phone];
        firstKey = @"workInfo";
        typeString = @"WORKINFO";
    }
    
    if (self.step == ShowStep_communicat) {
        UIView *view_name = [self.array1 objectAtIndex:0];
        UITextField *text_name = [view_name viewWithTag:4];
        [self buildTextFieldNetDic:text_name];
        
        UIView *view_phone = [self.array1 objectAtIndex:1];
        UITextField *text_selfphone = [view_phone viewWithTag:5];
        [self buildTextFieldNetDic:text_selfphone];
        firstKey = @"contactInfo";
        typeString = @"CONTACT";
    }
//    if (![self.dataManager chargeInfoInputAll:self.netDic atStep:self.step]) {
//        return;
//    }else {
        [self.view becomeFirstResponder];
//    }
//    [HBShowHUD showLoading];
//    [self.dataManager didSaveInfo:@{firstKey:self.netDic,@"type":typeString} result:^(HTTPDetails *result) {
//        [HBShowHUD dismissLoading];
//        if (result.success) {
            if (self.step == ShowStep_Base) {
                [self.listData removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, 5)]];
                [self handleViewsTag:2];
                self.step = ShowStep_Address;
                [self.netDic removeAllObjects];
            }else if(self.step ==ShowStep_Address){
                [self.listData removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 5)]];
                [self handleViewsTag:3];
                self.step = ShowStep_work;
                [self.netDic removeAllObjects];
            }else if(self.step == ShowStep_work){
                [self.listData removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3,6)]];
                [self handleViewsTag:4];
                self.step = ShowStep_communicat;
                [self.netDic removeAllObjects];
            }else if(self.step == ShowStep_communicat){
                self.step = ShowStep_Done;
                [self.netDic removeAllObjects];
                [self.navigationController popViewControllerAnimated:YES];
            }
//        }else {
//            if ([HBCheckValid checkStringValid:result.message]) {
//                [HBShowHUD showTips:result.message duration:2.0];
//            }else {
//                [HBShowHUD showTips:@"服务器挂掉了" duration:2.0];
//            }
//        }
//        [self.dataManager traChangeSubmit];
//    }];
//    [self umengSave:self.step];
//    [self.dataManager trajectorySaveStep:self.step];

}

#pragma mark - KeyBoard
- (void)editTextField:(BOOL)edit {
    
    if (edit)
    {
        self.listView.height = SCREEN_HEIGHT-220;
    }
    else
    {
        [UIView animateWithDuration:0.3f delay:0.15f options:UIViewAnimationOptionCurveEaseInOut animations:^{
             self.listView.frame = SCREEN_BOUNDS;
        } completion:^(BOOL finished) {
             self.listView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
         }];
    }
}
- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    if (self.KBheight == 0) {
        self.KBheight = kbSize.height;
        
        [UIView animateWithDuration:0.3f delay:0.15f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.listView.height -= (self.KBheight);
            [self.listView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.listData.count - 1 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionBottom];
         } completion:^(BOOL finished) {
 
        }];
        


    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification{
    if (self.KBheight != 0) {
        self.listView.height += (self.KBheight);
        self.KBheight = 0;
    }
}

- (BOOL)buildTextFieldNetDic:(UITextField *)textField {
    if (textField.text.length == 0){
        NSLog(@"----textTag --%ld",textField.tag);
        self.netKey = [self.dataManager selectPickerKey:textField.tag atStep:self.step];
        [self.netDic removeObjectForKey:self.netKey];
        return NO;
    }else {
        self.netValue = textField.text;
        self.netKey = [self.dataManager selectPickerKey:textField.tag atStep:self.step];
        [self.netDic setObject:self.netValue forKey:self.netKey];
        return YES;
    }
}


- (void)changeCityAndArea{
    UILabel *label_city = [[self.array1 objectAtIndex:1] viewWithTag:1010];
    UITextField *label_area = [[self.array1 objectAtIndex:2] viewWithTag:1010];
    NSString *cityValue = [self.netDic objectForKey:@"city"];
    NSString *areaValue = [self.netDic objectForKey:@"area"];
    if ([cityValue integerValue] > 0) {
        label_city.text = @"请选择城市";
        label_city.textColor = HB_COLOR_E;
        [self.netDic removeObjectForKey:@"city"];
    }else {
 
    }
    if ([areaValue integerValue] > 0) {
        label_area.text = @"请选择区域";
        label_area.textColor = HB_COLOR_E;
        [self.netDic removeObjectForKey:@"area"];
    }else {
 
    }
}

- (void)changeArea {
    UITextField *label_area = [[self.array1 objectAtIndex:2] viewWithTag:1010];
    NSString *areaValue = [self.netDic objectForKey:@"area"];
    if ([areaValue integerValue] > 0) {
        label_area.text = @"请选择区域";
        label_area.textColor = HB_COLOR_E;
        [self.netDic removeObjectForKey:@"area"];
    }else {
    }
}


- (void)marriedUpdateUI {
    [self.netDic setObject:@"0301" forKey:@"relationship"];
    UIView *marraystatusView = [self.listData objectAtIndex:6];
    
    UILabel *rightLabel = [marraystatusView viewWithTag:1010];
    rightLabel.textColor = HB_COLOR_B;
    rightLabel.text = @"配偶";
}

- (void)changeUIColorCount:(NSInteger)count {
    NSArray *subViewArray =  [self.listData subarrayWithRange:NSMakeRange(0, count)];
    UIColor *hb_blueColor = [UIColor colorHexString:@"9d94ff"];
    for (UIButton *bt in subViewArray){
        UIView *bgView = bt.subviews[0];
        bgView.backgroundColor = hb_blueColor;
        for (UIView *vi in bgView.subviews) {
            if (vi.tag == 20001) {
                UILabel *lab = (UILabel *)vi;
                lab.textColor = [UIColor whiteColor];
                lab.backgroundColor = [UIColor clearColor];
            }else{
                vi.backgroundColor = [UIColor whiteColor];
            }
            
        }
    }
}
- (void)umeng:(NSInteger)tag {
//    switch (tag) {
//        case 1:
//            if (HBXloanFlow.xloanMode == CardXloanMode) {
//                [HBUMMobClick MKEvent:Event_Card_InfoBaseLoad];
//            }else {
//                [HBUMMobClick MKEvent:Event_Fund_InfoBaseLoad];
//            }
//            break;
//        case 2:
//            if (HBXloanFlow.xloanMode == CardXloanMode) {
//                [HBUMMobClick MKEvent:Event_Card_InfoAddLoad];
//            }else {
//                [HBUMMobClick MKEvent:Event_Fund_InfoAddLoad];
//            }
//            break;
//        case 3:
//            if (HBXloanFlow.xloanMode == CardXloanMode) {
//                [HBUMMobClick MKEvent:Event_Card_InfoWorkLoad];
//            }else {
//                [HBUMMobClick MKEvent:Event_Fund_InfoWorkLoad];
//            }
//            break;
//        case 4:
//            if (HBXloanFlow.xloanMode == CardXloanMode) {
//                [HBUMMobClick MKEvent:Event_Card_InfoCommLoad];
//            }else {
//                [HBUMMobClick MKEvent:Event_Fund_InfoCommLoad];
//            }
//            break;
//            
//        default:
//            break;
//    }
}
- (void)umengSave:(NSInteger)step {
//    switch (step) {
//        case 1:
//            if (HBXloanFlow.xloanMode == CardXloanMode) {
//                [HBUMMobClick MKEvent:Event_Card_InfoBaseSave];
//            }else {
//                [HBUMMobClick MKEvent:Event_Fund_InfoBaseSave];
//            }
//            break;
//        case 2:
//            if (HBXloanFlow.xloanMode == CardXloanMode) {
//                [HBUMMobClick MKEvent:Event_Card_InfoWorkSave];
//            }else {
//                [HBUMMobClick MKEvent:Event_Fund_InfoWorkSave];
//            }
//            break;
//        case 3:
//            if (HBXloanFlow.xloanMode == CardXloanMode) {
//                [HBUMMobClick MKEvent:Event_Card_InfoWorkSave];
//            }else {
//                [HBUMMobClick MKEvent:Event_Fund_InfoWorkSave];
//            }
//            break;
//        case 4:
//            if (HBXloanFlow.xloanMode == CardXloanMode) {
//                [HBUMMobClick MKEvent:Event_Card_InfoCommSave];
//            }else {
//                [HBUMMobClick MKEvent:Event_Fund_InfoCommSave];
//            }
//            break;
//            
//        default:
//            break;
//    }
}

- (void)dealloc {
//    [HBStatic leavePage:Page_identifyDI withApplyId:HBXloanFlow.xloanStep.applyID inArea:@"IDDI_PREV" operation:Operation_click additionInfo:nil];
}

@end

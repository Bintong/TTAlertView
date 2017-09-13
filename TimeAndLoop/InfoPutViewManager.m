//
//  InfoPutViewManager.m
//  HBankXLoan
//
//  Created by BinTong on 2016/11/21.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import "InfoPutViewManager.h"
#import "UIView+DrawLine.h"
@implementation InfoPutViewManager

+ (InfoPutViewManager *)sharedManager {
    static InfoPutViewManager *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

+ (UIView *)buildUnSelectedViewTitle:(NSString *)title atIndex:(NSInteger)index andList:(UITableView *)listView {
    UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46)];
    [bt setBackgroundColor:[UIColor clearColor]];
    bt.tag = index;
    [bt addTarget:[InfoPutViewManager sharedManager] action:@selector(selectTipOne:) forControlEvents:UIControlEventTouchUpInside];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 36)];
//    view.backgroundColor = [UIColor colorHexString:@"9d94ff"];
    view.backgroundColor = [UIColor colorHexString:@"f6f6ff"];
    view.userInteractionEnabled = NO;
    [bt addSubview:view];
    
    UIColor *blueColor = [UIColor colorHexString:@"9d94ff"];
    UILabel *titLab = [[InfoPutViewManager sharedManager] labelWithFontSize:12 FontColor:blueColor frame:CGRectMake(0, 0, SCREEN_WIDTH, 11) Text:title];
    titLab.tag = 20001;
    titLab.textAlignment = NSTextAlignmentCenter;
    [titLab sizeToFit];
    titLab.centerY = view.height/2;
    titLab.centerX = view.centerX;
    [view addSubview:titLab];
    
    CGFloat width = (SCREEN_WIDTH - titLab.width - 10)/2 - 5;
    UIView *rightLine = [UIView drawLineX:0 lineY:0 width:width space:1.0f color:blueColor];
    rightLine.tag = 20002;
    rightLine.centerY = view.height/2;
    [view addSubview:rightLine];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(rightLine.right,0,5,5)];
    grayView.backgroundColor = blueColor;
    //[UIColor whiteColor];
    grayView.tag = 20003;
    grayView.layer.cornerRadius = 2.5;
    grayView.layer.masksToBounds = YES;
    grayView.centerY = view.height/2;
    [view addSubview:grayView];
    
    CGFloat leftX = SCREEN_WIDTH-width;
    UIView *left = [UIView drawLineX:leftX lineY:0 width:width space:1.0f color:blueColor];
    left.tag = 20004;
    left.centerY = view.height/2;
    [view addSubview:left];
    
    grayView = [[UIView alloc] initWithFrame:CGRectMake(left.left-5,0,5,5)];
    grayView.backgroundColor = blueColor;//[UIColor whiteColor];
    grayView.tag = 20005;
    grayView.layer.cornerRadius = 2.5;
    grayView.layer.masksToBounds = YES;
    [listView.tableFooterView addSubview:grayView];
    grayView.centerY = view.height/2;
    [view addSubview:grayView];
    
    return bt;
}

+ (NSArray *)buildBaseInfoViews {
     UIView *view1 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"婚姻状况" rightPicker:@"请选择婚姻状况"];
    UIView *view2 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"最高学历" rightPicker:@"请选择最高学历"];
    UIView *view3 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"月收入范围" rightPicker:@"请选择月收入范围"];
    UIView *view4 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"财力状况" rightPicker:@"请选择财力状况"];
    UIView *view5 = [[InfoPutViewManager sharedManager] saveButtonView:@"保存"];
    NSArray *array = @[view1,view2,view3,view4,view5];
    return array;
}

+ (NSArray *)buildAddressViews {
    UIView *view1 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"所在省份" rightPicker:@"请选择所在省份"];
    UIView *view2 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"所在城市" rightPicker:@"请选择所在城市"];
    UIView *view3 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"所在区" rightPicker:@"请选择所在区域"];
    UIView *view4 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"详细地址" rightTextField:@"街道/小区/楼号/门室号" textFieldtag:5];
    UIView *view5 = [[InfoPutViewManager sharedManager] saveButtonView:@"保存"];
    NSArray *array = @[view1,view2,view3,view4,view5];
    return  array;
}

+ (NSArray *)buildWorkViews {
    UIView *view1 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"所在行业" rightPicker:@"请选择所在行业"];
    UIView *view2 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"工作单位" rightTextField:@"请填写工作单位" textFieldtag:4];
    UIView *view3 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"单位性质" rightPicker:@"请现在单位性质"];
    UIView *view4 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"单位电话" rightTextField:@"区号-电话号-分机号"textFieldtag:6];
    UIView *view5 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"本司工龄" rightPicker:@"请选择本司工龄"];
    UIView *view6 = [[InfoPutViewManager sharedManager] saveButtonView:@"保存"];
    NSArray *array  = @[view1,view2,view3,view4,view5,view6];
    return array;

}
+ (NSArray *)buildCommunicateViews {
    UIView *view1 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"姓名" rightTextField:@"请输入联系人姓名" textFieldtag:4];
    UIView *view2 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"手机号码" rightTextField:@"请输入联系人手机号码"textFieldtag:5];
    UITextField *textfield = [view2 viewWithTag:5];
    textfield.keyboardType =UIKeyboardTypePhonePad;
    UIView *view3 = [[InfoPutViewManager sharedManager] leftLabelTitle:@"关系" rightPicker:@"请选择联系人关系"];
    UIView *button = [[InfoPutViewManager sharedManager] saveButtonView_2:@"提交认证"];

    NSArray *array = @[view1,view2,view3,button];
    return array;
}

- (UIView *)leftLabelTitle:(NSString *)title rightTextField:(NSString *)place textFieldtag:(NSInteger)textFieldtag{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46)];
    [view bottomLineX:15 width:SCREEN_WIDTH - 15 color:nil];

    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 85, 44)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = HB_COLOR_B;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = title;
    [view addSubview:lab];
    
    UITextField * textfield = [[UITextField alloc] initWithFrame:CGRectMake(lab.right ,0,SCREEN_WIDTH - 40 - 5 - lab.width,44)];
    [textfield setBorderStyle:UITextBorderStyleNone];
    textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textfield.returnKeyType = UIReturnKeyDone;
    textfield.keyboardType = UIKeyboardTypeDefault;
    textfield.font = [UIFont systemFontOfSize:14];
    textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textfield.placeholder = place;
    textfield.delegate = [InfoPutViewManager sharedManager].control;
    textfield.tag = textFieldtag;
    [view addSubview:textfield];
    return view;
}

- (UIView *)leftLabelTitle:(NSString *)title rightPicker:(NSString *)place{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46)];
    [view bottomLineX:15 width:SCREEN_WIDTH - 15 color:nil];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 85, 44)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textColor = HB_COLOR_B;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.text = title;

    [view addSubview:lab];
    
    UILabel *rightLab = [self labelWithFontSize:14 FontColor:HB_COLOR_E frame:CGRectMake(lab.right ,0,SCREEN_WIDTH - 40 - 5 -  lab.width,44) Text:place];
    rightLab.tag = 1010;
    [view addSubview:rightLab];
    UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 12 , 8, 14)];
    rightArrow.image = [UIImage imageNamed:@"next.png"];
    rightArrow.centerY = view.centerY;
    rightArrow.right = SCREEN_WIDTH - 15;
    [view addSubview:rightArrow];
    return view;
}

- (UIView *)saveButtonView:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 46)];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(15,10, SCREEN_WIDTH - 30, 30);
    [bt setTitle:@"保存" forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    bt.layer.cornerRadius = 5;
    bt.layer.masksToBounds = YES;
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(saveA:) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = HB_COLOR_A;
    [view addSubview:bt];
    return view;
}

- (UIView *)saveButtonView_2:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(15,0, SCREEN_WIDTH - 30, 40);
    [bt setTitle:@"提交认证" forState:UIControlStateNormal];
    bt.titleLabel.font = [UIFont systemFontOfSize:15];
    bt.layer.cornerRadius = 5;
    bt.layer.masksToBounds = YES;
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(saveA:) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = HB_COLOR_A;
    bt.centerY = view.centerY;
    [view addSubview:bt];
    return view;
}

- (void)saveA:(id)sender {
    if ([self.deleage respondsToSelector:@selector(didSelectedSave)]) {
        [self.deleage didSelectedSave];
    }
}

- (void)selectTipOne:(id)sender {
    UIButton *bt = (UIButton *)sender;
    if ([self.deleage respondsToSelector:@selector(didSelectedShow:)]) {
        [self.deleage didSelectedShow:bt.tag];
    }
}

- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = text;
    return lbTitle;
}

- (UITextField *)currentStepForTextField:(int)step {
    return nil;
}


@end

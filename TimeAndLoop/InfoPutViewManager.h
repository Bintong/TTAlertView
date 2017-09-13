//
//  InfoPutViewManager.h
//  HBankXLoan
//
//  Created by BinTong on 2016/11/21.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InfoPutViewDelegate <NSObject>

- (void)didSelectedSave;
- (void)didSelectedShow:(NSInteger)tag;

@end

@interface InfoPutViewManager : NSObject

@property(nonatomic, weak) id <UITextFieldDelegate> control;
@property(nonatomic, weak) id <InfoPutViewDelegate>deleage;

+ (InfoPutViewManager *)sharedManager;
+ (NSArray *)buildBaseInfoViews;
+ (NSArray *)buildAddressViews;
+ (NSArray *)buildWorkViews;
+ (NSArray *)buildCommunicateViews;
+ (UIView *)buildUnSelectedViewTitle:(NSString *)title atIndex:(NSInteger)index andList:(UITableView *)listView;
- (UITextField *)currentStepForTextField:(int)step;

@end

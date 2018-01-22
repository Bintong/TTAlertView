//
//  JFInvestViewModel.h
//  JiuFuWallet
//
//  Created by BinTong on 2017/11/22.
//  Copyright © 2017年 jayden. All rights reserved.
//

//#import "JFTableViewModel.h"
#import "JFInvestViewModelProtocol.h"

//typedef NS_ENUM(NSInteger, InvestType) {
//    InvestNetLoan,
//    InvestRegular,
//    InvestCurrent
//};

@interface JFInvestItemView

@end

typedef void(^CallBack)(InvestType type);

@interface JFInvestViewModel : NSObject<JFInvestViewModelProtocol>

@property (copy,nonatomic) CallBack block;
//@property (strong, nonatomic) RACCommand *moreCommand;




@end

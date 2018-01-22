//
//  JFRouter.h
//  JiuFuWallet
//
//  Created by jayden on 15/12/27.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "JFRouterProtocol.h"

@interface JFRouter : NSObject<JFRouterProtocol>
+ (instancetype)shared;
@end

//
//  JFBaoItemView.h
//  JiuFuWallet
//
//  Created by BinTong on 2017/11/23.
//  Copyright © 2017年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^JFBaoItemViewBack)();

@interface JFBaoItemView : UIView

@property(nonatomic, copy) JFBaoItemViewBack jfbCallBack;

- (instancetype)initItemView:(id)dataItem andFrame:(CGRect )frame;

@end

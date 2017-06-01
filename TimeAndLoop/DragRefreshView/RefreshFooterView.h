//
//  RefreshFooterView.h
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import "DragRefreshView.h"

@interface RefreshFooterView : DragRefreshView

@property (nonatomic,assign) BOOL haveMore;

+ (RefreshFooterView *)refreshFooterView:(CGRect)rect;

@end

//
//  UIScrollView+Refresh.h
//  HBFinance
//
//  Created by zftank on 16/9/13.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)

/**
 
 必须在主线程调用
 
 下拉刷新时，必须cancel网络请求

 正确计算haveMore
 
**/

- (void)refresh:(id)delegate header:(BOOL)header footer:(BOOL)footer;//加载下拉刷新

- (void)completeLoading:(BOOL)haveMore;//完成下拉刷新，haveMore是否已到最后一页

- (void)autoDropDownAction;//自动下拉刷新

- (void)closeDragRefresh;//关闭下拉刷新

@end

@protocol HBDragRereshDelegate <NSObject>

- (void)refreshDataSource:(BOOL)refreshDrop;//开始请求数据，refreshDrop是否下拉刷新

@end

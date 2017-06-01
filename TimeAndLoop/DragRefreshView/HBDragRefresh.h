//
//  HBDragRefresh.h
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RefreshHeaderView.h"
#import "RefreshFooterView.h"

#define kObserverKey   @"contentOffset"

@interface HBDragRefresh : NSObject

@property (nonatomic,weak) id delegate;
@property (nonatomic,weak) UIScrollView *scrollView;

@property (nonatomic,strong) RefreshHeaderView *headerView;
@property (nonatomic,strong) RefreshFooterView *footerView;

+ (HBDragRefresh *)refresh:(UIScrollView *)rootView header:(BOOL)header footer:(BOOL)footer;

- (void)autoDropDownAction;//自动下拉刷新

- (void)completeLoading:(BOOL)haveMore;//完成刷新，haveMore(是否还有更多数据)

- (void)closeDragRefresh;

@end

@protocol DragRefreshDelegate <NSObject>

- (void)letRefreshHeaderAction;//开始加载下拉刷新的数据

- (void)letRefreshFooterAction;//开始加载上拉刷新的数据

@end

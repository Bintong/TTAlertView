//
//  HBDragRefresh.m
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import "HBDragRefresh.h"
#include <objc/message.h>

@implementation HBDragRefresh

- (void)dealloc {
    
    [self closeDragRefresh];
}

- (void)closeDragRefresh {

    self.delegate = nil;
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.scrollView.contentInset,UIEdgeInsetsZero))
    {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
    
    self.scrollView = nil;
    
    [self.headerView removeFromSuperview];self.headerView = nil;
    [self.footerView removeFromSuperview];self.footerView = nil;
}

+ (HBDragRefresh *)refresh:(UIScrollView *)rootView header:(BOOL)header footer:(BOOL)footer {

    if (!header && !footer)
    {
        return nil;
    }
    
    if (!rootView || ![rootView isKindOfClass:[UIScrollView class]])
    {
        return nil;
    }
    
    HBDragRefresh *manager = [[HBDragRefresh alloc] init];
    
    manager.scrollView = rootView;
    
    if (header)
    {
        CGRect hRect = CGRectMake(0,-rootView.height,rootView.width,rootView.height);
        manager.headerView = [RefreshHeaderView refreshHeaderView:hRect];
        [manager.scrollView addSubview:manager.headerView];
    }
    
    if (footer)
    {
        CGRect fRect = CGRectMake(0,rootView.height,rootView.width,rootView.height);
        manager.footerView = [RefreshFooterView refreshFooterView:fRect];
        [manager.scrollView addSubview:manager.footerView];
    }
    
    if (header || footer)
    {
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [manager.scrollView addObserver:manager forKeyPath:kObserverKey options:options context:nil];
    }
    
    return manager;
}

#pragma mark -
#pragma mark KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    
    if (self.scrollView && [keyPath isEqualToString:kObserverKey])
    {
        if (self.footerView)
        {
            CGRect rect = self.footerView.frame;
            
            CGFloat SY = self.scrollView.contentSize.height;
            
            if (SY < self.scrollView.height)
            {
                SY = self.scrollView.height;
            }
            
            self.footerView.frame = CGRectMake(0,SY,rect.size.width,rect.size.height);
        }
        
        if (self.headerView && self.headerView.state == PullRefreshLoading)
        {
            CGFloat offset = MAX(-1*self.scrollView.contentOffset.y,0);
            offset = MIN(offset,kDragHeight);
            self.scrollView.contentInset = UIEdgeInsetsMake(offset,0,0,0);
            
            return;
        }
        
        if (self.scrollView.isDragging)
        {
            if (self.headerView)
            {
                CGFloat OffY = self.scrollView.contentOffset.y;
                
                if ((self.headerView.state == PullRefreshPulling) && (-kDragHeight < OffY) && (OffY < 0))
                {
                    [self.headerView refreshState:PullRefreshNormal];
                }
                else if ((self.headerView.state == PullRefreshNormal) && (OffY < -kDragHeight))
                {
                    [self.headerView refreshState:PullRefreshPulling];
                }
                
                if (self.scrollView.contentInset.top != 0)
                {
                    self.scrollView.contentInset = UIEdgeInsetsZero;
                }
            }
            
            if (self.footerView && self.footerView.haveMore && self.footerView.state != PullRefreshLoading)
            {
                CGFloat OffY = self.scrollView.contentOffset.y;
                CGFloat CSH = self.scrollView.contentSize.height-self.scrollView.height;
                
                CGFloat distance;
                
                if (CSH <= 0)
                {
                    distance = kDragHeight;
                }
                else
                {
                    distance = CSH+kDragHeight;
                }
                
                if ((self.footerView.state == PullRefreshPulling) && (CSH < OffY) && (OffY < distance))
                {
                    [self.footerView refreshState:PullRefreshNormal];
                }
                else if ((self.footerView.state == PullRefreshNormal) && (distance < OffY))
                {
                    [self.footerView refreshState:PullRefreshPulling];
                }
                
                if (self.scrollView.contentInset.bottom != 0)
                {
                    self.scrollView.contentInset = UIEdgeInsetsZero;
                }
            }
        }
        else
        {
            [self completeDragAction];
        }
    }
}

- (void)autoDropDownAction {
    
    if (self.headerView && self.headerView.state == PullRefreshNormal)
    {
        [self.headerView refreshState:PullRefreshPulling];
        
        self.scrollView.contentOffset = CGPointMake(0,-kDragHeight);
        
        [self completeDragAction];
    }
}

- (void)completeDragAction {
    
    if (self.headerView && self.headerView.state == PullRefreshPulling)
    {
        [self.headerView refreshState:PullRefreshLoading];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(letRefreshHeaderAction)])
        {
            [self.delegate letRefreshHeaderAction];
        }
        
        if (self.footerView && self.footerView.state == PullRefreshLoading && self.footerView.haveMore)
        {
            [self.footerView refreshState:PullRefreshCancel];
        }
        
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^
        {
            self.scrollView.contentInset = UIEdgeInsetsMake(kDragHeight,0,0,0);
        }
        completion:^(BOOL finished)
        {
            
        }];
    }
    
    if (self.footerView && self.footerView.state == PullRefreshPulling && self.footerView.haveMore)
    {
        [self.footerView refreshState:PullRefreshLoading];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(letRefreshFooterAction)])
        {
            [self.delegate letRefreshFooterAction];
        }
        
        CGFloat distance = self.scrollView.height-self.scrollView.contentSize.height;
        
        if (distance < 0)
        {
            distance = 0.0f;
        }
        
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^
        {
            self.scrollView.contentInset = UIEdgeInsetsMake(0,0,distance+kDragHeight,0);
        }
        completion:^(BOOL finished)
        {
            self.scrollView.contentInset = UIEdgeInsetsMake(0,0,distance+kDragHeight,0);
        }];
    }
}

- (void)completeLoading:(BOOL)haveMore {

    if (self.footerView && (self.footerView.state == PullRefreshLoading || self.footerView.state == PullRefreshCancel))
    {
        self.footerView.haveMore = haveMore;
        [self.footerView refreshState:PullRefreshNormal];
        [self performSelector:@selector(restoreAction) withObject:nil afterDelay:0.0f];
    }
    else if (self.headerView && self.headerView.state == PullRefreshLoading)
    {
        [self.headerView refreshState:PullRefreshNormal];
        [self.headerView refreshDragLastDate];
        
        self.footerView.haveMore = haveMore;
        [self.footerView refreshState:PullRefreshNormal];
        [self restoreAction];
    }
}

- (void)restoreAction {

    [UIView animateWithDuration:0.2f delay:0.1f options:UIViewAnimationOptionCurveEaseInOut animations:^
    {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }
    completion:^(BOOL finished)
    {
        self.scrollView.contentInset = UIEdgeInsetsZero;
    }];
}

@end

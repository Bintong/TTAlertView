//
//  RefreshFooterView.m
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import "RefreshFooterView.h"

@implementation RefreshFooterView

+ (RefreshFooterView *)refreshFooterView:(CGRect)rect {

    RefreshFooterView *refreshView = [[RefreshFooterView alloc] initWithFrame:rect];
    refreshView.haveMore = YES;
    
    CGRect sRect = CGRectMake(0,0,refreshView.width,kDragHeight);
    refreshView.lbStatus = [[UILabel alloc] initWithFrame:sRect];
    refreshView.lbStatus.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    refreshView.lbStatus.font = [UIFont systemFontOfSize:13.0f];
    refreshView.lbStatus.textColor = RGBCOLOR(0x80,0x80,0x80);
    refreshView.lbStatus.backgroundColor = [UIColor clearColor];
    refreshView.lbStatus.textAlignment = NSTextAlignmentCenter;
    [refreshView addSubview:refreshView.lbStatus];
    
    refreshView.rotateView = [[UIImageView alloc] initWithFrame:CGRectMake(36,(kDragHeight-23)/2,23,23)];
    refreshView.rotateView.backgroundColor = [UIColor clearColor];refreshView.rotateView.image = kArrowImage;
    [refreshView addSubview:refreshView.rotateView];
    
    [refreshView refreshState:PullRefreshNormal];
    
    return refreshView;
}

- (void)refreshState:(PullRefreshState)aState {
    
    self.state = aState;
    
    switch (self.state)
    {
        case PullRefreshPulling:
        {
            self.lbStatus.text = @"松开立即加载更多...";
            
            [self.rotateView.layer removeAllAnimations];
            
            break;
        }
        case PullRefreshNormal:
        case PullRefreshCancel:
        {
            if (self.haveMore)
            {
                self.lbStatus.text = @"上拉可以加载更多...";
            }
            else
            {
                self.lbStatus.text = @"已到最后一页啦...";
            }
            
            [self.rotateView.layer removeAllAnimations];
            
            self.rotateView.layer.transform = CATransform3DIdentity;
            
            break;
        }
        case PullRefreshLoading:
        {
            self.lbStatus.text = @"正在刷新数据中...";
            
            self.rotateView.layer.transform = CATransform3DIdentity;
            
            [self arrowAnimation:2.0f * M_PI duration:kDuration];
            
            break;
        }
        default:
        {
            break;
        }
    }
}

@end

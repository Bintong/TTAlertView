//
//  RefreshHeaderView.m
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import "RefreshHeaderView.h"

@interface RefreshHeaderView ()

@end

@implementation RefreshHeaderView

+ (RefreshHeaderView *)refreshHeaderView:(CGRect)rect {

    RefreshHeaderView *refreshView = [[RefreshHeaderView alloc] initWithFrame:rect];
    
    CGFloat distance = kDragHeight/2;
    CGRect sRect = CGRectMake(0,rect.size.height-kDragHeight+13,rect.size.width,distance);
    refreshView.lbStatus = [[UILabel alloc] initWithFrame:sRect];
    refreshView.lbStatus.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    refreshView.lbStatus.font = [UIFont systemFontOfSize:13.0f];
    refreshView.lbStatus.textColor = RGBCOLOR(0x80,0x80,0x80);
    refreshView.lbStatus.backgroundColor = [UIColor clearColor];
    refreshView.lbStatus.textAlignment = NSTextAlignmentCenter;
    [refreshView addSubview:refreshView.lbStatus];
    
    CGRect dRect = CGRectMake(0,rect.size.height-distance,rect.size.width,distance);
    refreshView.lastDate = [[UILabel alloc] initWithFrame:dRect];
    refreshView.lastDate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    refreshView.lastDate.font = [UIFont systemFontOfSize:12.0f];
    refreshView.lastDate.textColor = RGBCOLOR(0x80,0x80,0x80);
    refreshView.lastDate.backgroundColor = [UIColor clearColor];
    refreshView.lastDate.textAlignment = NSTextAlignmentCenter;
    [refreshView addSubview:refreshView.lastDate];
    
    CGFloat rt = rect.size.height-kDragHeight+28;
    refreshView.rotateView = [[UIImageView alloc] initWithFrame:CGRectMake(36,rt,23,23)];
    refreshView.rotateView.backgroundColor = [UIColor clearColor];refreshView.rotateView.image = kArrowImage;
    [refreshView addSubview:refreshView.rotateView];
    
    [refreshView refreshState:PullRefreshNormal];
    
    [refreshView refreshDragLastDate];
    
    return refreshView;
}

- (void)refreshState:(PullRefreshState)aState {
    
    self.state = aState;
    
    switch (self.state)
    {
        case PullRefreshPulling:
        {
            self.lbStatus.text = @"松开立即刷新...";
            
            [self.rotateView.layer removeAllAnimations];
            
            break;
        }
        case PullRefreshNormal:
        {
            self.lbStatus.text = @"下拉可以刷新...";
            
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

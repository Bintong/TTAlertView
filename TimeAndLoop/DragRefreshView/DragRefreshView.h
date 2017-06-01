//
//  DragRefreshView.h
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,PullRefreshState) {
    
    PullRefreshPulling = 0,         //松手即可刷新
    
    PullRefreshNormal = 1,          //拖动可以刷新
    
    PullRefreshLoading = 2,         //正在加载数据
    
    PullRefreshCancel = 3,          //上拉刷新被下拉刷新取消
};

#define kDuration     1.3f

#define kArrowImage   [UIImage imageNamed:@"loading"]

#define kDragHeight   66.0f

@interface DragRefreshView : UIView

@property (nonatomic,strong) UIImageView *rotateView;
@property (nonatomic,strong) UILabel *lastDate;
@property (nonatomic,strong) UILabel *lbStatus;
@property (nonatomic,assign) PullRefreshState state;

- (void)refreshDragLastDate;

- (void)refreshState:(PullRefreshState)aState;

- (void)arrowAnimation:(float)angle duration:(NSTimeInterval)duration;

@end

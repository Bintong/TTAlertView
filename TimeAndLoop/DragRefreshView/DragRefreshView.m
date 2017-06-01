//
//  DragRefreshView.m
//  HBFinance
//
//  Created by zftank on 16/9/4.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import "DragRefreshView.h"

@implementation DragRefreshView

- (void)dealloc {

    [self.rotateView.layer removeAllAnimations];
    self.rotateView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    
    return self;
}

- (void)refreshState:(PullRefreshState)aState {

}

- (void)refreshDragLastDate {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];[formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"MM-dd HH:mm:ss"];
    NSString *last = [formatter stringFromDate:date];
    self.lastDate.text = [NSString stringWithFormat:@"最后更新 %@",last];
}

- (void)arrowAnimation:(float)angle duration:(NSTimeInterval)duration {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:angle];
    animation.duration = duration;
    animation.cumulative = YES;
    animation.repeatCount = 10000;
    animation.removedOnCompletion = NO;
    [self.rotateView.layer addAnimation:animation forKey:@"rotationAnimation"];
}

@end

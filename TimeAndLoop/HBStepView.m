//
//  HBStepView.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/25.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "HBStepView.h"

@interface HBStepView ()

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *link;

@end


@implementation HBStepView

- (id)initWithTitle:(NSString *)title andImageLink:(NSString *)link andFrame:(CGRect)rect{
    self = [super initWithFrame:rect];
    if (self) {
        _title = title;
        _link = link;
        [self  loadView];
    }
    return self;
}


- (void)loadView {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = self.bounds;
    [bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bt];
    
    self.backgroundColor = HB_COLOR_G;
    UILabel *lab = [self labelWithFontSize:14 FontColor:HB_COLOR_B frame:CGRectMake(0, 0, 0, 0) Text: _title];
    lab.left = (self.width - lab.width)/2;
    lab.top = 5;
    [bt addSubview:lab];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, lab.bottom + 5, self.width - 10, self.height - lab.bottom - 10)];
    [imageView setBackgroundColor:[UIColor redColor]];
    [bt addSubview:imageView];
}

- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = text;
    [lbTitle sizeToFit];
    
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt addTarget:self action:@selector(hl:) forControlEvents:UIControlEventTouchUpInside];
    
    return lbTitle;
}

- (void)hl:(id)sender {
    
}


- (void)clickAction:(id)sender {
    NSLog(@"selected item");
    self.callBackBlock();
}
@end

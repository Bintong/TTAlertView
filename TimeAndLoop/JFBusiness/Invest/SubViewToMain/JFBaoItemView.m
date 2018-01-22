//
//  JFBaoItemView.m
//  JiuFuWallet
//
//  Created by BinTong on 2017/11/23.
//  Copyright © 2017年 jayden. All rights reserved.
//

#import "JFBaoItemView.h"

@implementation JFBaoItemView

- (instancetype)initItemView:(id)dataItem andFrame:(CGRect )frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        UIView *faView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
        faView.backgroundColor = JF_COLOR_BG;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0,10, SCREEN_WIDTH , 45)];
        leftView.backgroundColor = [UIColor whiteColor];
        [leftView bottomLineX:20 width:SCREEN_WIDTH - 40 color:kLineColor];
//        [faView addSubview:leftView];
        UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH/5, leftView.height)];
        lbTitle.backgroundColor = [UIColor clearColor];
        lbTitle.font = [UIFont systemFontOfSize:14];
        lbTitle.textColor = JF_COLOR_B;
        lbTitle.textAlignment = NSTextAlignmentLeft;
        lbTitle.text = @"玖富宝";
        
        lbTitle.font = [UIFont boldSystemFontOfSize:14];
        lbTitle.textAlignment = NSTextAlignmentLeft;
        [leftView addSubview:lbTitle];
        NSString * subtitle = @"随存随取，实时到账";
        if (subtitle && subtitle.length > 0) {
            [lbTitle sizeToFit];
            
            lbTitle.left = 20;
            lbTitle.centerY = faView.centerY;
            
            UILabel *lbsubTitle = [[UILabel alloc] initWithFrame:CGRectMake(lbTitle.right+5, 0, SCREEN_WIDTH/5, leftView.height)];
            lbsubTitle.text = subtitle;
            lbsubTitle.backgroundColor = [UIColor clearColor];
            lbsubTitle.font = [UIFont systemFontOfSize:14];
            lbsubTitle.textColor = JF_COLOR_C;
            [lbsubTitle sizeToFit];
            lbsubTitle.left = lbTitle.right + 5;
            lbsubTitle.centerY = lbTitle.centerY;
            [leftView addSubview:lbsubTitle];
        
        }
        [self addSubview:faView];
        
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20 + 45, SCREEN_WIDTH - 40, 100)];
        imageView.backgroundColor = [UIColor blackColor];
        
        
        UILabel *subScpritLab = [self labelWithFontSize:14 FontColor:[UIColor whiteColor] frame:CGRectMake(20, 0, 90, 14) Text:@"七日年化收益率"];
        subScpritLab.centerY = imageView.height/2;
        
        UILabel *numLab = [self labelWithFontSize:18 FontColor:[UIColor whiteColor] frame:CGRectMake(20, subScpritLab.top - 10 - subScpritLab.height, 180, 18) Text:@"4.434343%"];
        
        UILabel *otherworld = [self labelWithFontSize:18 FontColor:[UIColor whiteColor] frame:CGRectMake(20, subScpritLab.bottom + 10, 90, 18) Text:@"可支付网贷产品"];
        otherworld.font = [UIFont boldSystemFontOfSize:14];
        UIButton * bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(50, 150, 55, 22);
        bt.backgroundColor = [UIColor redColor];
        [faView addSubview:bt];
        [bt addTarget:self action:@selector(pushToJFB:) forControlEvents:UIControlEventTouchUpInside];

        //        UIButton *button = [self createButtonTitle:@"立即转入" Frame:CGRectMake(55, 55, 170/2, 64/2) SEL:@selector(pushToJFB:)];
//
//        [faView addSubview:button];
//        [imageView addSubview:numLab];
//        [imageView addSubview:subScpritLab];
//        [imageView addSubview:otherworld];
//        [imageView addSubview:button];

        
//        [faView addSubview:imageView];
        
        
    }
    return self;
}

- (void)pushToJFB:(id)sender {
    self.jfbCallBack();
}


- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = text;
    return lbTitle;
}

- (UIButton *)createButtonTitle:(NSString *)title Frame:(CGRect)frame SEL:(SEL)selector {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:HB_COLOR_B forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor whiteColor]];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    [bt addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  JFRegularCell.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFRegularCell.h"



@implementation JFRegularCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"JFRegularCell";
    
    JFRegularCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseId:cellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseId:(NSString *)cellID {
    
    if (self = [super initWithStyle:style reuseIdentifier:cellID])
    {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH ,117)];
        
        [view bottomLineX:0 width:SCREEN_WIDTH color:JF_COLOR_D];
        
        UIView *subTitleView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 40)];
        UILabel *qiquanLab = [self labelWithFontSize:12 FontColor:JF_COLOR_B frame:CGRectMake(20, 0, 100, 40) Text:@"期权ETF50第1期"];
        UILabel *trendLab = [self labelWithFontSize:12 FontColor:JF_COLOR_B frame:CGRectMake(qiquanLab.right, 0, 100, 40) Text:@"期权看涨"];
        [subTitleView addSubview:trendLab];
        [subTitleView addSubview:qiquanLab];
        [subTitleView bottomLineX:20 width:SCREEN_WIDTH color:JF_COLOR_D];
        [view addSubview:subTitleView];
        
        UILabel *leftMidLab = [self labelWithFontSize:30 FontColor:JF_COLOR_A frame:CGRectMake(20, 0, 60, 0) Text:@"8%"];
        [leftMidLab sizeToFit];
        leftMidLab.centerY = view.centerY + 20;
        [view addSubview:leftMidLab];
        
        UILabel *subNumLab = [self labelWithFontSize:14 FontColor:JF_COLOR_B frame:CGRectMake(0, 0,50, 14) Text:@"+18%"];
        UILabel *subNumTextLab = [self labelWithFontSize:12 FontColor:JF_COLOR_C frame:CGRectMake(0, subNumLab.bottom + 5, 50, 12) Text:@"浮动最高"];
        UIView *subNumView = [[UIView alloc] initWithFrame:CGRectMake(leftMidLab.right, 0, 50, 31)];
        [subNumView addSubview:subNumLab];
        [subNumView addSubview:subNumTextLab];
        subNumView.centerY = leftMidLab.centerY;
        [view addSubview:subNumView];
        
        UILabel *dayLab = [self labelWithFontSize:16 FontColor:JF_COLOR_B frame:CGRectMake(0, 0, 10, 10) Text:@"1000天"];
        [dayLab sizeToFit];
        dayLab.centerX = view.centerX;
        dayLab.centerY = view.centerY + 20;
        [view addSubview:dayLab];
        
        UIButton *joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [view addSubview:joinButton];
        joinButton.userInteractionEnabled = YES;
        joinButton.backgroundColor = JF_COLOR_A;
        joinButton.titleLabel.font = [UIFont systemFontOfSize:14];
        joinButton.frame = CGRectMake(SCREEN_WIDTH - 75- 20, 0, 75, 26);
        joinButton.centerY =dayLab.centerY;
        [joinButton setTitle:@"立即投资" forState:UIControlStateNormal];
        
        [view addSubview:joinButton];
        
    }
    
    return self;
}


- (UIButton *)createButtonTitle:(NSString *)title Frame:(CGRect)frame SEL:(SEL)selector {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    if(title){ [bt setTitle:title forState:UIControlStateNormal];}
    [bt setTitleColor:JF_COLOR_B forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor clearColor]];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    if (selector) {[bt addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];}
    return bt;
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
@end

//
//  JFSupriseCell.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFSupriseCell.h"

@implementation JFSupriseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"JFSupriseCell";
    
    JFSupriseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseId:cellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseId:(NSString *)cellID {
    
    if (self = [super initWithStyle:style reuseIdentifier:cellID])
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        //        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH ,117)];
        
        UIView *view = self.contentView;
        [view bottomLineX:0 width:SCREEN_WIDTH color:JF_COLOR_D];
        
        UIView *subTitleView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 50)];
        UILabel *qiquanLab = [self labelWithFontSize:14 FontColor:JF_COLOR_C frame:CGRectMake(20, 0, 120, 50) Text:@"期权ETF50第1期"];
        UILabel *trendLab = [self labelWithFontSize:9 FontColor:JF_COLOR_C frame:CGRectMake(qiquanLab.right, 0, 100, 50) Text:@"期权看涨"];
        [subTitleView addSubview:trendLab];
        [subTitleView addSubview:qiquanLab];
        
        [view addSubview:subTitleView];
        
        UILabel *leftMidLab = [self labelWithFontSize:32 FontColor:JF_COLOR_A frame:CGRectMake(20, 20, 60, 0) Text:@"8%"];
        [leftMidLab sizeToFit];
        leftMidLab.top = subTitleView.bottom + 10;
        [view addSubview:leftMidLab];
        
        UILabel *subNumLab = [self labelWithFontSize:18 FontColor:JF_COLOR_B frame:CGRectMake(0, 0,50, 14) Text:@"+18%"];
        UILabel *subNumTextLab = [self labelWithFontSize:12 FontColor:JF_COLOR_C frame:CGRectMake(0, subNumLab.bottom + 10, 50, 14) Text:@"浮动最高"];
        UIView *subNumView = [[UIView alloc] initWithFrame:CGRectMake(leftMidLab.right + 5, 0, 50, 40)];
        [subNumView addSubview:subNumLab];
        [subNumView addSubview:subNumTextLab];
        subNumView.centerY = leftMidLab.centerY;
        [view addSubview:subNumView];
        
        UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(subNumView.right + 20, 10, 1, 40)];
        vline.backgroundColor = kLineColor;
        vline.centerY = subNumView.centerY;
        [view addSubview:vline];
        
        
        UILabel *dayLab = [self labelWithFontSize:16 FontColor:JF_COLOR_B frame:CGRectMake(vline.right + 20, subNumView.top, 200, 16) Text:@"封闭期1000天"];
        [view addSubview:dayLab];
        UILabel *statueLab = [self labelWithFontSize:14 FontColor:JF_COLOR_A frame:CGRectMake(vline.right + 20, dayLab.bottom + 10, 146/2, 14) Text:@"还有机会"];
        
        [view addSubview:statueLab];
        UIView *vline_2 = [[UIView alloc] initWithFrame:CGRectMake(vline.right + 157/2, 10, 1, 12)];
        vline_2.backgroundColor = kLineColor;
        vline_2.centerY = statueLab.centerY;
        [view addSubview:vline_2];
        
        UILabel *beginMoneyLab = [self labelWithFontSize:14 FontColor:JF_COLOR_C frame:CGRectMake(vline_2.right + 5, statueLab.top, 150, 14) Text:@"100000元起投"];
        [view addSubview:beginMoneyLab];
        
        //进度条
        UIView *progressLine = [[UIView alloc] initWithFrame:CGRectMake(20, vline.bottom + 30, SCREEN_WIDTH - 40 - 35, 3)];
        progressLine.backgroundColor = JF_COLOR_A;
        [view addSubview:progressLine];
        
        //进度
        UILabel *proLab = [self labelWithFontSize:12 FontColor:JF_COLOR_C frame:CGRectMake(progressLine.right + 5, 0, 35, 12) Text:@"100%"];
        proLab.centerY = progressLine.centerY;
        [view addSubview:proLab];
        
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

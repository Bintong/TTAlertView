//
//  JFNetLoanCell.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFNetLoanCell.h"

@implementation JFNetLoanCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"JFNetLoanCell";
    
    JFNetLoanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
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
        
        UIView *view = self.contentView;
        [view bottomLineX:20 width:SCREEN_WIDTH color:kLineColor];
        //header
        UIView *subTitleView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 55)];
        UILabel *qiquanLab = [self labelWithFontSize:14 FontColor:JF_COLOR_C frame:CGRectMake(20, 0, 120, 55) Text:@"季账户-9个月"];
        [subTitleView addSubview:qiquanLab];
        
        [view addSubview:subTitleView];
        
        UILabel *leftMidLab = [self labelWithFontSize:20 FontColor:JF_COLOR_A frame:CGRectMake(20, 20, 70, 0) Text:@"8.5%"];
        [leftMidLab sizeToFit];
        leftMidLab.top = subTitleView.bottom;
        [view addSubview:leftMidLab];
        
        UILabel *subNumTextLab = [self labelWithFontSize:12 FontColor:JF_COLOR_C frame:CGRectMake(20, leftMidLab.bottom + 5, 105, 14) Text:@"期望年化回报率"];
        [view addSubview:subNumTextLab];
        
        UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(subNumTextLab.right, subTitleView.bottom, 1, 40)];
        vline.backgroundColor = kLineColor;
        [view addSubview:vline];
        
        
        UILabel *dayLab = [self labelWithFontSize:16 FontColor:JF_COLOR_B frame:CGRectMake(vline.right + 25, 0, 200, 16) Text:@"封闭期9个月"];
        dayLab.centerY = leftMidLab.centerY;
        [view addSubview:dayLab];
        UILabel *statueLab = [self labelWithFontSize:12 FontColor:JF_COLOR_C frame:CGRectMake(vline.right + 25, dayLab.bottom + 10, 146/2, 14) Text:@"100元起投"];
        
        [view addSubview:statueLab];
        UIView *vline_2 = [[UIView alloc] initWithFrame:CGRectMake(vline.right + 172/2, 10, 1, 10)];
        vline_2.backgroundColor = kLineColor;
        vline_2.centerY = statueLab.centerY;
        [view addSubview:vline_2];
        
        UILabel *browNum = [self labelWithFontSize:12 FontColor:JF_COLOR_C frame:CGRectMake(vline_2.right + 5, statueLab.top, SCREEN_WIDTH - 40 - vline_2.right - 5, 14) Text:@"已有623,3934人出借"];
        [view addSubview:browNum];
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

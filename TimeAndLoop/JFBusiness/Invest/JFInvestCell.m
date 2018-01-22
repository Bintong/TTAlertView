//
//  JFInvestCell.m
//  JiuFuWallet
//
//  Created by BinTong on 2017/11/22.
//  Copyright © 2017年 jayden. All rights reserved.
//

#import "JFInvestCell.h"

@implementation JFInvestCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"JFInvestCell";
    
    JFInvestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseId:cellID];
    }
    
    return cell;
}

+ (instancetype)cellWithTableView_JFB:(UITableView *)tableView {
    
    static NSString *cellID = @"JFInvestCell_JFB";
    
    JFInvestCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(cell == nil)
    {
        cell = [[self alloc] initWithStyleJFB:UITableViewCellStyleDefault reuseId:cellID];
    }
    
    return cell;
}


- (instancetype)initWithStyleJFB:(UITableViewCellStyle)style reuseId:(NSString *)cellID {
    if (self = [super initWithStyle:style reuseIdentifier:cellID])
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseId:(NSString *)cellID {
    
    if (self = [super initWithStyle:style reuseIdentifier:cellID])
    {
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = self.contentView;
        [view bottomLineX:20 width:SCREEN_WIDTH color:kLineColor];
     
        
        UILabel *leftMidLab = [self labelWithFontSize:20 FontColor:JF_COLOR_A frame:CGRectMake(20, 20, 70, 0) Text:@"8.5%"];
        [leftMidLab sizeToFit];
        leftMidLab.top = 25;
        [view addSubview:leftMidLab];
        
        UILabel *subNumTextLab = [self labelWithFontSize:12 FontColor:JF_COLOR_D frame:CGRectMake(20, leftMidLab.bottom + 5, 105, 14) Text:@"期望年化回报率"];
        [view addSubview:subNumTextLab];
        
        UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(subNumTextLab.right, 33, 1, 40)];
        vline.backgroundColor = kLineColor;
        [view addSubview:vline];
        
        
        UILabel *dayLab = [self labelWithFontSize:16 FontColor:JF_COLOR_B frame:CGRectMake(vline.right + 25, 0, 200, 16) Text:@"日账户"];
        dayLab.centerY = leftMidLab.centerY;
        [view addSubview:dayLab];
        UILabel *statueLab = [self labelWithFontSize:12 FontColor:JF_COLOR_D frame:CGRectMake(vline.right + 25, dayLab.bottom + 10, 146/2, 14) Text:@"灵活存取"];
        [statueLab sizeToFit];
        statueLab.centerY = subNumTextLab.centerY;
        statueLab.left = dayLab.left;
        [view addSubview:statueLab];
        
        UIView *vline_2 = [[UIView alloc] initWithFrame:CGRectMake(statueLab.right + 5, 10, 1, 10)];
        vline_2.backgroundColor = kLineColor;
        vline_2.centerY = statueLab.centerY;
        [view addSubview:vline_2];
        
        UILabel *browNum = [self labelWithFontSize:12 FontColor:JF_COLOR_D frame:CGRectMake(vline_2.right + 5, statueLab.top, SCREEN_WIDTH - 40 - vline_2.right - 5, 14) Text:@"已有623,3934人出借"];
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

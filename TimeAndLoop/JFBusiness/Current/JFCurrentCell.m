//
//  JFCurrentCell.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/29.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFCurrentCell.h"

@implementation JFCurrentCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"JFCurrentCell";
    
    JFCurrentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
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
       
        UILabel *num = [self labelWithFontSize:28 FontColor:JF_COLOR_A frame:CGRectMake(0, 30, SCREEN_WIDTH, 28) Text:@"5.18%"];
        [view addSubview:num];
        UILabel * subtitle = [self labelWithFontSize:14 FontColor:JF_COLOR_C frame:CGRectMake(0, num.bottom + 5, SCREEN_WIDTH, 14) Text:@"七日年化收益率"];
        [view addSubview:subtitle];
        UIView *tipView = [[UIView alloc]initWithFrame:CGRectMake(0, subtitle.bottom + 25, SCREEN_WIDTH, 12)];
        UILabel *leftLab = [self labelWithFontSize:12 FontColor:JF_COLOR_B frame:CGRectMake(0, 0, SCREEN_WIDTH/2 - 6, 12) Text:@"灵活存取"];
        leftLab.textAlignment = NSTextAlignmentRight;
        [tipView addSubview:leftLab];
        UIView *vline = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, 1, 12)];
        vline.backgroundColor = kLineColor;
        [tipView addSubview:vline];
        UILabel *rightLab = [self labelWithFontSize:12 FontColor:JF_COLOR_B frame:CGRectMake(vline.right + 6, 0, SCREEN_WIDTH/2 - 6, 12) Text:@"收益率高"];
        rightLab.textAlignment = NSTextAlignmentLeft;
        [tipView addSubview:rightLab];
        [view addSubview:tipView];
        
        
        UIButton *investBt = [self createButtonTitle:@"立即投资" Frame:CGRectMake((SCREEN_WIDTH -  140)/2, tipView.bottom + 17, 140, 36) SEL:nil];
        investBt.layer.cornerRadius = 18;
        [view addSubview:investBt];
        
        
        
    }
    
    return self;
}


- (UIButton *)createButtonTitle:(NSString *)title Frame:(CGRect)frame SEL:(SEL)selector {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    if(title){ [bt setTitle:title forState:UIControlStateNormal];}
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt setBackgroundColor:JF_COLOR_A];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    if (selector) {[bt addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];}
    return bt;
}

- (UILabel *)labelWithFontSize:(CGFloat)fontSize FontColor:(UIColor *)fontColor  frame:(CGRect)frame Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.text = text;
    return lbTitle;
}

@end

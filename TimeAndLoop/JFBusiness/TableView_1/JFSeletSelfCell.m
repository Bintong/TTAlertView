//
//  JFSeletSelfCell.m
//  TimeAndLoop
//
//  Created by BinTong on 2018/2/7.
//  Copyright © 2018年 TongBin. All rights reserved.
//

#import "JFSeletSelfCell.h"

@implementation JFSeletSelfCell

- (void)setItemModel:(id)itemModel {
    //set data
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    
    BOOL lastRow = indexPath.row == ([tableView numberOfRowsInSection:indexPath.section] - 1);

    static NSString *cellID = @"JFSeletSelfCell";
    
    JFSeletSelfCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
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
        UILabel *titlelabe = [self labelWithFontSize:14 FontColor:JF_COLOR_B frame:CGRectMake(20,23 , 122, 14) Text:@"国泰互联网"];
        titlelabe.textAlignment = NSTextAlignmentLeft;
        [view addSubview:titlelabe];
        UILabel *subtitlelabe = [self labelWithFontSize:12 FontColor:JF_COLOR_C frame:CGRectMake(20,titlelabe.bottom + 12 , 122, 12) Text:@"5980000"];
        subtitlelabe.textAlignment = NSTextAlignmentLeft;
        [view addSubview:subtitlelabe];
        
        UILabel *perLab = [self labelWithFontSize:14 FontColor:JF_COLOR_B frame:CGRectMake(titlelabe.right + 50, titlelabe.top, 65, 14) Text:@"+21.5%"];
        perLab.textAlignment = NSTextAlignmentLeft;
        [view addSubview:perLab];
        UILabel *subPerlab = [self labelWithFontSize:12 FontColor:JF_COLOR_C frame:CGRectMake(perLab.left, subtitlelabe.top, 155/2, 12) Text:@"2017-12-09"];
        subPerlab.centerX = perLab.centerX;
        [view addSubview:subPerlab];
        
        UILabel *endPrice = [self labelWithFontSize:14 FontColor:JF_COLOR_B frame:CGRectMake(SCREEN_WIDTH - 20 - 50, titlelabe.top, 50, 14) Text:@"3.38888"];
        endPrice.textAlignment = NSTextAlignmentRight;
        [view addSubview:endPrice];
        UILabel *endLabPer = [self labelWithFontSize:12 FontColor:[UIColor greenColor] frame:CGRectMake(SCREEN_WIDTH - 20 - 44, 0, 44, 12) Text:@"-0.69%"];
        endLabPer.textAlignment = NSTextAlignmentRight;
        endLabPer.centerY = subPerlab.centerY;
        [view addSubview:endLabPer];
        UILabel *endDate = [self labelWithFontSize:12 FontColor:JF_COLOR_D frame:CGRectMake(endLabPer.left - 39, 0, 39, 10) Text:@"10-20"];
        endDate.textAlignment = NSTextAlignmentRight;
        endDate.centerY = endLabPer.centerY;
        [view addSubview:endDate];
        
        [view bottomLineX:20 width:SCREEN_WIDTH color:[UIColor colorHexString:@"#EBEBEB"]];
        
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

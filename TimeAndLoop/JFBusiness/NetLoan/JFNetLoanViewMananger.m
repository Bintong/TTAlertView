//
//  JFNetLoanViewMananger.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFNetLoanViewMananger.h"

@implementation JFNetLoanViewMananger

+ (JFNetLoanViewMananger *)sharedManager {
    static JFNetLoanViewMananger *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

- (UIView *)buildZqView {
    
    UIView *zhuanquView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 370/2)];
    zhuanquView.backgroundColor = [UIColor whiteColor];
    UIView *topV = [self creatTopTitleView:@"特色专区" hasMore:NO];
    
    
    
    [zhuanquView addSubview:topV];
    return zhuanquView;
}

- (UIView *)buildJxItemView {
    UIView *jingxuanView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 590/2)];
    jingxuanView.backgroundColor = [UIColor whiteColor];
    UIView *topV = [self creatTopTitleView:@"精选标" hasMore:YES];
    [jingxuanView addSubview:topV];

    UIView *cell_1 = [self createJxItemCellView];
    cell_1.top = topV.bottom;
    [cell_1 bottomLineX:20 width:SCREEN_WIDTH color:kLineColor];
    [jingxuanView addSubview:cell_1];
    
    UIView *cell_2 = [self createJxItemCellView];
    cell_2.top = cell_1.bottom;
    [jingxuanView addSubview:cell_2];
    return jingxuanView;
}

- (UIView *)buildZrView {
    UIView *zhuanrangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 590/2)];
    zhuanrangView.backgroundColor = [UIColor whiteColor];
    UIView *topV = [self creatTopTitleView:@"转让标" hasMore:YES];
    
    [zhuanrangView addSubview:topV];
    
    UIView *cell_1 = [self createJxItemCellView];
    cell_1.top = topV.bottom;
    [cell_1 bottomLineX:20 width:SCREEN_WIDTH color:kLineColor];
    [zhuanrangView addSubview:cell_1];
    
    UIView *cell_2 = [self createJxItemCellView];
    cell_2.top = cell_1.bottom;
    [zhuanrangView addSubview:cell_2];
    return zhuanrangView;
}

- (UIView *)creatTopTitleView:(NSString *)title hasMore:(BOOL)more{
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , 45)];
    leftView.backgroundColor = [UIColor whiteColor];
    [leftView bottomLineX:0 width:SCREEN_WIDTH color:JF_COLOR_D];
    
    UILabel *titleLable = [self labelWithFontSize:14 FontColor:JF_COLOR_B frame:CGRectMake(20, 0, SCREEN_WIDTH/5, leftView.height) Text:title];
    titleLable.font = [UIFont boldSystemFontOfSize:14];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [leftView addSubview:titleLable];
    
    if (more) {
        UIButton *bt = [self createButtonTitle:@"更多 >" Frame:CGRectMake(SCREEN_WIDTH - 20 - 70, 0, 70, 45) SEL:@selector(tempPushToNetLoan:)];
        bt.titleLabel.textAlignment = NSTextAlignmentRight;
        bt.backgroundColor = [UIColor clearColor];
        [leftView addSubview:bt];
    }
    return leftView;
}


- (UIView *)createZrItemCellView {
    return [self createJxItemCellView];
}

- (UIView *)createJxItemCellView {
    UIView *cellView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250/2)];
    UILabel *itemTitleLab = [self labelWithFontSize:14 FontColor:JF_COLOR_C frame:CGRectMake(20, 0, SCREEN_WIDTH - 40, 55) Text:@"三农消费标LSBD2017082900009"];
    [cellView addSubview:itemTitleLab];
    
    UILabel *leftMidLab = [self labelWithFontSize:20 FontColor:JF_COLOR_A frame:CGRectMake(20, 20, 70, 0) Text:@"8.5%"];
    [leftMidLab sizeToFit];
    leftMidLab.top = itemTitleLab.bottom;
    [cellView addSubview:leftMidLab];
    
    UILabel *subNumTextLab = [self labelWithFontSize:12 FontColor:JF_COLOR_D frame:CGRectMake(20, leftMidLab.bottom + 5, 105, 14) Text:@"借款年化利率"];
    [cellView addSubview:subNumTextLab];
    
    UIView *vline = [[UIView alloc] initWithFrame:CGRectMake(subNumTextLab.right, itemTitleLab.bottom, 1, 40)];
    vline.backgroundColor = kLineColor;
    [cellView addSubview:vline];
    
    
    UILabel *dayLab = [self labelWithFontSize:16 FontColor:JF_COLOR_B frame:CGRectMake(vline.right + 25, 0, 200, 16) Text:@"借款合同期限12个月"];
    dayLab.centerY = leftMidLab.centerY;
    dayLab.font = [UIFont boldSystemFontOfSize:16];
    [cellView addSubview:dayLab];
    UILabel *statueLab = [self labelWithFontSize:12 FontColor:JF_COLOR_A frame:CGRectMake(vline.right + 25, dayLab.bottom + 10, 146/2, 14) Text:@"12:00开抢"];
    
    [cellView addSubview:statueLab];
    UIView *vline_2 = [[UIView alloc] initWithFrame:CGRectMake(vline.right + 172/2, 10, 1, 10)];
    vline_2.backgroundColor = kLineColor;
    vline_2.centerY = statueLab.centerY;
    [cellView addSubview:vline_2];
    
    UILabel *browNum = [self labelWithFontSize:12 FontColor:JF_COLOR_D frame:CGRectMake(vline_2.right + 5, statueLab.top, SCREEN_WIDTH - 40 - vline_2.right - 5, 14) Text:@"进度100%"];
    [cellView addSubview:browNum];
    return cellView;
}

- (void)tempPushToNetLoan:(id)sender {
    NSLog(@"more");
}




- (UIButton *)createButtonTitle:(NSString *)title Frame:(CGRect)frame SEL:(SEL)selector {
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    if(title){ [bt setTitle:title forState:UIControlStateNormal];}
    [bt setTitleColor:HB_COLOR_B forState:UIControlStateNormal];
    [bt setBackgroundColor:[UIColor whiteColor]];
    bt.titleLabel.font = [UIFont systemFontOfSize:14];
    if (selector) {[bt addTarget:[JFNetLoanViewMananger sharedManager] action:selector forControlEvents:UIControlEventTouchUpInside];}
    
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

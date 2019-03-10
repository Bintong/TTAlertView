//
//  AsyCusCell.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/8.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "AsyCusCell.h"
#import "AsyCusView.h"

#import "TBAsyView.h"
#import "TBCoreAttributedItem.h"

@interface AsyCusCell()

@property (nonatomic, strong) TBAsyView *cellLabel;

@end
@implementation AsyCusCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


+ (AsyCusCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"AsyCusCell";
    AsyCusCell *myCell = (AsyCusCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (myCell == nil) {
        myCell = [[AsyCusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    return myCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        _cellLabel = [self labelWithFontSize:14 FontColor:[UIColor redColor] frame:CGRectMake(12, 12, 200, 20) Text:@""];
        
        _cellLabel = [[TBAsyView alloc] initWithFrame:CGRectMake(12, 12, 200, 20)];
        
//        UILabel *l = [[UILabel alloc] initw]
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_cellLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _cellLabel.attributedItem = [TBCoreAttributedItem itemWithText:_cellTitleString];
//    _cellLabel.text = _cellTitleString;
//    _cellLabel.font = [UIFont systemFontOfSize:14];
//    _cellLabel.textColor = [UIColor redColor];
//    [_cellLabel setNeedsDisplay];
//    self.accessoryView.frame = CGRectMake(0, 0, kScreenWidth, self.height);
    
}

- (UILabel *)labelWithFontSize:(int)fontSize
                     FontColor:(UIColor *)fontColor
                         frame:(CGRect)frame
                          Text:(NSString *)text{
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:frame];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = [UIFont systemFontOfSize:fontSize];
    lbTitle.textColor = fontColor;
    lbTitle.textAlignment = NSTextAlignmentLeft;
    lbTitle.text = text;
    return lbTitle;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

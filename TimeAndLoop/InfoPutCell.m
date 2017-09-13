


//
//  InfoPutCell.m
//  HBankXLoan
//
//  Created by BinTong on 2016/11/21.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import "InfoPutCell.h"

@implementation InfoPutCell

- (void)refreshAccessoryView:(UIView *)newView {
    
    self.accessoryView = newView;
    
    [self setNeedsLayout];
}

+(InfoPutCell *)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index {
    static NSString *cellID = @"CardCellID";
    
    InfoPutCell *myCell = (InfoPutCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (myCell == nil) {
        myCell = [[InfoPutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    myCell.index = index;
    return myCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.accessoryView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height);
    
}

@end

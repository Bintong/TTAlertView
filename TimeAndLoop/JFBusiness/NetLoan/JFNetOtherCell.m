//
//  JFNetOtherCell.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "JFNetOtherCell.h"

@implementation JFNetOtherCell


+ (JFNetOtherCell *)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellID = @"JFNetOtherCell";
    
    JFNetOtherCell *myCell = (JFNetOtherCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (myCell == nil)
    {
        myCell = [[JFNetOtherCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return myCell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)refreshAccessoryView:(UIView *)newView {
    
    self.accessoryView = newView;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.accessoryView.frame = CGRectMake(0,0,SCREEN_WIDTH,self.height);
}

@end

//
//  JFNetOtherCell.h
//  TimeAndLoop
//
//  Created by BinTong on 2017/11/25.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFNetOtherCell : UITableViewCell

+ (JFNetOtherCell *)cellWithTableView:(UITableView *)tableView;

- (void)refreshAccessoryView:(UIView *)newView;

@end

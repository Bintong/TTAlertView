//
//  JFInvestCell.h
//  JiuFuWallet
//
//  Created by BinTong on 2017/11/22.
//  Copyright © 2017年 jayden. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFInvestCell : UITableViewCell

+ (JFInvestCell *)cellWithTableView:(UITableView *)tableView;


- (void)refreshAccessoryView:(UIView *)newView;


@end

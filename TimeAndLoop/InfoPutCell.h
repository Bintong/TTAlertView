//
//  InfoPutCell.h
//  HBankXLoan
//
//  Created by BinTong on 2016/11/21.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoPutCell : UITableViewCell

@property(nonatomic, strong)NSIndexPath *index;

+ (InfoPutCell *)cellWithTableView:(UITableView *)tableView index:(NSIndexPath *)index;

- (void)refreshAccessoryView:(UIView *)newView;

@end

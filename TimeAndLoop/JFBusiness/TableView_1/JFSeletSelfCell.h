//
//  JFSeletSelfCell.h
//  TimeAndLoop
//
//  Created by BinTong on 2018/2/7.
//  Copyright © 2018年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFSeletSelfCell : UITableViewCell

@property(nonatomic,strong)id itemModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

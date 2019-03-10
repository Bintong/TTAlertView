//
//  AsyCusCell.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/8.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyCusView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AsyCusCell : UITableViewCell

@property (nonatomic, copy) NSString *cellTitleString;


+ (AsyCusCell *)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

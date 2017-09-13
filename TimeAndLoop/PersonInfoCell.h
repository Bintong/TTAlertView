//
//  PersonInfoCell.h
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/27.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonInfoCell : UITableViewCell
@property(nonatomic, weak) id <UITextFieldDelegate> control;

- (void)buildCellContent:(NSString *)text
            andLeftTitle:(NSString *)leftTitle
               showArrow:(BOOL)showed
               indexPath:(NSIndexPath *)index;
@end

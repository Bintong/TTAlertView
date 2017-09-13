//
//  PersonInfoCell.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/27.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "PersonInfoCell.h"
#import "PersonInfoController.h"
@interface PersonInfoCell ()

@property(nonatomic, strong) UILabel *lab;
@property(nonatomic, strong) UITextField *textfield;
@property(nonatomic, strong) UIImageView *rightArrowImg;
@property(nonatomic, strong) NSIndexPath *index;
@property(nonatomic, strong) NSArray *placeHolderArray;

@end

@implementation PersonInfoCell

- (void)buildCellContent:(NSString *)text andLeftTitle:(NSString *)leftTitle showArrow:(BOOL)showed indexPath:(NSIndexPath *)index{
    self.lab.text = leftTitle;
  
    self.textfield.delegate = self.control;
    self.rightArrowImg.hidden = !showed;
    self.index = index;
   
    if (index.section == 0) {
        self.textfield.userInteractionEnabled = ((index.row == 4) || (index.row == 6));
        self.textfield.placeholder = [self.placeHolderArray objectAtIndex:index.row] ;
    }else {
        self.textfield.userInteractionEnabled = (index.row != 2);
        self.textfield.placeholder = [self.placeHolderArray objectAtIndex:index.row + 7] ;
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 44)];
        self.lab.backgroundColor = [UIColor clearColor];
        self.lab.font = [UIFont systemFontOfSize:14];
        self.lab.textColor = HB_COLOR_B;
        self.lab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.lab];
        
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(self.lab.right + 5,0,SCREEN_WIDTH - 40 - 5 - self.lab.width,44)];
        [self.textfield setBorderStyle:UITextBorderStyleNone];
        self.textfield.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textfield.returnKeyType = UIReturnKeyDone;
        self.textfield.keyboardType = UIKeyboardTypeDefault;
        self.textfield.font = [UIFont systemFontOfSize:14];
        self.textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.textfield.tag = self.index.row *100;
        [self.contentView addSubview:self.textfield];
        
        UIImageView *rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 12 , 10, 20)];
        rightArrow.image = [UIImage imageNamed:@"arrow"];
        self.rightArrowImg = rightArrow;
        [self.contentView addSubview:rightArrow];
        
        self.placeHolderArray = @[@"请输入婚姻状况",@"请输入所在省份",@"请输入所在城市",@"请输入所在区",@"街道/小区/楼号/门市号",@"请输入月收入范围",@"请输入单位名称",@"请输入联系人姓名",@"请输入联系人手机号",@"配偶"];
        
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

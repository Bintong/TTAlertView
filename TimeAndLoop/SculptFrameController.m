//
//  SculptFrameController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/28.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "SculptFrameController.h"
#import "SCTextAttachment.h"
#import "SculptItem.h"
#import "NSAttributedString+tb_async.h"


@interface SculptFrameController ()

@end

@implementation SculptFrameController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    
    SculptItem *textItem = [SculptItem itemWithText:@"hello world"];

    [textItem setFont:[UIFont systemFontOfSize:12]];
    [textItem setColor:[UIColor redColor]];
    
    CGSize size =  [textItem.resultString tb_sizeConstrainedToWidth:self.view.frame.size.width - 20];
    
    //layout 包装一下没给组件
    
    

    
    
    
    
//    WMMutableAttributedItem *name = [WMMutableAttributedItem itemWithText:poi.name];
//    [name setFont:[UIFont systemFontOfSize:16]];
//    [name setColor:WMGHEXCOLOR(0x33312D)];
//
//    size = [name.resultString wmg_sizeConstrainedToWidth:(spaceXEnd - spaceXStart) numberOfLines:1];
//    cellData.nameObj.frame = CGRectMake(spaceXStart, spaceYStart, size.width, size.height);
//    cellData.nameObj.value = name.resultString;
//    spaceYStart += size.height;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

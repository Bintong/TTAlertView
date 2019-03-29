//
//  SculptSysController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "SculptSysController.h"
#import "UIView+Frame.h"
#import "CTDisplayView.h"
#import "CTFrameParserConfig.h"
#import "CTFrameParser.h"
#import "CoreTextData.h"


//other style
#import "TTObjLabel.h"
@interface SculptSysController ()

@end

@implementation SculptSysController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建画布
//    CTDisplayView *dispaleView = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
//    dispaleView.center = CGPointMake(self.view.center.x, self.view.center.y-120);
//    dispaleView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:dispaleView];
    
    //设置配置信息
//    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
//    config.textColor = [UIColor redColor];
//    config.width = dispaleView.width;
    /*
    //设置内容
    NSString *content =  @"CoreText是用于处理文字和字体的底层技术。"
    "它直接和Core Graphics(又被称为Quartz)打交道。"
    "Quartz是一个2D图形渲染引擎，能够处理OSX和iOS中图形显示问题。"
    "Quartz能够直接处理字体（font）和字形（glyphs），将文字渲染到界面上，它是基础库中唯一能够处理字形的模块。"
    "因此CoreText为了排版，需要将显示的文字内容、位置、字体、字形直接传递给Quartz。"
    "与其他UI组件相比，由于CoreText直接和Quartz来交互，所以它具有更高效的排版功能。";

    //设置富文本
    NSDictionary *attr = [CTFrameParser attributesWithConfig:config];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:content attributes:attr];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:26] range:NSMakeRange(0, 15)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 15)];
  
    //创建绘制数据实例
    CoreTextData *data = [CTFrameParser parseAttributedContent:attributeString config:config];
    */
    
    
    /*
    //获取模板文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"JsonTemplate" ofType:@"json"];
    //创建绘制数据实例
    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
    dispaleView.data = data;
    dispaleView.height = data.height;
    dispaleView.backgroundColor = [UIColor yellowColor];
    */
    
    [self loadOtherStyle];
    
 
}


- (void)loadOtherStyle {
    
    CTDisplayView *dispaleView = [[CTDisplayView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    dispaleView.center = CGPointMake(self.view.center.x, self.view.center.y-120);
    dispaleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:dispaleView];
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor redColor];
    config.width = dispaleView.width;
    
    
    TTObjLabel *label = [[TTObjLabel alloc] init];
    label.tt_text = @"hello world";
    label.tt_font_size = 14;
    label.tt_color = [UIColor redColor];
    [label drawAtView];
    
    CoreTextData *data = [CTFrameParser parseAttributedContent:label.tt_attribute config:config];

    dispaleView.data = data;
    
    
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

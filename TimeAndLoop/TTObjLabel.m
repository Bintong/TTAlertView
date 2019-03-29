//
//  TTObjLabel.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/29.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TTObjLabel.h"

@interface TTObjLabel()
//"color":"blue",
//"content":"Quartz能够直接处理字体（font）和字形（glyphs），将文字渲染到界面上，它是基础库中唯一能够处理字形的模块。",
//"size":16,
//"type":"txt"
@property (strong, nonatomic) NSMutableDictionary *dic;
@property (strong, nonatomic) NSMutableDictionary *attributTextDic;



@end

@implementation TTObjLabel

- (id)init {
    self = [super init];
    if (self) {
        _dic = [NSMutableDictionary dictionary];
        _attributTextDic = [NSMutableDictionary dictionary];
        [_dic setObject:@"txt" forKey:@"type"];
    }
    return self;
}

- (void)setTt_font_size:(CGFloat)tt_font_size {
    [_dic setObject:@(tt_font_size) forKey:@"size"];
    //
    [_attributTextDic setObject:[UIFont systemFontOfSize:tt_font_size] forKey:NSFontAttributeName];
}


- (void)setTt_color:(UIColor *)tt_color {
    [_dic setObject:tt_color forKey:@"color"];
    [_attributTextDic setObject:tt_color forKey:NSForegroundColorAttributeName];
}

- (void)setTt_text:(NSString *)tt_text {
    _tt_text = tt_text;
    [_dic setObject:tt_text forKey:@"content"];
    _tt_attribute = [[NSMutableAttributedString alloc] initWithString:tt_text];
    
}


- (void)setTt_attribute:(NSAttributedString *)tt_attribute {
    
}

- (NSAttributedString *)combinationLabelAttributString:(NSString *)text fontSize:(CGFloat)font color:(UIColor *)color {
    
    

    return nil;
}

- (void)drawAtView {
    [self.tt_attribute addAttributes:self.attributTextDic range:NSMakeRange(0, self.tt_text.length)];
}

@end

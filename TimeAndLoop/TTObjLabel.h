//
//  TTObjLabel.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/29.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTFrameParserConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTObjLabel : NSObject

@property (nonatomic, copy) NSString *tt_text;
@property (nonatomic, assign) CGFloat tt_font_size;
@property (nonatomic, strong) UIColor *tt_color;
//finially attributeString
@property (nonatomic, strong) NSMutableAttributedString *tt_attribute;

- (void)synthesisAttributString;

- (NSAttributedString *)combinationLabelAttributString:(NSString *)text fontSize:(CGFloat)font color:(UIColor *)color;


- (NSAttributedString *)companionWithAttribute:(NSAttributedString *)attribute config:(CTFrameParserConfig *)config;

@end

NS_ASSUME_NONNULL_END

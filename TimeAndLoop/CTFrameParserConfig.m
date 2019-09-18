//
//  CTFrameParserConfig.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "CTFrameParserConfig.h"

@implementation CTFrameParserConfig

-(instancetype)init{
    self = [super init];
    if (self) {
        _width = 200.f;
        _fontSize = 16.0f;
        _lineSpace = 3.0f;
        _paragraphSpace = 10.0f;
        _textColor = [UIColor redColor];
        _headIndent = 15;
        _leftIndent = 15;
        _tailIndent = 15;
    }
    return self;
}

@end


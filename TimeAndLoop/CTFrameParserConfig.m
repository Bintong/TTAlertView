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
        _lineSpace = 8.0f;
        _textColor = [UIColor redColor];
    }
    return self;
}

@end


//
//  TTObjImageLabel.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/31.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TTObjImageLabel.h"
#import "CoreTextImageData.h"
#import "CTFrameParser.h"


@interface TTObjImageLabel()
//,{
//    "name":"image-1.jpg",
//    "width":200,
//    "height":108,
//    "type":"img"
//},
@property (strong, nonatomic) NSMutableDictionary *dic;
@property (strong, nonatomic) NSMutableDictionary *attributedic;
@property (strong,nonatomic) NSMutableArray *coreImgs;
@end

@implementation TTObjImageLabel

- (id)init {
    self = [super init];
    if (self) {
        _dic = [NSMutableDictionary dictionary];
        _coreImgs = [NSMutableArray array];
        [_dic setObject:@"img" forKey:@"type"];
    }
    return self;
}

- (void)setTt_width:(CGFloat)width {
    [_dic setObject:@(width) forKey:@"width"];
    _tt_width = width;
}

- (void)setTt_height:(CGFloat)height{
    [_dic setObject:@(height) forKey:@"height"];
    _tt_height = height;
}

- (void)setImageName:(NSString *)imageName {
    [_dic setObject:imageName forKey:@"name"];
    _imageName = imageName;
}


- (NSAttributedString *)companionWithAttribute:(NSAttributedString *)attribute config: (CTFrameParserConfig *)config {
    
    CoreTextImageData *imageData = [[CoreTextImageData alloc] init];
    imageData.name = _imageName;
    imageData.position = [attribute length];
    [_coreImgs addObject:imageData];
    _coreImages = [NSArray arrayWithArray:_coreImgs];
    
    
    //创建CoreTextImageData,保存图片到imageArray数组中
//    CoreTextImageData *imageData = [[CoreTextImageData alloc] init];
//    imageData.name = dict[@"name"];
//    imageData.position = [result length];
//    [imageArray addObject:imageData];
//
//    //创建空白占位符，并且设置它的CTRunDelegate信息
//    NSAttributedString *as = [self parseImageDataFromNSDictionary:dict config:config];
//    [result appendAttributedString:as];
    
    //创建空白占位符，并且设置它的CTRunDelegate信息
    NSAttributedString *as = [CTFrameParser parseImageDataFromNSDictionary:_dic config:config];
    
    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] init];
    [temp appendAttributedString:attribute];
    [temp appendAttributedString:as];
    return temp;
}


@end

//
//  SculptItem.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/12.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "SculptItem.h"
#import "SCTextAttachment.h"
#import <CoreText/CoreText.h>

@interface SculptItem (){
    
    struct {
        unsigned int needsRebuild:1;
    } _flags;
    
    NSMutableAttributedString *_textStorage;
}

@property (nonatomic, strong, readwrite) NSMutableAttributedString *resultString;
@property (nonatomic, strong) NSMutableArray <SCTextAttachment *> *arrayAttachments;

@end

@implementation SculptItem

- (id)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _textStorage = [[NSMutableAttributedString alloc] initWithString:text];
        [_textStorage  addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, text.length)];
        [_textStorage  addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, text.length)];
        
        _resultString = nil;
        _flags.needsRebuild = YES;
        _arrayAttachments = [NSMutableArray array];
    }
    return self;
}

- (NSAttributedString *)resultString {
    [self rebuildIfNeeded];
    return _resultString;
}

+ (instancetype)itemWithText:(nullable NSString *)text {
    SculptItem *item = [[SculptItem alloc] initWithText:text];
    return item;
}

+ (instancetype)itemWithImageName:(nullable NSString *)imgname {//name
    return [SculptItem itemWithImageName:imgname size:CGSizeMake(15, 15)];
}

+ (instancetype)itemWithImageName:(NSString *)imgname size:(CGSize)size {//
    SculptItem *text = [SculptItem itemWithText:nil];
    [text appendImageWithName:imgname size:size];
    return text;
}

- (SculptItem *)appendImageWithName:(NSString *)imgname size:(CGSize)size
{
    UIImage *image = [UIImage imageNamed:imgname];
    return [self appendImageWithImage:image size:size];
}

- (SculptItem *)appendImageWithImage:(UIImage *)image size:(CGSize)size
{
    SCTextAttachment *att = [SCTextAttachment textAttachmentWithContents:image type:SCGAttachmentTypeStaticImage size:size];
    
    return [self appendAttachment:att];
}

- (SculptItem *)appendText:(NSString *)text {
    SculptItem *item = [SculptItem itemWithText:text];
    for (SCTextAttachment *textAtt in item.arrayAttachments) {
        textAtt.position += _textStorage.length;
        [_arrayAttachments addObject:textAtt];
    }
    
    [_textStorage appendAttributedString:item.resultString];
    [self setNeedsRebuild];
    return self;
}

- (SculptItem *)appendAttachment:(SCTextAttachment *)att
{
    if (att.type == SCGAttachmentTypeStaticImage ||
        att.type == SCGAttachmentTypePlaceholder) {
        att.position = _textStorage.length;
        att.length = 1;
    }
    
    [self setNeedsRebuild]; // image 或者其他 是 id 类型
    NSAttributedString *str = [NSAttributedString scg_attributedStringWithTextAttachment:att];
    [_textStorage appendAttributedString:str];
    [_arrayAttachments addObject:att];
    return self;
}

- (void)setFont:(UIFont *)font {
    [self setNeedsRebuild];
    [_textStorage  addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _textStorage.length)];

}

- (void)setColor:(UIColor *)color {
    [self setNeedsRebuild];
    [_textStorage  addAttribute:NSFontAttributeName value:color range:NSMakeRange(0, _textStorage.length)];
}



- (void)setNeedsRebuild
{
    _flags.needsRebuild = YES;
}

- (SculptItem *)appendAttributedItem:(SculptItem *)item {
    if (item && item.resultString) {
        
        for (SCTextAttachment *att in item.arrayAttachments) {
            att.position += _textStorage.length;
            [_arrayAttachments addObject:att];
        }
        
        [_textStorage appendAttributedString:item.resultString];
        [self setNeedsRebuild];
    }
    return self;
}


- (void)rebuildIfNeeded {
    if (_flags.needsRebuild) {
        [self _rebuild];
    }
}

- (void)_rebuild
{
    _flags.needsRebuild = NO;
    
    if (_textStorage.length > 0  )
    {
        NSMutableAttributedString *s = [[NSMutableAttributedString alloc] initWithString:_textStorage.string];
        
        // 直接设置的字体、颜色、下划线样式
        for (NSString * key in @[(NSString *)kCTFontAttributeName,
                                 (NSString *)kCTForegroundColorAttributeName,
                                 /*(NSString *)kCTBackgroundColorAttributeName,*/
                                 (NSString *)kCTParagraphStyleAttributeName,
                                 (NSString *)kCTKernAttributeName,
                                 (NSString *)kCTUnderlineStyleAttributeName,
                                 (NSString *)kCTUnderlineColorAttributeName,
                                 (NSString *)kCTLigatureAttributeName,
                                 (NSString *)NSStrikethroughStyleAttributeName,
                                 (NSString *)NSStrikethroughColorAttributeName,
                                 (NSString *)kCTRunDelegateAttributeName,
                                 @"WMGTextAttachmentAttributeName",
//                                 WMGTextDefaultForegroundColorAttributeName,
//                                 WMGTextStrikethroughStyleAttributeName,
//                                 WMGTextStrikethroughColorAttributeName
                                 ])
        {
            [_textStorage enumerateAttribute:key inRange:NSMakeRange(0, _textStorage.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
                if (value && (range.location != NSNotFound))
                {
                    [s addAttribute:key value:value range:range];//集体的 对 attribute 进行附值// 包括图片 和文字
                }
            }];
        }
        
        
        _resultString = s;
    }
}

@end

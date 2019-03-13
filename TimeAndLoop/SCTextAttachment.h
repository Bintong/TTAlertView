//
//  SCTextAttachment.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/13.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>

// 组件插入到AttributedString中的Key标识
//extern NSString * const SCGTextAttachmentAttributeName;
//// "\uFFFC"
//extern NSString * const SCGTextAttachmentReplacementCharacter;


typedef NS_ENUM(NSInteger, SCGAttachmentType)
{
    SCGAttachmentTypeStaticImage  = 0,
    SCGAttachmentTypePlaceholder  = 1,
    
    SCGAttachmentTypeApplicationReserved = 0xF000,
};

@interface SCTextAttachment : NSObject

/**
 *  构建一个文本组件的类方法
 *
 * @param contents  文本组件表达的内容、样式
 * @param type 文本组件类型
 * @param size  该组件占用大小
 *
 */
+ (instancetype)textAttachmentWithContents:(nullable id)contents type:(SCGAttachmentType)type size:(CGSize)size;

// 我们需要给每个文本组件设定对应的FontMetrics，默认为YES。框架会自动获取各个插入组件的Metrics信息
@property (nonatomic, assign) BOOL retriveFontMetricsAutomatically;

// 框架内部会在合适时机设置文本组件的展示Frame，注意！我们不需要指定该值~
@property (nonatomic, assign) CGRect layoutFrame;


// 定义组件类型，一般文本中插入的图片被标记为WMGAttachmentTypeStaticImage
@property (nonatomic) SCGAttachmentType type;

// 指定组件以size大小展示
@property (nonatomic) CGSize size;

// 组件和四周的edgeInsets
@property (nonatomic) UIEdgeInsets edgeInsets;

// 组件展示相关的数据 一般为 NSString*、UIImage、WMGImage
// 分别对应图片名称（或者是一组文本）、本地图片、网络下载图片
@property (nonatomic, strong, nullable) id contents;

// 指定组件在AttributedString中的位置和长度，对于图片组件而言，由于是用\ufffc表达，所以长度为1。
@property (nonatomic, assign) NSUInteger position;
@property (nonatomic, assign) NSUInteger length;



@end




// AttributedString的文本组件分类
@interface NSAttributedString (GTextAttachment)

/**
 *  遍历AttributedString中的所有文本组件
 *
 * @param block 参数1 attachment 文本组件对象 参数2 range 该文本组件处于AtrributedString中的Range
 *
 */
- (void)scg_enumerateTextAttachmentsWithBlock:(nullable void (^)(SCTextAttachment *attachment, NSRange range, BOOL *stop))block;

/**
 *  遍历AttributedString中的所有文本组件
 *
 * @param options 遍历选项
 * @param block 参数1 attachment 文本组件对象 参数2 range 该文本组件处于AtrributedString中的Range
 *
 */
- (void)scg_enumerateTextAttachmentsWithOptions:(NSAttributedStringEnumerationOptions)options block:(nullable void (^)(SCTextAttachment *attachment, NSRange range, BOOL *stop))block;

/**
 *  根据文本组件创建一个对应的AttributedString
 *
 * @param attachment 文本组件
 *
 */
+ (instancetype)scg_attributedStringWithTextAttachment:(SCTextAttachment *)attachment;

/**
 *  根据文本组件创建一个对应的AttributedString
 *
 * @param attachment 文本组件
 * @param attributes 额外设置的属性
 *
 */
+ (instancetype)scg_attributedStringWithTextAttachment:(SCTextAttachment *)attachment attributes:(NSDictionary *)attributes;

@end

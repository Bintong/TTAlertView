//
//  SCTextAttachment.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/13.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "SCTextAttachment.h"

#import <CoreText/CoreText.h>
@implementation SCTextAttachment

+ (instancetype)textAttachmentWithContents:(nullable id)contents
                                      type:(SCGAttachmentType)type
                                      size:(CGSize)size{

    SCTextAttachment *att = [[SCTextAttachment alloc] init];
    att.contents = contents;
    att.type = type;
    att.size = size;
    
    return att;
}

@end

@implementation NSAttributedString (GTextAttachment)
//
//- (void)wmg_enumerateTextAttachmentsWithBlock:(void (^)(WMGTextAttachment *, NSRange, BOOL *))block
//{
//    [self wmg_enumerateTextAttachmentsWithOptions:0 block:block];
//}
//
//- (void)wmg_enumerateTextAttachmentsWithOptions:(NSAttributedStringEnumerationOptions)options block:(void (^)(WMGTextAttachment *, NSRange, BOOL *))block
//{
//    if (!block) return;
//
//    [self enumerateAttribute:WMGTextAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:options usingBlock:^(WMGTextAttachment * attachment, NSRange range, BOOL *stop) {
//        if (attachment && [attachment isKindOfClass:[WMGTextAttachment class]]) {
//            block(attachment, range, stop);
//        }
//    }];
//}

+ (instancetype)scg_attributedStringWithTextAttachment:(SCTextAttachment *)attachment
{
    return [self scg_attributedStringWithTextAttachment:attachment attributes:@{}];
}

+ (instancetype)scg_attributedStringWithTextAttachment:(SCTextAttachment *)attachment
                                            attributes:(NSDictionary *)attributes
{
    // Core Text 通过runDelegate确定非文字（attachment）区域的大小
    CTRunDelegateCallbacks callback;
    callback.version = kCTRunDelegateCurrentVersion;
    callback.dealloc = deallocCallback;
    callback.getWidth = getWidthCallback;
    callback.getAscent = getAscentCallback; //上航高度
    callback.getDescent = getDecentCallback; //下行高
    NSDictionary *ref = @{@"width":@100,
                          @"ascent":@10,
                          @"decent":@10,};
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&callback, (__bridge_retained void *)ref);
//    [attrStr addAttribute:(id)kCTRunDelegateAttributeName
//                    value:(__bridge id)runDelegate
//                    range:NSMakeRange(0, 1)];
    
    // 设置CTRunDelegateRef 和 文本颜色， 由于占位的“*”不需要显示，故设为透明色
    NSMutableDictionary *placeholderAttributes = [NSMutableDictionary dictionaryWithDictionary:attributes];
    
    [placeholderAttributes addEntriesFromDictionary:[NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)runDelegate,
                                                     (NSString*)kCTRunDelegateAttributeName,
                                                     [UIColor clearColor].CGColor,
                                                     (NSString*)kCTForegroundColorAttributeName,
                                                     attachment,
                                                     @"SCGTextAttachmentAttributeName",
                                                     nil]];
    CFRelease(runDelegate);
    
    // 所有表情文本（如“[哈哈]”）替换为一个占位符，并通过CTRunDelegateRef控制大小
    NSString *str = @"\uFFFC";
    NSAttributedString *result = [[[self class] alloc] initWithString:str attributes:placeholderAttributes];
    
    return result;
}



static void deallocCallback (void *ref) {
    NSDictionary *dic = (__bridge_transfer NSDictionary *)(ref);
    dic = nil;
}

static CGFloat getAscentCallback (void *ref) {
    NSDictionary *dic = (__bridge NSDictionary *)ref;
    return [dic[@"ascent"] floatValue];
}

static CGFloat getDecentCallback (void *ref) {
    NSDictionary *dic = (__bridge NSDictionary *)ref;
    return [dic[@"decent"] floatValue];
}

static CGFloat getWidthCallback (void *ref) {
    NSDictionary *dic = (__bridge NSDictionary *)ref;
    return [dic[@"width"] floatValue];
}


//CGFloat scg_embeddedObjectGetWidthCallback(void* context)
//{
////    SCGAttachment  delegate  not in .h file
//    if ([(__bridge id)context conformsToProtocol:@protocol(SCGAttachment)])
//    {
//        return [(__bridge id <SCGAttachment>)context placeholderSize].width;
//    }
//    return 25;
//}


@end

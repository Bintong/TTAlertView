//
//  CTFrameParser.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/18.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "CTFrameParser.h"
#import "CTFrameParserConfig.h"
#import "CoreTextData.h"
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"


@implementation CTFrameParser
 

+(UIColor *)colorFromTemplate:(NSString *)name{
    
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }else if ([name isEqualToString:@"red"]){
        return [UIColor redColor];
    }else if ([name isEqualToString:@"black"]){
        return [UIColor blackColor];
    }else{
        return nil;
    }
}


//特色处理 txt
+(NSAttributedString *)parseAttributeContentFromNSDictionary:(NSDictionary*)dict config:(CTFrameParserConfig *)config{
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesWithConfig:config]];
    
    //设置颜色
    UIColor *color = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    
    //设置字号
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize>0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    
    NSString *content = dict[@"content"];//attributes 获取全局后-局部更改
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}

//特色处理 subtitle
+(NSAttributedString *)parseSubTitleAttributeContentFromNSDictionary:(NSDictionary*)dict config:(CTFrameParserConfig *)config{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesWithConfig:config]];
    
    //设置颜色
    UIColor *color = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    //bold
    BOOL bold = [dict[@"bold"] boolValue];
    //设置字号
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize>0) {
        CTFontRef fontRef = CTFontCreateWithName(bold? (CFStringRef)@"Helvetica-Bold":(CFStringRef)@"Helvetic", fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    //行间距
    CGFloat lineSpace = [dict[@"linespace"] floatValue];
    if (lineSpace > 0) {
        
    }
    CGFloat paragraphSpace = [dict[@"paragraphSpace"] floatValue];
    if (paragraphSpace > 0) {
        
        CGFloat lineSpcing = [dict[@"linespace"] floatValue]? [dict[@"linespace"] floatValue] : 3;//config.lineSpace;
        CGFloat para_space = paragraphSpace;
        CGFloat headIndent = config.headIndent;
        CGFloat firstIndent = config.leftIndent;
        
        CGFloat tailIndent = SCREEN_WIDTH - config.tailIndent;
        const CFIndex kNumberOfSettings = 7;
        CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
            {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpcing},
            
            {kCTParagraphStyleSpecifierParagraphSpacingBefore,sizeof(CGFloat),&para_space},
            {kCTParagraphStyleSpecifierHeadIndent,sizeof(CGFloat),&headIndent},//首行 头部孔隙 缩紧 ----
            {kCTParagraphStyleSpecifierFirstLineHeadIndent,sizeof(CGFloat),&firstIndent},//头行-------
            {kCTParagraphStyleSpecifierTailIndent,sizeof(CGFloat), &tailIndent}//宽度
            
        };
        
        CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
        attributes[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;

        CFRelease(theParagraphRef);
    }
    NSString *content = dict[@"content"];
     //attributes 获取全局后-局部更改
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}



//图片
+(NSAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict config:(CTFrameParserConfig *)config {
    //    {
    //        height = 108;
    //        name = "image-2.jpg";
    //        type = img;
    //        width = 200;
    //    }
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)dict);//call back
    
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSString *p_label_content = [NSString stringWithFormat:@"%@ \n",content];
    
    NSDictionary *attributes = [self attributes_ImageViewDictionary:dict config:config]; //;//获得文本整体的风格字典，比如行间距，字体大小之类的信息。
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:p_label_content attributes:attributes];
    
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return space;
}

+(NSAttributedString *)loadTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config  imageArray:(NSMutableArray *)imageArray linkArray:(NSMutableArray *)linkArray{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    if (data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in array) {
                NSString *type = dict[@"type"];
                if ([type isEqualToString:@"txt"]) {
                    NSAttributedString *as = [self parseAttributeContentFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                }else if ([type isEqualToString:@"sub_title"]){
                    NSAttributedString *as = [self parseSubTitleAttributeContentFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                }else if([type isEqualToString:@"title"]){
                    NSAttributedString *as = [self parseSubTitleAttributeContentFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                } else if ([type isEqualToString:@"img"]){
                    
                    //创建CoreTextImageData,保存图片到imageArray数组中
                    CoreTextImageData *imageData = [[CoreTextImageData alloc] init];
                    imageData.name = dict[@"name"];
                    imageData.position = [result length];
                    [imageArray addObject:imageData];
                    
                    //创建空白占位符，并且设置它的CTRunDelegate信息
                    NSAttributedString *as = [self parseImageDataFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                } else if ([type isEqualToString:@"link"]){
                    
                    NSUInteger startPos = result.length;
                    NSAttributedString *as = [self parseAttributeContentFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                    
                    //创建CoreTextLinkData
                    NSUInteger length = result.length - startPos;
                    NSRange linkRange = NSMakeRange(startPos, length);
                    CoreTextLinkData *linkData = [[CoreTextLinkData alloc] init];
                    linkData.title = dict[@"content"];
                    linkData.url   = dict[@"url"];
                    linkData.range = linkRange;
                    [linkArray addObject:linkData];
                }
             
            }
        }
    }
    return  result;
}
#pragma mark - 添加设置CTRunDelegate信息的方法
static CGFloat ascentCallback(void *ref){
    
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}
static CGFloat descentCallback(void *ref){
    
    return 0;
}
static CGFloat widthCallback(void *ref){
    
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}



//image 方法一：用于提供对外的接口，调用方法二实现从一个JSON的模板文件中读取内容，然后调用方法五生成的CoreTextData
+(CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config{
    NSMutableArray *imageArray = [NSMutableArray array];
    NSMutableArray *linkArray  = [NSMutableArray array];

    NSAttributedString *content = [self loadTemplateFile:path config:config imageArray:imageArray linkArray:linkArray];
    CoreTextData *data = [self parseAttributedContent:content config:config];// get imagearray  and link array
    data.imageArray = imageArray; //image 的set 方法
    data.linkArray = linkArray;
    return data;
//    return [self parseAttributedContent:content config:config];
}

+ (CoreTextData *)pareseAttributedContents:(NSAttributedString *)content imgs:(NSArray *)images config:(CTFrameParserConfig *)config{
    CoreTextData *data = [self parseAttributedContent:content config:config];// get imagearray  and link array
    data.imageArray = images;
    
    return data;
}



//content string
+(CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config {
    //创建CTFrameStterRef实例 //A reference to a Core Foundation framesetter object.
    // will call back image cfrundelegate
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    //获得要绘制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    //生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    //将生成好的CTFrameRef实例和计算好的绘制高度保存到CoreTextData实例中，最后返回CoreTextData实例
    CoreTextData *data = [[CoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    //这个后边在外部跟随着 image 的
    
    //释放内存
    CFRelease(framesetter);
    CFRelease(frame);
    
    return data;
}

//给内容设置配置信息
+(CoreTextData *)parseContent:(NSString *)content config:(CTFrameParserConfig *)config{
    
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *contextString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    //创建CTFrameStterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)contextString);
    
    //获得要绘制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    //生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    //将生成好的CTFrameRef实例和计算好的绘制高度保存到CoreTextData实例中，最后返回CoreTextData实例
    CoreTextData *data = [[CoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    
    //释放内存
    CFRelease(framesetter);
    CFRelease(frame);
    
    return data;
}


//配置信息格式化
+(NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config{
    
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpcing = config.lineSpace;
    CGFloat para_space = config.paragraphSpace;
    CGFloat headIndent = config.headIndent;
    CGFloat firstIndent = config.leftIndent;
    
    CGFloat tailIndent = SCREEN_WIDTH - config.tailIndent;
    const CFIndex kNumberOfSettings = 7;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpcing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpcing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpcing},
        {kCTParagraphStyleSpecifierParagraphSpacingBefore,sizeof(CGFloat),&para_space},
        {kCTParagraphStyleSpecifierHeadIndent,sizeof(CGFloat),&headIndent},//首行 头部孔隙 缩紧 ----
        {kCTParagraphStyleSpecifierFirstLineHeadIndent,sizeof(CGFloat),&firstIndent},//头行-------
        {kCTParagraphStyleSpecifierTailIndent,sizeof(CGFloat), &tailIndent}//宽度

    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(fontRef);
    CFRelease(theParagraphRef);
    return dict;
}


+(NSDictionary *)attributes_ImageViewDictionary:(NSDictionary *)imageInfo config:(CTFrameParserConfig *)config{
    
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpcing = config.lineSpace;
    CGFloat para_space = config.paragraphSpace;
    CGFloat headIndent = config.headIndent;
    CGFloat firstIndent = (SCREEN_WIDTH -  [imageInfo[@"width"] floatValue])/2;
    
    CGFloat tailIndent = SCREEN_WIDTH - config.tailIndent;
    const CFIndex kNumberOfSettings = 7;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpcing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpcing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpcing},
        {kCTParagraphStyleSpecifierParagraphSpacingBefore,sizeof(CGFloat),&para_space},
        {kCTParagraphStyleSpecifierHeadIndent,sizeof(CGFloat),&headIndent},
        {kCTParagraphStyleSpecifierFirstLineHeadIndent,sizeof(CGFloat),&firstIndent},
        {kCTParagraphStyleSpecifierTailIndent,sizeof(CGFloat), &tailIndent}
        
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(fontRef);
    CFRelease(theParagraphRef);
    return dict;
}

//创建CTFrameRef绘制路径实例
+(CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter config:(CTFrameParserConfig *)config height:(CGFloat)height{
    //创建矩形的路径 指定文字的绘制范围
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}
@end

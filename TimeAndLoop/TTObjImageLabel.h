//
//  TTObjImageLabel.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/31.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TTObjLabel.h"
#import "CTFrameParserConfig.h"
NS_ASSUME_NONNULL_BEGIN
// Sample for image and Label Layout at View
// Next detail layout Image and Label
// Finally Like Weixin Read Or Ins app So image or video at view  open and close quickly and
@interface TTObjImageLabel : NSObject

@property (copy ,nonatomic) NSString *imageName;
@property (assign ,nonatomic) CGFloat tt_width;
@property (assign ,nonatomic) CGFloat tt_height;


@property (strong ,nonatomic) NSArray *coreImages;

- (NSAttributedString *)companionWithAttribute:(NSAttributedString *)attribute config: (CTFrameParserConfig *)config;


@end

NS_ASSUME_NONNULL_END

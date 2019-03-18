//
//  SculptItem.h
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/12.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCTextAttachment.h"


@interface SculptItem : NSObject

@property (nonatomic, strong, readonly) NSAttributedString *resultString;

+ (instancetype)itemWithText:(nullable NSString *)text;

+ (instancetype)itemWithImageName:(nullable NSString *)imgname;

- (void)setFont:(UIFont *)font;

- (void)setColor:(UIColor *)color;

- (SculptItem *)appendText:(NSString *)text;
- (SculptItem *)appendAttributedItem:(SculptItem *)item;
- (SculptItem *)appendImageWithName:(NSString *)imgname size:(CGSize)size;


- (void)rebuildIfNeeded;

@end



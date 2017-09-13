//
//  HBCheckValid.m
//  HBankXLoan
//
//  Created by zftank on 2016/12/27.
//  Copyright © 2016年 HBankXLoan. All rights reserved.
//

#import "HBCheckValid.h"

@implementation HBCheckValid

+ (BOOL)checkStringValid:(NSString *)string {
    
    if (string && [string isKindOfClass:[NSString class]])
    {
        if (0 < string.length)
        {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)checkArrayValid:(NSArray *)array {
    
    if (array && [array isKindOfClass:[NSArray class]])
    {
        if (0 < array.count)
        {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)checkDictionaryValid:(NSDictionary *)dictionary {
    
    if (dictionary && [dictionary isKindOfClass:[NSDictionary class]])
    {
        if (0 < dictionary.count)
        {
            return YES;
        }
    }
    
    return NO;
}

@end

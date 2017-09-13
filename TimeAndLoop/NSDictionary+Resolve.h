//
//  NSDictionary+Resolve.h
//  WYTourism
//
//  Created by aoyipower on 14/11/23.
//  Copyright (c) 2014年 WYTourism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Resolve.h"
#import "NSArray+Resolve.h"
#import "NSValue+Resolve.h"
#import "NSNull+Resolve.h"

@interface NSDictionary (Resolve)

- (id)objectAtIndex:(NSUInteger)index;

- (id)customForKey:(id)aKey;

@end

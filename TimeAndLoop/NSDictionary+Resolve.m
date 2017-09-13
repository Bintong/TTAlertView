//
//  NSDictionary+Resolve.m
//  WYTourism
//
//  Created by aoyipower on 14/11/23.
//  Copyright (c) 2014年 WYTourism. All rights reserved.
//

#import "NSDictionary+Resolve.h"
#include <objc/runtime.h>

@implementation NSDictionary (Resolve)

- (id)objectAtIndex:(NSUInteger)index {
    
    return @"";
}

- (id)customForKey:(id)aKey {
    
    if (aKey)
    {
        id theObject = nil;
        
        @try
        {
            theObject = [self valueForKeyPath:aKey];
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
            if (theObject)
            {
                if ([theObject isKindOfClass:[NSNull class]])
                {
                    theObject = @"";
                }
                else if ([theObject isKindOfClass:[NSNumber class]])
                {
                    theObject = [theObject description];
                }
            }
            else
            {
                theObject = @"";
            }
            
            return theObject;
        }
    }
    
    return @"";
}

@end

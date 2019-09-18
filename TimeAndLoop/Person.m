//
//  Person.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/5/1.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation Person

-(void)eat {
    NSLog(@"eat_person");
}

+ (void)LogAllMethodsFromClass:(id)obj
{
    unsigned int methodCount;
    Method *method = class_copyMethodList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Method me = method[i];
        NSLog(@"方法名称----%@",NSStringFromSelector(method_getName(me)));
    }
    free(method);
}

@end

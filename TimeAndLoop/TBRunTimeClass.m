//
//  TBRunTimeClass.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/5/1.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TBRunTimeClass.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation TBRunTimeClass

- (void)swizzledFunction {
//    class_replaceMethod([self class],NSSelectorFromString(@"swizzTest"),method_getImplementation(class_getInstanceMethod([Person class], NSSelectorFromString(@"eat"))), "v@:");

    
//    class_addMethod([self class], NSSelectorFromString(@"swizzTest"), method_getImplementation(class_getInstanceMethod([Person class], NSSelectorFromString(@"eat"))), "v@:");
//    [self swizzTest];
    Person *p = [[Person alloc] init];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [Person class];
        SEL selector = @selector(eat);
        SEL swizzledSelector = @selector(swizzTest);
        Method originalCancel = class_getInstanceMethod(class, selector);
        
        void (^swizzleBlock)(Person *) = ^(Person *slf) {
            //        [[FLEXNetworkObserver sharedObserver] connectionWillCancel:slf];
            NSLog(@"####----### observer"); //Creates a pointer to a function that calls the specified block when the method is called.
            ((void(*)(id, SEL))objc_msgSend)(slf, swizzledSelector);//其实调用的是 z啦啦啦 原来被替换的方法
        };
        
        IMP implementation = imp_implementationWithBlock(swizzleBlock);
        class_addMethod(class, swizzledSelector, implementation, method_getTypeEncoding(originalCancel));
        Method newCancel = class_getInstanceMethod(class, swizzledSelector);
        method_exchangeImplementations(originalCancel, newCancel);
    });
    
    

    [Person LogAllMethodsFromClass:nil];
    
    [p eat];
//    ((void(*)(id, SEL))objc_msgSend)(p, NSSelectorFromString(@"swizzTest"));

    
}



- (void)swizzTest{
    NSLog(@"swizzTest_swizz");
}



@end

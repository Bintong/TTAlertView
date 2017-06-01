//
//  UIScrollView+Refresh.m
//  HBFinance
//
//  Created by zftank on 16/9/13.
//  Copyright © 2016年 zftank. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "HBDragRefresh.h"
#import <objc/runtime.h>
static char refreshKey;

static char delegateKey;

@implementation UIScrollView (Refresh)

- (void)setDragRefresh:(HBDragRefresh *)dragRefresh {

    objc_setAssociatedObject(self,&refreshKey,dragRefresh,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HBDragRefresh *)dragRefresh {

    return objc_getAssociatedObject(self,&refreshKey);
}

- (void)setDragDelegate:(id)delegate {

    objc_setAssociatedObject(self,&delegateKey,delegate,OBJC_ASSOCIATION_ASSIGN);
}

- (id)dragDelegate {

    return objc_getAssociatedObject(self,&delegateKey);
}

#pragma mark -
#pragma mark Hook Dealloc

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        Class class = [self class];
        
        SEL originalSelector = sel_getUid("dealloc");
        SEL swizzledSelector = @selector(hook_dealloc);
        
        Method originalMethod = class_getInstanceMethod(class,originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class,swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,originalSelector,method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod)
        {
            class_replaceMethod(class,swizzledSelector,method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        }
        else
        {
            method_exchangeImplementations(originalMethod,swizzledMethod);
        }
    });
}

- (void)hook_dealloc {
    
    if ([self respondsToSelector:@selector(closeDragRefresh)])
    {
        [self closeDragRefresh];
    }
    
    [self hook_dealloc];
}

#pragma mark -
#pragma mark DragRefresh Methods

- (void)refresh:(id)delegate header:(BOOL)header footer:(BOOL)footer {
    
    if (self.dragRefresh)
    {
        return;
    }
    
    self.dragDelegate = delegate;
    self.dragRefresh = [HBDragRefresh refresh:self header:header footer:footer];
    self.dragRefresh.delegate = self;
}

- (void)completeLoading:(BOOL)haveMore {
    
    [self.dragRefresh completeLoading:haveMore];
}

- (void)autoDropDownAction {
    
    [self.dragRefresh autoDropDownAction];
}

- (void)closeDragRefresh {
    
    if (self.dragRefresh)
    {
        [self removeObserver:self.dragRefresh forKeyPath:kObserverKey];
        [self.dragRefresh closeDragRefresh];self.dragRefresh = nil;
    }
    
    self.dragDelegate = nil;
}

#pragma mark -
#pragma mark DragRefresh Delegate Methods

- (void)letRefreshHeaderAction {
    
    if (self.dragDelegate && [self.dragDelegate respondsToSelector:@selector(refreshDataSource:)])
    {
        [self.dragDelegate refreshDataSource:YES];
    }
}

- (void)letRefreshFooterAction {
    
    if (self.dragDelegate && [self.dragDelegate respondsToSelector:@selector(refreshDataSource:)])
    {
        [self.dragDelegate refreshDataSource:NO];
    }
}

@end

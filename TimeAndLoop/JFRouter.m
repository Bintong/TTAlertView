//
//  JFRouter.m
//  JiuFuWallet
//
//  Created by jayden on 15/12/27.
//  Copyright (c) 2015年 jayden. All rights reserved.
//

#import "JFRouter.h"
#import <objc/message.h>

@interface JFRouter ()
@property (strong, nonatomic) NSMutableDictionary *routes;
@end

@implementation JFRouter

+(instancetype)shared{
    static JFRouter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JFRouter alloc] init];
    });
    return instance;
}

- (void)map:(NSString *)route toBlock:(JFRouterBlock)block{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    subRoutes[@"_"] = [block copy];
}

- (void)map:(NSString *)route toControllerClass:(Class)controllerClass{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    subRoutes[@"_"] = controllerClass;
}

- (UIViewController *)matchController:(NSString *)route{
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    Class cls = subRoutes[@"_"];
    return [[cls alloc] init];
}

- (JFRouterBlock)matchBlock:(NSString *)route{
    
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    if (!subRoutes){
        return nil;
    }
    NSDictionary *params = [self paramsInRoute:route];
    
    JFRouterBlock routerBlock = subRoutes[@"_"];
    
    JFRouterBlock returnBlock = ^id(NSDictionary *aParams,id callback) {
        if (routerBlock) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:params];
            [dic addEntriesFromDictionary:aParams];

            return routerBlock([NSDictionary dictionaryWithDictionary:dic].copy,callback);

        }
        return nil;
    };
    
    return [returnBlock copy];
}

- (id)callBlock:(NSString *)route{
    NSDictionary *params = [self paramsInRoute:route];
    NSMutableDictionary *subRoutes = [self subRoutesToRoute:route];
    JFRouterBlock routerBlock = subRoutes[@"_"];
    if (routerBlock) {
        return routerBlock([params copy],nil);
    }
    return nil;
}
- (NSDictionary *)paramsInRoute:(NSString *)route{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSRange firstRange = [route rangeOfString:@"?"];
    if (firstRange.location != NSNotFound && route.length > firstRange.location + firstRange.length) {
        NSString *paramsString = [route substringFromIndex:firstRange.location + firstRange.length];
        NSArray *paramStringArr = [paramsString componentsSeparatedByString:@"&"];
        for (NSString *paramString in paramStringArr) {
            NSRange firstEqual = [paramString rangeOfString:@"="];
            NSString *key = [paramString substringToIndex:firstEqual.location];
            NSString *value = [paramString substringFromIndex:firstEqual.location + firstEqual.length];
            params[key] = value;
        }
    }    
    return [NSDictionary dictionaryWithDictionary:params];
}

- (NSMutableDictionary *)subRoutesToRoute:(NSString *)route{
    NSString *host = [self hostFromRoute:route];
    NSMutableDictionary *dic = self.routes[host];
    if (dic == nil) {
        dic = [NSMutableDictionary dictionary];
        self.routes[host] = dic;
    }
    return dic;
}

- (NSString *)hostFromRoute:(NSString *)route{
    NSURL *url = [NSURL URLWithString:[route stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *host = [url.host stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (host == nil) {
        NSString *singleChar = nil;
        for(int i =0; i < [route length]; i++){
            singleChar = [route substringWithRange:NSMakeRange(i, 1)];
            if ([singleChar isEqualToString:@"/"] || [singleChar isEqualToString:@"?"]) {
                host = [route substringToIndex:i];
                break;
            }
        }
        if (!host) {
            host = route;
        }
    }
    return host;
}

- (JFRouteType)canRoute:(NSString *)route{
    
    NSDictionary *subRouter = [self subRoutesToRoute:route];
    if (!subRouter) {
        return JFRouteTypeNone;
    }
    id type = subRouter[@"_"];
    if ([type isKindOfClass:UIViewController.class]) {
        return JFRouteTypeViewController;
    }else{
        return JFRouteTypeBlock;
    }
}

- (NSMutableDictionary *)routes{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return _routes;
}

@end

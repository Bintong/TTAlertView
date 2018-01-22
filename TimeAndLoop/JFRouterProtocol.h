//
//  JFRouterProtocol.h
//  JiuFuWallet
//
//  Created by jayden on 16/4/11.
//  Copyright © 2016年 jayden. All rights reserved.
//

typedef NS_ENUM (NSInteger, JFRouteType) {
    JFRouteTypeNone = 0,
    JFRouteTypeViewController = 1,
    JFRouteTypeBlock = 2
};

typedef id (^JFRouterBlock)(NSDictionary *params,id callback);

@protocol JFRouterProtocol <NSObject>


//注册
- (void)map:(NSString *)route toControllerClass:(Class)controllerClass;
- (void)map:(NSString *)route toBlock:(JFRouterBlock)block;

//取controller
- (UIViewController *)matchController:(NSString *)route;
- (JFRouterBlock)matchBlock:(NSString *)route;

//直接
- (id)callBlock:(NSString *)route;

//判断routeType
- (JFRouteType)canRoute:(NSString *)route;
@end

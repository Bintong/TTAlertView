//
//  TBNetReachability.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/23.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TBNetReachability.h"
#import <arpa/inet.h>

@implementation TBNetReachability
/// 服务器可达返回true
+ (BOOL)socketReachabilityTest {
    // 客户端 AF_INET:ipv4  SOCK_STREAM:TCP链接
    int socketNumber = socket(AF_INET, SOCK_STREAM, 0);
    // 配置服务器端套接字
    struct sockaddr_in serverAddress;
    // 设置服务器ipv4
    serverAddress.sin_family = AF_INET;
    // 百度的ip
    serverAddress.sin_addr.s_addr = inet_addr("202.108.22.5");
    // 设置端口号，HTTP默认80端口
    serverAddress.sin_port = htons(80);
    if (connect(socketNumber, (const struct sockaddr *)&serverAddress, sizeof(serverAddress)) == 0) {
        close(socketNumber);
        return true;
    }
    close(socketNumber);;
    return false;
}
@end

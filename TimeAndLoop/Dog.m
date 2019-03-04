//
//  Dog.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/3/1.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "Dog.h"

@implementation Dog

-(NSString *)barking:(NSInteger)months{
    return months > 3 ? @"wang wang!" : @"eng eng!";
}

@end

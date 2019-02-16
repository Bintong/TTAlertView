//
//  CCViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/14.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "CCViewController.h"
#import "Model_CC.h"
@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)cc_string:(id)sender {
    NSString *string1 = @"hello";
    
    NSString *str1 = [string1 copy];
    NSString *str2 = [string1 mutableCopy];
    NSLog(@"%p", string1);
    NSLog(@"%p", str1); // 不可变对象copy后指针
    NSLog(@"%p", str2);// 不可变对象mutalbeCopy后指针
    
    
    // 可变对象
    NSMutableString *mutableStr = [NSMutableString stringWithString:@"1"];
    NSMutableString *mutableStr1 = [mutableStr copy];
    NSMutableString *mutableStr2 = [mutableStr mutableCopy];
    
    NSLog(@"可变对象原始指针 %p", mutableStr);// 可变对象原始指针
    NSLog(@"%p", mutableStr1);// 可变对象copy后指针
    NSLog(@"%p", mutableStr2);// 可变对象mutalbeCopy后指针
}


- (IBAction)cc_array:(id)sender {
//
//    NSArray *arr = [NSArray arrayWithObjects:@"hello",nil];
//    NSArray *copyArr = [arr copy];
//    NSArray *mcopyArr = [arr mutableCopy];
//    NSLog(@"不可变化 array %p", arr);
//    NSLog(@"不可变化 array copy------%p", copyArr);
//    NSLog(@"不可变化 array mutableCopy------%p", mcopyArr);
//
//    NSLog(@"不可变化 array 第一元素 %p", arr[0]);
//    NSLog(@"不可变化 array copy 第一元素 %p", copyArr[0]);
//

//    NSMutableString *st  = [NSMutableString stringWithString:@"1"];
//    NSMutableArray *mutableArr=[NSMutableArray arrayWithObjects:st,nil];
//
//    NSMutableString *he  = [NSMutableString stringWithString:@"1"];
//
//    NSArray *testArr = [NSArray arrayWithObjects:he,mutableArr,nil];
//    NSArray *testArrCopy = [[NSArray alloc]initWithArray:testArr copyItems:YES];
//    // testArr和testArrCopy指针对比
//    NSLog(@"%p",testArr);
//    NSLog(@"%p",testArrCopy);
//    // testArr和testArrCopy中元素指针对比
//    // mutableString对比
//    NSLog(@"%p",testArr[0]);
//    NSLog(@"%p",testArrCopy[0]);
//    // mutableArr对比
//    NSLog(@"%p",testArr[1]);
//    NSLog(@"%p",testArrCopy[1]);
//    // mutableArr中的元素对比，即mutalbeString1对比
//    NSLog(@"%p",testArr[1][0]);
//    NSLog(@"%p",testArrCopy[1][0]);
    
//    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1",@"1", nil];
//    NSMutableArray *arr_c = [arr copy];
//    NSMutableArray *arr_c_m = [arr mutableCopy];
//    NSLog(@"%p",arr);
//    NSLog(@"%p",arr_c);
//    NSLog(@"%p",arr_c_m);
    
    
    NSMutableString *strin_1 = [NSMutableString stringWithFormat:@"1"];
    NSMutableString *strin_2 = [NSMutableString stringWithFormat:@"1"];
    NSMutableArray *arr_1 = [NSMutableArray arrayWithObjects:strin_1, nil];
    NSArray *testArr = [NSArray arrayWithObjects:strin_2,arr_1,nil];
    NSArray *testArrCopy = [NSKeyedUnarchiver unarchiveObjectWithData:
                            [NSKeyedArchiver archivedDataWithRootObject:testArr]];
    NSLog(@"%p",testArr);
    NSLog(@"%p",testArrCopy);
    // testArr和testArrCopy中元素指针对比
    // mutableString对比
    NSLog(@"%p",testArr[0]);
    NSLog(@"%p",testArrCopy[0]);
    // mutableArr对比
    NSLog(@"%p",testArr[1]);
    NSLog(@"%p",testArrCopy[1]);
    // mutableArr中的元素对比，即mutalbeString1对比
    NSLog(@"%p",testArr[1][0]);
    NSLog(@"%p",testArrCopy[1][0]);

}

- (IBAction)cc_model:(id)sender {
    Model_CC *cc = [[Model_CC alloc] init];
    Model_CC *cc_copy = [Model_CC copy];
    NSLog(@"%p", cc);
    NSLog(@"%p", cc_copy);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

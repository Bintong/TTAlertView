//
//  LeakViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/9/13.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "LeakViewController.h"
#import "Tec.h"
#import "Stu.h"


@interface LeakViewController () 
{
    Stu * _stu;
    Tec * _tec;
}
@end

@implementation LeakViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self Zombies];
    
    // Do any additional setup after loading the view.
}

- (void)blockLeak {
    //weak
    self.block = ^ {
        self.view.backgroundColor = [UIColor redColor];
    };
}
- (void)helloLeak {
 //weak
    _stu = [[Stu alloc] init];
    _tec = [[Tec alloc] init];
    _stu.tec = _tec;
    _tec.stu = _stu;
}


- (void)abandenMemory_1 {
    //1
    char *a = malloc(100*1024*1024);
    NSLog(@"%p",a);
  
}


- (void)abandenMemory_2{
    //2
    
    char *a = malloc(100*1024*1024);
    NSLog(@"%p",a);
    for (int i = 0; i< 1024*1024*3; i++) {
        a[i] = rand();
    }
}

- (void)arraryLeak {
    //weak
    NSMutableArray *arr1 = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    
    [arr1 addObject:arr2];
    [arr2 addObject:arr1];
    
}

- (void)notiLeak {
    //不会显示，内存也不会释放
    NSNotificationCenter *center =  [NSNotificationCenter defaultCenter];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [center addObserverForName:UIKeyboardDidShowNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        self.view.backgroundColor = [UIColor redColor];
    }];
}


- (void)Zombies {
    
    for( int i = 0 ;i < 10000 ;i++){
        NSString *str = [NSString stringWithFormat:@"hello -%04d", i];
        str = [str stringByAppendingString:@" - world"];
    }
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__func__);
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

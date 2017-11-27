//
//  KVOViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/21.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "KVOViewController.h"
#import "Message.h"
#import "NSObject+KVO.h"
@interface KVOViewController ()

@property(nonatomic, strong) Message *message;

@end

@implementation KVOViewController

- (void)tempHel {
    NSLog(@"helo");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake( 50, 150, 100, 100);
    [button addTarget:self action:@selector(changeMessage) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    view.center = self.view.center;
    [self.view addSubview:view];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(0, 0, 50, 50);
    [view addSubview:bt];
    bt.backgroundColor = [UIColor greenColor];
    [bt addTarget:self action:@selector(tempHel) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.message = [[Message alloc] init];
    [self.message tb_addObserver:self
                          forKey:NSStringFromSelector(@selector(text)) withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
                              NSLog(@"%@.%@ is now : %@", observedObject, observedKey,newValue);
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  NSLog(@"new text value is %@",newValue);
                              });
    }];
    
    [self changeMessage];
    // Do any additional setup after loading the view.
}

- (void)changeMessage {
    NSArray *msgs = @[@"Hello World!", @"Objective C", @"Swift", @"Peng Gu", @"peng.gu@me.com", @"www.gupeng.me", @"glowing.com"];
    NSUInteger index = arc4random_uniform((u_int32_t)msgs.count);
    self.message.text = msgs[index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

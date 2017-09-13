//
//  TaobaoVerificationController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/31.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "TaobaoVerificationController.h"

@interface TaobaoVerificationController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic, strong) UITableView *listView;
@property(nonatomic, strong) NSMutableArray *listData;
@property(nonatomic, strong) UITextField *account;
@property(nonatomic, strong) UITextField *password;

@end

@implementation TaobaoVerificationController

- (void)dealloc {
    [self resignResponder:YES];
}

- (void)tapAction:(UIGestureRecognizer *)gesture {
    
    [self resignResponder:NO];
}

- (void)resignResponder:(BOOL)clean {
    
    [self.account resignFirstResponder];
    [self.password resignFirstResponder];
    
    if (clean)
    {
        self.account.delegate = nil;
        self.password.delegate = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:gesture];
    self.title = @"淘宝验证";
    [self creatTextField];
    [self createView];
}

- (void)createView {
    
}

- (void)creatTextField {
    
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

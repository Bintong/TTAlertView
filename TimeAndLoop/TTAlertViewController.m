

//
//  TTAlertViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/3.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "TTAlertViewController.h"

@interface TTAlertViewController ()

@property (nonatomic, copy)NSString *alertTitle;
@property (nonatomic, copy)NSString *message;
@property (nonatomic, strong) NSMutableArray *actions;
@property(nonatomic, strong) UITextField *ttTextField;

@end

@implementation TTAlertViewController

- (void)dealloc {
    
}

- (id)initWithTitle:(NSString *)title andMessage:(NSString *)message andType:(int)type {
    self = [super init];
    if (self) {
        _alertTitle = title;
        _message = message;
        _actions = [NSMutableArray array];
    }
    
    return self;
}

- (void)addAction:(TTAction *)action {
    
}

- (void)show {
    UIViewController *result = [self currentController];
    [result addChildViewController:self];
    [result.view addSubview:self.view];
}

- (UIViewController *)currentController {
//    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel) {
        
    }
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

    
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60 , 155)];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5;
    alertView.layer.masksToBounds = YES;
    [self.view addSubview:alertView];
    
 
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,alertView.width, 20)];
    titleLabel.text = self.alertTitle;
    titleLabel.textColor = HB_COLOR_A;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIButton *cannelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cannelButton setTitle:@"取消" forState:UIControlStateNormal];
    cannelButton.frame = CGRectMake(0, alertView.height - 30, alertView.width/2, 30);
    [cannelButton setTitleColor:HB_COLOR_D forState:UIControlStateNormal];
    cannelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    cannelButton.tag = 100;
    [cannelButton addTarget:self action:@selector(cannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:cannelButton];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    okButton.frame = CGRectMake(alertView.width/2, alertView.height - 30, alertView.width/2, 30);
    [okButton setTitleColor:HB_COLOR_A forState:UIControlStateNormal];
    okButton.titleLabel.font = [UIFont systemFontOfSize:14];
    okButton.tag = 101;
    [okButton addTarget:self action:@selector(makeSureAction:) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:okButton];
    
    
    self.ttTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, titleLabel.bottom, SCREEN_WIDTH - 20, 20)];
  
    self.ttTextField.layer.borderColor = HB_COLOR_A.CGColor;
    self.ttTextField.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    self.ttTextField.layer.cornerRadius = 2;
//    self.ttTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
//    self.ttTextField.leftViewMode = UITextFieldViewModeAlways;
    self.ttTextField.backgroundColor = [UIColor whiteColor];
    self.ttTextField.placeholder = @"请输入各种码...";
    [alertView addSubview: self.ttTextField];
    
    
}

- (void)registerKeyBoard {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyBoardShow:(NSNotification *)info {
    NSValue *keyBoardRect = [[info userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyRect = [keyBoardRect CGRectValue];
    
}

- (void)keyBoardHidden:(NSNotification *)info {

}

- (void)makeSureAction:(id)sender {
    
}

- (void)cannelAction:(id)sender {
    
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

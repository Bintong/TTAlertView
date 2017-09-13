//
//  TextFieldViewController.m
//  TimeAndLoop
//
//  Created by BinTong on 2017/2/7.
//  Copyright © 2017年 TongBin. All rights reserved.
//

#import "TextFieldViewController.h"

@interface TextFieldViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textfield1;
@property (strong, nonatomic) IBOutlet UITextField *textfield2;
@property(nonatomic, strong) UITextField *normalTextField;
@property(nonatomic, assign) BOOL hasRead;


@end

@implementation TextFieldViewController
- (IBAction)registerAction:(id)sender {
    [self.view becomeFirstResponder];
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textfield1.delegate = self;
    self.textfield1.tag = 100;
    self.textfield2.delegate = self;
    self.textfield2.tag = 200;
    
    if ([self isPhoneNumber:@"01012456345"]){
        NSLog(@"正确");
    }else{
        NSLog(@"错误");
    }
}
- (BOOL)isPhoneNumber:(NSString *)phoneStr {
    
    if (phoneStr.length == 11)
    {
        NSScanner *scan = [NSScanner scannerWithString:phoneStr];
        
        int val;
        
        BOOL result = [scan scanInt:&val] && [scan isAtEnd];
        
        return result;
    }
    
    return NO;
}
- (BOOL)validateTelphone:(NSString*)telNum{
    
    NSString *match1 = @"^(0\\d{2,5}-)?[2-9][0-9]{6,7}(-\\d{2,5})?$"; //有0打头的2到5位区号或没有，有分机号或没有
    NSPredicate *matchTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",match1];
    BOOL isMatch1 = [matchTest1 evaluateWithObject:telNum];
    
    NSString *match2 = @"^(?!\\d+(-\\d+){3,})[48]00(-?\\d){7,10}$"; //400或800开头的号码
    NSPredicate *matchTest2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",match2];
    BOOL isMatch2 = [matchTest2 evaluateWithObject:telNum];
    
    if ( isMatch1 || isMatch2)
    {
        return TRUE;
    }
    
    return FALSE;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.normalTextField) {
        if (self.normalTextField.tag == textField.tag) {
            //点击的同一个
            if (![self.normalTextField.text isEqualToString:textField.text]) {
                NSLog(@"内容不统一更改了");
            }else {
                NSLog(@"内容统一没有更改");
            }
        }else {
            
            if (textField.text.length > 0 ) {
                //
                NSLog(@"已经有内容了");
            }else {
                if (self.normalTextField.text.length > 0) {
                    NSLog(@"从有字到没有字");
                }else {
                    NSLog(@"第一次更改");
                }
                
            }
            self.normalTextField = textField;
        }
        
    }else {
        //
        self.normalTextField = textField;
        NSLog(@"第一次更改");
    }
    
//    if (self.hasRead) {
//        NSLog(@"更改了");
//    }else {
//        NSLog(@"第一次写哦");
//    }
//    self.hasRead = YES;
//    self.normalTextField = textField;
//    NSLog(@"%s---%@",__func__,textField.text);
}
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
//    
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"%s----%@---%@",__func__,textField.text,string);
//    
//    if (textField.text.length == 0) {
//        NSLog(@"第一次写---%s",__func__);
//    }else {
//        
//    }
    
    return YES;
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

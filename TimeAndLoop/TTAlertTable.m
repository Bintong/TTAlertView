//
//  TTAlertTable.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/11/25.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "TTAlertTable.h"

static UIWindow *alertWindow = nil;

@interface TTAlertTable ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property(nonatomic, strong) NSArray *tableViewDataArray;
@property(nonatomic, strong) UITableView *tabView;
@property(nonatomic, strong) NSMutableDictionary *callBackDic;
@property(nonatomic, copy) void (^ CallBackDictionary)(NSDictionary *);


@end

@implementation TTAlertTable

+ (TTAlertTable *)sharedAlertView
{
    static TTAlertTable *alert = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        alert = [[self alloc] init];
        alert.datas = @[@{@"name":@"北京" ,@"data":@[@{@"name":@"北京市",
                                                     @"data":@[@{@"name":@"东城区"} ,@{@"name":@"朝阳区"},@{@"name":@"石景山区"},@{@"name":@"门头沟区"},@{@"name":@"通州区"},@{@"name":@"昌平区"},@{@"name":@"怀柔区"},@{@"name":@"平谷区"}]},
                                                   ]},
                        @{@"name":@"辽宁" ,@"data":@[@{@"name":@"沈阳1",
                                                      @"data":@[@{@"name":@"皇姑区"},@{@"name":@"铁西区"},@{@"name":@"于洪区"},@{@"name":@"浑南区"},@{@"name":@"和平区"}]},
                                                   @{@"name":@"沈阳2",
                                                     @"data":@[@{@"name":@"皇姑区"},@{@"name":@"铁西区"},@{@"name":@"于洪区"},@{@"name":@"浑南区"},@{@"name":@"和平区"}]},
                                                   @{@"name":@"沈阳3",
                                                     @"data":@[@{@"name":@"皇姑区"},@{@"name":@"铁西区"},@{@"name":@"于洪区"},@{@"name":@"浑南区"},@{@"name":@"和平区"}]},
                                                   @{@"name":@"沈阳4",
                                                     @"data":@[@{@"name":@"皇姑区"},@{@"name":@"铁西区"},@{@"name":@"于洪区"},@{@"name":@"浑南区"},@{@"name":@"和平区"}]},
                                                   @{@"name":@"沈阳5",
                                                     @"data":@[@{@"name":@"皇姑区"},@{@"name":@"铁西区"},@{@"name":@"于洪区"},@{@"name":@"浑南区"},@{@"name":@"和平区"}]},]}];
        alert.tableViewDataArray = [NSArray array];
        alert.tableViewDataArray = alert.datas;
    });
    return alert;
    
}

+ (void)buildWindow {
    alertWindow = [[UIWindow alloc]initWithFrame:SCREEN_BOUNDS];
    alertWindow.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    alertWindow.autoresizesSubviews = YES;
    alertWindow.hidden = NO;
    alertWindow.windowLevel = 100+ UIWindowLevelStatusBar;
    [alertWindow makeKeyAndVisible];
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[TTAlertTable sharedAlertView] action:@selector(dismiss)];
    tap.delegate = [TTAlertTable sharedAlertView];
    [alertWindow addGestureRecognizer:tap];
    
}

+ (void)showTableAlertWithCallBack:(void (^)(NSDictionary *))callBackDictionary {
    [TTAlertTable buildWindow];
    UITableView *tabView = [[UITableView alloc ]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 44*7, SCREEN_WIDTH - 30, 44*7)];
    tabView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2-20);
    tabView.backgroundColor = [UIColor whiteColor];
    tabView.layer.cornerRadius = 5;
    tabView.layer.masksToBounds = YES;
    tabView.rowHeight = 44;
    tabView.delegate = [TTAlertTable sharedAlertView];
    tabView.dataSource = [TTAlertTable sharedAlertView];
    [TTAlertTable sharedAlertView].tabView = tabView;
    [TTAlertTable beginAnimation:tabView dur:0.1];
    [alertWindow addSubview:tabView];
    [TTAlertTable sharedAlertView].CallBackDictionary = callBackDictionary;
    
    
}



+ (void)beginAnimation:(UIView *)outView dur:(CFTimeInterval)dur {
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = dur;
    animation.repeatCount = 1;
    animation.autoreverses = YES; // 动画结束时执行逆动画
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:1.05];
    [outView.layer addAnimation:animation forKey:@"scale-layer"];
    animation.removedOnCompletion = NO;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CMainCell = @"CMainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier: CMainCell];
    }
    
    id dic = [self.tableViewDataArray objectAtIndex:indexPath.row];
    if ([dic  isKindOfClass:[NSDictionary class]]) {
        cell.textLabel.text = dic[@"name"];
    } else {
        cell.textLabel.text = @"格式不对";

    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.tableViewDataArray[indexPath.row];
    if (self.callBackDic == nil) {
        self.callBackDic = [NSMutableDictionary dictionary];
        [self.callBackDic setObject:dic[@"name"] forKey:@"sheng"];
    }else if(![self.callBackDic objectForKey:@"shi"]){
        [self.callBackDic setObject:dic[@"name"] forKey:@"shi"];
    }else if(![self.callBackDic objectForKey:@"qu"]){
        [self.callBackDic setObject:dic[@"name"] forKey:@"qu"];
        self.CallBackDictionary(self.callBackDic);
        [self dismiss];
        return;
    }
    self.tableViewDataArray = dic[@"data"];
    [self.tabView reloadData];
    
}

- (void)dismiss {
    dispatch_async(dispatch_get_main_queue(),^{
        for (UIView *subView in alertWindow.subviews) {
            [subView removeFromSuperview];
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [UIView animateWithDuration:0.4 animations:^{
            alertWindow.layer.opacity = 0;
        } completion:^(BOOL finished) {
            [alertWindow resignKeyWindow];
            alertWindow.windowLevel = UIWindowLevelNormal;
            [[[UIApplication sharedApplication] delegate].window makeKeyAndVisible];
            alertWindow = nil;
            self.callBackDic = nil;
            self.CallBackDictionary = nil;
        }];
    });
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.tabView]) {
        return NO;
    }else {
        return YES;
    }
}

- (void)dealloc {
    
}

@end

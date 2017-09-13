//
//  PersonInfoController.m
//  TimeAndLoop
//
//  Created by BinTong on 2016/10/25.
//  Copyright © 2016年 TongBin. All rights reserved.
//

#import "PersonInfoController.h"
#import "PersonInfoCell.h"

@interface PersonInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listView;
@property (nonatomic, strong) NSArray *leftTitles;
@property (nonatomic, strong) NSMutableDictionary *placeValueDictionary;
@property(nonatomic, assign) BOOL listViewScrolled;

@end

@implementation PersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料填写";
    self.leftTitles = @[@"婚姻状况",@"所在省份",@"所在城市",@"所在区",@"居住地址",@"月收入范围",@"单位名称",@"姓名",@"电话",@"关系",];
    self.placeValueDictionary = [NSMutableDictionary dictionary];
    self.view.backgroundColor = HB_COLOR_G;
    
    [self createView];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"hight_hitht:%f",kbSize.height);
    if (!self.listViewScrolled) {
        self.listView.top -= kbSize.height;
        self.listViewScrolled = YES;
    }
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification{
    NSDictionary *info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSLog(@"hight_hitht:%f",kbSize.height);
    if (self.listViewScrolled) {
        self.listViewScrolled = NO;
        self.listView.top += kbSize.height;
    }
    
}


- (void)createView {
    self.listView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.listView.backgroundColor = [UIColor clearColor];
    self.listView.rowHeight = 44;
    self.listView.delegate = self;
    self.listView.dataSource = self;
    [self.view addSubview:self.listView];
    
    //header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
    header.backgroundColor = HB_COLOR_A;
    self.listView.tableHeaderView = header;
    
    //footer
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
    footer.backgroundColor = [UIColor clearColor];
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = CGRectMake(15,(footer.height - 44)/2, SCREEN_WIDTH - 30, 44);
    [bt setTitle:@"保持个人资料" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(savePersonInfo:) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor = HB_COLOR_A;
    [footer addSubview:bt];
    self.listView.tableFooterView = footer;
}

- (void)savePersonInfo: (id)sender {
    NSLog(@"保存个人资料");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 7;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CMainCell = @"CMainCell";
    
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = (PersonInfoCell *)[[PersonInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMainCell];
    }
    
//    cell.control = self;
    
    
    NSString *key;
    if (indexPath.section == 0) {
        key = [NSString stringWithFormat:@"%ld",101+indexPath.row];
        NSString *value = [self.placeValueDictionary objectForKey:key];
        NSLog(@"textfiled输入后的文字 %@",value);
        [cell buildCellContent:[self.placeValueDictionary objectForKey:key]
                  andLeftTitle:self.leftTitles[indexPath.row]
                     showArrow:(!(indexPath.row == 4 || indexPath.row == 6))
                     indexPath:indexPath];
    }else {
        key = [NSString stringWithFormat:@"%ld",201+indexPath.row];
        NSString *value = [self.placeValueDictionary objectForKey:key];
        NSLog(@"textfiled输入后的文字 %@",value);
        [cell buildCellContent:value
                  andLeftTitle:self.leftTitles[indexPath.row + 7]
                     showArrow:(indexPath.row == 2)
                     indexPath:indexPath];
    }
    
    return cell;
}

#pragma mark - delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15, 8, 300, 22);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = HB_COLOR_D;
    label.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    // Create header view and add label as a subview
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    [sectionView setBackgroundColor:HB_COLOR_G];
    [sectionView addSubview:label];
    
    if (section == 0) {
        label.text = @"基本资料";
    }else {
        label.text = @"常用联系人";
    }
    return sectionView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"选择了 %ld" , (long)indexPath.row);
    if (indexPath.section == 0) {
        
    }else {
        
    }
}

#pragma mark - TextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"输入的文字是%@",textField.text);
     UITableViewCell *cell  = (UITableViewCell *)[[textField superview] superview];
    NSIndexPath *indexPath = [self.listView indexPathForCell:cell];
    NSString *key;

    if (indexPath.section == 0) {
        key = [NSString stringWithFormat:@"%ld",101+indexPath.row];
        
    }else {
        key = [NSString stringWithFormat:@"%ld",201+indexPath.row];
    }
    [self.placeValueDictionary setValue:textField.text forKey:key];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

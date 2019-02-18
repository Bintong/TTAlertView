//
//  TextureDemoController.m
//  TimeAndLoop
//
//  Created by BinTong on 2019/2/11.
//  Copyright © 2019 TongBin. All rights reserved.
//

#import "TextureDemoController.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "TeureModel.h"
#import "TexureCellNode.h"
@interface TextureDemoController ()<ASTableDelegate, ASTableDataSource>

@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) NSMutableArray *modalArray;

@end

@implementation TextureDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    [self addTableNode];

    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews {
    self.tableNode.frame = self.view.bounds;
}

- (void)loadData {
    _modalArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];

}

- (void)addTableNode {
    self.tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    self.tableNode.backgroundColor = [UIColor whiteColor];
    self.tableNode.view.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubnode:self.tableNode];
    self.tableNode.delegate = self;
    self.tableNode.dataSource = self;
}

- (NSInteger)tableNode:(ASTableNode *)tableNode numberOfRowsInSection:(NSInteger)section {
    return self.modalArray.count;
}

- (ASCellNodeBlock)tableNode:(ASTableNode *)tableNode nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    TeureModel *m = [[TeureModel alloc] init];
    m.title = self.modalArray[indexPath.row];

    m.imgUrlName = self.modalArray[indexPath.row];
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *() {
        TexureCellNode *cellNode = [[TexureCellNode alloc] initWithModel:m];
        return cellNode;
    };
    
    return cellNodeBlock;
}

- (ASSizeRange)tableView:(ASTableView *)tableView constrainedSizeForRowAtIndexPath:(NSIndexPath *)indexPath {

    return  ASSizeRangeMake(CGSizeMake([UIScreen mainScreen].bounds.size.width, 300));
}

- (BOOL)shouldBatchFetchForTableNode:(ASTableNode *)tableNode {
    return YES;
}

- (void)tableView:(ASTableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context {
    [self retrieveNextPageWithCompletion:^(NSArray *animals) {
        [self insertNewRowsInTableView:animals];
        [context completeBatchFetching:YES];
    } ];
}


- (void)retrieveNextPageWithCompletion:(void (^)(NSArray *))block {
//    NSArray *moreAnimals = [[NSArray alloc] initWithArray:[self.modalArray subarrayWithRange:NSMakeRange(0, 10)] copyItems:NO];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        block(moreAnimals);
//
//    });
}

- (void)insertNewRowsInTableView:(NSArray *)newAnimals {
//    NSInteger oldCount = self.modalArray.count;
    [self.modalArray addObjectsFromArray:newAnimals];
//    [self.tableNode insertRowWithStart:oldCount NewCount:self.modalArray.count];
    [self.tableNode insertRowsAtIndexPaths:newAnimals withRowAnimation:0];
    
}

@end

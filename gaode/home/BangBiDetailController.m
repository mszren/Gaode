//
//  BangBiDetailController.m
//  gaode
//
//  Created by 我 on 15/11/5.
//  Copyright © 2015年 我. All rights reserved.
//

#import "BangBiDetailController.h"
#import "EGOTableView.h"
#import "BangBiCell.h"

@interface BangBiDetailController () <EGOTableViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) EGOTableView* tableView;
@end

@implementation BangBiDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"帮币明细"];
    [self initView];
}

- (void)initView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    [_tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_tableView tableViewDidEndDragging:scrollView];
}

- (NSDate*)pullingTableViewRefreshingFinishedDate
{
    
    return [NSDate date];
}

- (NSDate*)pullingTableViewLoadingFinishedDate
{
    
    return [NSDate date];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 9;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString* cellid = @"BangBiCell";
    BangBiCell* bangBiCell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!bangBiCell) {
        bangBiCell = [[BangBiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        bangBiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        bangBiCell.backgroundColor = GREEN_COLOR;
    }
    
    return bangBiCell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

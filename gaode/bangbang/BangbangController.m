//
//  BangbangController.m
//  gaode
//
//  Created by 我 on 15/10/27.
//  Copyright © 2015年 我. All rights reserved.
//

#import "BangbangController.h"
#import "Masonry.h"
#import "EGOTableView.h"
#import "BangCell.h"
#import "BangQuestionController.h"
#import "BangbangDetailController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface BangbangController ()<EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation BangbangController{
    
    EGOTableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"帮帮"];
    [self initView];
}

-(void)initView{
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed: @"actionbar_btn_scan"] style:UIBarButtonItemStyleDone target:self action:@selector(onRightItem:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight) style:UITableViewStylePlain];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.emptyDataSetSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    [self.view addSubview:_tableView];
    
}

#pragma mark EGOTableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BangIdentifier";
    BangCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[BangCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor grayColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BangbangDetailController *bangDetailVc = [BangbangDetailController new];
    bangDetailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bangDetailVc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 205;
}

- (NSDate*)pullingTableViewRefreshingFinishedDate
{
    return [NSDate date];
}
- (NSDate*)pullingTableViewLoadingFinishedDate
{
    return [NSDate date];
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    [_tableView tableViewDidScroll:scrollView];

}
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [_tableView tableViewDidEndDragging:scrollView];
}

#pragma mark -- UIBarButtonItem Action
-(void)onRightItem:(UIBarButtonItem *)sender{
    BangQuestionController *quVc = [BangQuestionController new];
    quVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:quVc animated:YES];
}

#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无状态哦!";
    [_tableView hideFooterViewAndHeadViewState];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor blackColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}

-(UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIImage imageNamed:@"ic_tywnr"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

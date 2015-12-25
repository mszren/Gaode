//
//  GrouthTreeController.m
//  gaode
//
//  Created by 我 on 15/11/2.
//  Copyright © 2015年 我. All rights reserved.
//

#import "GrouthTreeController.h"
#import "EGOTableView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "GrouthTreeCell.h"
#import "GrouthTreeHeaderView.h"
#import "SelectPublicView.h"
#import "Header.h"
#import "BaseNavController.h"
#import "GrouthTreeDetailController.h"

@interface GrouthTreeController () <EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic, strong) EGOTableView* tableView;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UIButton *publishBtn;

@end

@implementation GrouthTreeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT - 18) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundView = nil;
   
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 0, 23, 24);
    _backBtn.center = CGPointMake(22, 35);
    [_backBtn setImage:[UIImage imageNamed:@"btn_back_bs"] forState:UIControlStateNormal];
    _backBtn.tag = 100;
    [self.view addSubview:_backBtn];
    _backBtn .adjustsImageWhenHighlighted = NO;
    [_backBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _publishBtn.frame = CGRectMake(0, 0, 24, 24);
    _publishBtn.center = CGPointMake(SCREEN_WIDTH - 22, 35);
    [_publishBtn setImage:[UIImage imageNamed:@"btn_kanzhe_fabu"] forState:UIControlStateNormal];
    _publishBtn.adjustsImageWhenHighlighted = NO;
    _publishBtn.tag = 200;
    [self.view addSubview:_publishBtn];
    [_publishBtn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    
    return 2;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    static NSString* cellid = @"grouthCell";
    GrouthTreeCell* grouthCell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!grouthCell) {
        grouthCell = [[GrouthTreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        grouthCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
 
    return grouthCell;
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString* headerReuseIdentifier = @"HeaderReuseIdentifier";
    GrouthTreeHeaderView* headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    if (!headerView) {
        headerView = [[GrouthTreeHeaderView alloc] initWithReuseIdentifier:headerReuseIdentifier];
        headerView.viewController = self;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 220;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 350;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GrouthTreeDetailController *detailVc = [GrouthTreeDetailController new];
    detailVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVc animated:YES];
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

- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)onBtn:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
            
        default:{
            
            [[SelectPublicView sharedInstance] showSelectPublicView:self.navigationController];
        }
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

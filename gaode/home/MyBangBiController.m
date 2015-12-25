//
//  MyBangBiController.m
//  gaode
//
//  Created by 我 on 15/11/5.
//  Copyright © 2015年 我. All rights reserved.
//

#import "MyBangBiController.h"
#import "Header.h"
#import <Masonry.h>
#import "EGOTableView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "BangBiCell.h"
#import "BangBiDetailController.h"

@interface MyBangBiController () <EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic, strong) EGOTableView* tableView;
@end

@implementation MyBangBiController{
    
    UIView *_backgroundView;
    UILabel *_bangBiLabel;
    UIButton *_bangBiBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initializeWhiteBackgroudView:@"我的帮币"];
    [self initView];
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)initView{
    
    _backgroundView = [UIView new];
    [self.view addSubview:_backgroundView];
    [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0.5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 160));
    }];
    _backgroundView.backgroundColor = [UIColor whiteColor];
    
    UILabel *greenLabel = [UILabel new];
    [_backgroundView addSubview:greenLabel];
    [greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(2,15));
    }];
    greenLabel.backgroundColor = [UIColor greenColor];
    
    UILabel *currentLabel = [UILabel new];
    [_backgroundView addSubview:currentLabel];
    [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.top.mas_equalTo(22);
        make.size.mas_equalTo(CGSizeMake(60, 13));
    }];
    currentLabel.text = @"当前帮币";
    currentLabel.font = [UIFont systemFontOfSize:13];
    
    _bangBiLabel = [UILabel new];
    [_backgroundView addSubview:_bangBiLabel];
    [_bangBiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH - 100)/2);
        make.top.mas_equalTo(80);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    _bangBiLabel.text = @"2,300";
    _bangBiLabel.textColor = GREEN_COLOR;
    _bangBiLabel.textAlignment = NSTextAlignmentCenter;
    _bangBiLabel.font = [UIFont systemFontOfSize:23];
    
    _bangBiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backgroundView addSubview:_bangBiBtn];
    [_bangBiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((SCREEN_WIDTH - 120)/2);
        make.top.mas_equalTo(110);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    [_bangBiBtn setTitle:@"帮币明细" forState:UIControlStateNormal];
    _bangBiBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_bangBiBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _bangBiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 10);
    _bangBiBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 15, 5, 15);
    [_bangBiBtn setImage:[UIImage imageNamed:@"ic_wojia_fangdajing"] forState:UIControlStateNormal];
    _bangBiBtn.adjustsImageWhenHighlighted = NO;
    _bangBiBtn.layer.cornerRadius = 15;
    _bangBiBtn.backgroundColor = GREEN_COLOR;
    _bangBiBtn.clipsToBounds = YES;
    _bangBiBtn.layer.shouldRasterize = YES;
    [_bangBiBtn addTarget:self action:@selector(onDetailBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *noteLabel = [UILabel new];
    [self.view addSubview:noteLabel];
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(160.5);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    noteLabel.text = @"兑换记录";
    noteLabel.font = [UIFont systemFontOfSize:13];
    
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT - 264) style:UITableViewStyleGrouped];
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
    
    static NSString* cellid = @"myBangBiCell";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
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

#pragma mark -- UIButton Action
- (void)onDetailBtn:(UIButton *)sender{
    
    BangBiDetailController *bangVc = [BangBiDetailController new];
    bangVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bangVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

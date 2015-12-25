//
//  ShaishaiViewController.m
//  gaode
//
//  Created by 我 on 15/10/10.
//  Copyright (c) 2015年 我. All rights reserved.
//

#import "ShaishaiViewController.h"
#import "SegmentBarView.h"
#import "Header.h"
#import "EGOTableView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "PublicCell.h"
#import "SelectPublicView.h"
#import "GrouthTreeDetailController.h"

@interface ShaishaiViewController () <SegmentBarViewDelegate,EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation ShaishaiViewController{
    
    SegmentBarView *_barView;
    UIBarButtonItem *_rightBtn;
    EGOTableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initView];
   
}

- (void)initView{
    
    _barView = [[SegmentBarView alloc]
                initWithFrame:CGRectMake(0, 0, 80, 40)
                andItems:@[ @"广场", @"社区"]];
    _barView.clickDelegate = self;
    [_barView setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.titleView = _barView;
    
    _rightBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"actionbar_btn_scan"] style:UIBarButtonItemStylePlain target:self action:@selector(onRightBtn:)];
    
    _tableView = [[EGOTableView alloc]
                  initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,
                                           SCREEN_HEIGHT - 113)
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.pullingDelegate = self;
    _tableView.autoScrollToNextPage = NO;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}


#pragma mark EGOTableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_barView.selectedIndex == 0) {
        return 3;
    }else
        
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_barView.selectedIndex == 0) {
        
        static NSString *publicIdentifier = @"publicIdentifier";
        PublicCell *publicCell = [tableView dequeueReusableCellWithIdentifier:publicIdentifier];
        if (!publicCell) {
            publicCell = [[PublicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:publicIdentifier];
            publicCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return publicCell;
    }else{
        
        static NSString *communityIdentifier = @"communityIdentifier";
        PublicCell *communityCell = [tableView dequeueReusableCellWithIdentifier:communityIdentifier];
        if (!communityCell) {
            communityCell = [[PublicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:communityIdentifier];
            communityCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return communityCell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GrouthTreeDetailController *grouthDetailVc = [GrouthTreeDetailController new];
    [self.navigationController pushViewController:grouthDetailVc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 380.5;
}

- (NSDate*)pullingTableViewRefreshingFinishedDate
{
    return [NSDate date];
}
- (NSDate*)pullingTableViewLoadingFinishedDate
{
    return [NSDate date];
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


#pragma mark SegmentBarViewDelegate
- (void)barSelectedIndexChanged:(int)newIndex{
    switch (newIndex) {
        case 0:
            self.navigationItem.rightBarButtonItem = nil;
            break;
            
        default:
            self.navigationItem.rightBarButtonItem = _rightBtn;
            break;
    }
    [_tableView reloadData];
}

- (void)scrollOffsetChanged:(CGPoint)offset{
    int page = offset.x/SCREEN_WIDTH;
    [_barView setSelectedIndex:page];
}

#pragma mark -- UIBarButtonItem Action
- (void)onRightBtn:(UIBarButtonItem *)sender{
    
    [[SelectPublicView sharedInstance] showSelectPublicView:self.navigationController];
}

#pragma mark
#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    [_tableView hideFooterViewAndHeadViewState];
    NSString *text;
    switch (_barView.selectedIndex) {
        case 0:
            
            text = @"没有活动哦!";
            break;
        case 1:
            
            text = @"没有活动哦!";
            break;
            
        default:
            break;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                                 NSForegroundColorAttributeName: [UIColor greenColor]};
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

//
//  MyShaiShaiController.m
//  gaode
//
//  Created by 我 on 15/11/6.
//  Copyright © 2015年 我. All rights reserved.
//

#import "MyShaiShaiController.h"
#import "Header.h"
#import "EGOTableView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "PublicCell.h"
#import "SelectPublicView.h"
#import "GrouthTreeDetailController.h"

@interface MyShaiShaiController () <EGOTableViewDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@property (nonatomic, strong) EGOTableView* tableView;
@end

@implementation MyShaiShaiController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initView];
}

- (void)initView{
    
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight) style:UITableViewStylePlain];
    _tableView.backgroundView = nil;
    _tableView.dataSource = self;
    _tableView.delegate = self;
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
    
    static NSString *publicIdentifier = @"publicIdentifier";
    PublicCell *publicCell = [tableView dequeueReusableCellWithIdentifier:publicIdentifier];
    if (!publicCell) {
        publicCell = [[PublicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:publicIdentifier];
        publicCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return publicCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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

#pragma mark
#pragma mark DZNEmptyDataSetDelegate,DZNEmptyDataSetSource
-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    [_tableView hideFooterViewAndHeadViewState];
    NSString *text = @"没有活动哦!";
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

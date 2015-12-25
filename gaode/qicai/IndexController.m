//
//  IndexController.m
//  gaode
//
//  Created by 我 on 15/10/29.
//  Copyright © 2015年 我. All rights reserved.
//

#import "IndexController.h"
#import "EGOTableView.h"
#import "IndexCell.h"

@interface IndexController () <EGOTableViewDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation IndexController{
    
    EGOTableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setWhiteNavBg];
    [self initView];

}

-(void)initView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[EGOTableView alloc] initWithFrame:CGRectMake(0, 1, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarHeight) style:UITableViewStylePlain];
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
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"BangIdentifier";
    IndexCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[IndexCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 231;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 

@end
